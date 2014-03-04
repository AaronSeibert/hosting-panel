class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    if params[:client_id].blank?
      @subscriptions = Subscription.all
    else
      @subscriptions = Client.find(params[:client_id]).subscriptions
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit

  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    if (!@subscription.quantity)
      @subscription.quantity = 1
    end

    respond_to do |format|
      if @subscription.save
        
        if params[:subscription][:bill_now] == 1
        # Create the pro-rated charge
          begin
            Stripe::InvoiceItem.create(
              :customer => @subscription.client.stripe_customer_id,
              :amount => (@subscription.plan.prorated_charge*100*@subscription.quantity).floor,
              :currency => "usd",
              :description => @subscription.plan.description + " - " + @subscription.description + " - Pro-rated Charge"
            )
            invoice = Stripe::Invoice.create(
              :customer => @subscription.client.stripe_customer_id
            )
            invoice.pay
            @subscription.last_invoiced = Date.today
            @subscription.save
          rescue Exception => exc
            logger.error("Oh no! There was an error adding the invoice item: #{exc.message}")
          end
        end
    
        format.html { redirect_to subscriptions_url, success: 'Subscription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subscription }    
      else  
        format.js   { render action: 'new' }
        format.html { render action: 'new' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    
    # TODO: Modify subscription (refund remainder of current, prorate new)
    
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscriptions_url, success: 'Subscription was successfully updated.' }
        format.json { head :no_content }
        format.js   { redirect_to subscriptions_url, :format => :html, success: 'Subscription was successfully updated.' }
      else
        format.html { render action: 'edit' }
        format.js   { render action: 'edit' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:client_id, :description, :plan_id, :primary_domain_id, :quantity, :next_bill_date, :bill_now,
        :domains_attributes => [:id, :subscription_id, :url, :ssl_enabled]
      )
    end
end
