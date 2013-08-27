class Plan < ActiveRecord::Base
  
  
  def self.get_remote_plans
    @plans = Stripe::Plan.all
    
    i = 0
    num = @plans.count()
    p = Hash.new
    while i < num do
      
      h = { @plans.data[i].id => {:price => @plans.data[i].amount, :description => @plans.data[i].name}}
      
      p.merge!(h)

      i = i + 1
    end
    return p
  end
  
  def self.sync_remote
    @remote = self.get_remote_plans
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
        l[:price] = r[:price]
        puts "Adding remote description to plan: #{r[:description]}"
        l[:description] = r[:name]
        if l.save
          puts "Plan saved successfully."
        end
      end
    end
  end
end
