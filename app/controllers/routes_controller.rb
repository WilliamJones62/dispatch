class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  def index
    if user_signed_in? && current_user.dispatch
      @routes = Route.all
    else
      redirect_to signout_path and return
    end
  end

  # GET /routes/1
  def show
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  def create
    rp = route_params
    rp[:badge] = current_user.email
    @route = Route.new(rp)
    respond_to do |format|
      if @route.save
        format.html { redirect_to routes_url, notice: 'Route was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /routes/1
  def update
    rp = route_params
    rp[:badge] = current_user.email
    respond_to do |format|
      if @route.update(rp)
        format.html { redirect_to routes_url, notice: 'Route was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /routes/1
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:route_code, :truck, :driver, :route_date, :user_id, :badge)
    end
end
