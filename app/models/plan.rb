class Plan < ActiveRecord::Base
  has_many :sites
  
  def self.intervals
    return ["month", "biannual", "annual"]
  end
  
  def self.get_stripe_plans
    @plans = Stripe::Plan.all
    
    i = 0
    num = @plans.count()
    p = Hash.new
    while i < num do
      
      h = { @plans.data[i].id => {:price => @plans.data[i].amount, :description => @plans.data[i].name, :interval => @plans.data[i].interval, :interval_count => @plans.data[i].interval_count}}
      
      p.merge!(h)

      i = i + 1
    end
    return p
  end
  
  def self.sync_stripe
    @remote = self.get_stripe_plans
    @local = Plan.all

    @remote.keys.each do |k|
      if @local.exists?(:remote_id => k)
        puts "Remote plan already exists locally."
      else
        r = @remote[k]
        puts "Creating local plan #{k}."
        l = Plan.new
        l[:remote_id] = k
        puts "Adding remote price to plan: #{r[:price]}"
        l[:price] = r[:price]/100
        puts "Adding remote description to plan: #{r[:description]}"
        l[:description] = r[:description]
        puts "Adding remote interval to plan: #{r[:interval_count]} #{r[:interval]}"
        l[:interval_count] = r[:interval_count]
        l[:interval] = r[:interval]
        if l.save
          puts "Plan saved successfully."
        end
      end
    end
  end
end
