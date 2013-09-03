class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    if params[:client_id].blank?
      @sites = Site.all
    else
      @sites = Client.find(params[:client_id]).sites
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @client = Client.find(params[:client_id])
    @site = @client.sites.build
    @site.domains.build
  end

  # GET /sites/1/edit
  def edit
    @site.domains.build unless not @site.domains.empty?
    @client = @site.client
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    # TODO add saving subscription to stripe

    respond_to do |format|
      if @site.save
        
        # Add this site to our subscriptions model
        @subscription = @site.client.subscriptions.build 
        @subscription.plan = @site.plan
        @subscription.next_bill_date = @site.plan.next_bill_date
        @subscription.site = @site
        @subscription.save
    
        format.html { redirect_to clients_url, success: 'Site was successfully created.' }
        format.json { render action: 'show', status: :created, location: @site }
      else  
        @client = Client.find(@site.client_id)
        format.js   { render action: 'new' }
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to sites_url, success: 'Site was successfully updated.' }
        format.json { head :no_content }
        format.js   { redirect_to sites_url, :format => :html, success: 'Site was successfully updated.' }
      else
        format.html { render action: 'edit' }
        format.js   { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:client_id, :description, :plan_id, :primary_domain_id, 
        :domains_attributes => [:id, :site_id, :url, :ssl_enabled]
      )
    end
end
