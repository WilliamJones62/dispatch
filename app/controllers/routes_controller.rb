class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  before_action :build_truck_data, only: [:new, :create, :edit, :update]

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
    @new = true
    @returned_flag = false
    @route = Route.new
    @tablet = @tablets[0].gsub('~', ' ')
    @ez_pass = @ez_passes[0].gsub('~', ' ')
    @wexcard = @wexcards[0].gsub('~', ' ')
    @temp_text = 'No temperature logger required'
    if @temp_statuses[0].gsub('~', ' ') != 'ACTIVE' || @temp_verifieds[0] == false
      @temp_text = 'Issue a temperature logger'
    end
  end

  # GET /routes/1/edit
  def edit
    @new = false
    array_index = @trucks.index(@route.truck)
    @tablet = @tablets[array_index].gsub('~', ' ')
    @ez_pass = @ez_passes[array_index].gsub('~', ' ')
    @wexcard = @wexcards[array_index].gsub('~', ' ')
    @temp_text = 'No temperature logger required'
    if @temp_statuses[array_index] != 'ACTIVE' || @temp_verifieds[array_index] == false
      @temp_text = 'Issue a temperature logger'
    end
  end

  # POST /routes
  def create
    rp = route_params
    rp[:badge] = current_user.email
    @route = Route.new(rp)

    respond_to do |format|
      if @route.save
        @log = DispatchLog.new
        @log.route_code = @route.route_code
        @log.truck = @route.truck
        @log.driver = @route.driver
        @log.badge = @route.badge
        @log.issued_flag = @route.issued_flag
        @log.returned_flag = @route.returned_flag
        array_index = @trucks.index(@route.truck)
        @tablet = @tablets[array_index].gsub('~', ' ')
        @ez_pass = @ez_passes[array_index].gsub('~', ' ')
        @wexcard = @wexcards[array_index].gsub('~', ' ')
        @log.wexcard = @wexcard
        @log.ez_pass = @ez_pass
        @log.tablet = @tablet
        @log.save
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
    if rp[:issued_flag]
      rp[:returned_flag] = false
    end
    if rp[:returned_flag]
      rp[:issued_flag] = false
    end
    respond_to do |format|
      if @route.update(rp)
        @log = DispatchLog.new
        @log.route_code = @route.route_code
        @log.truck = @route.truck
        @log.driver = @route.driver
        @log.badge = @route.badge
        @log.issued_flag = @route.issued_flag
        @log.returned_flag = @route.returned_flag
        array_index = @trucks.index(@route.truck)
        @tablet = @tablets[array_index].gsub('~', ' ')
        @ez_pass = @ez_passes[array_index].gsub('~', ' ')
        @wexcard = @wexcards[array_index].gsub('~', ' ')
        @log.wexcard = @wexcard
        @log.ez_pass = @ez_pass
        @log.tablet = @tablet
        @log.save
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

    def build_truck_data
      @trucks = []
      trucks = Truck.where(start_decommission: false)
      trucks.each do |t|
        @trucks.push(t.truck_number.gsub(' ', '~'))
      end
      @trucks.sort!
      @tablets = []
      @wexcards = []
      @ez_passes = []
      @temp_statuses = []
      @temp_verifieds = []
      @trucks.each do |t|
        hardware = Hardware.find_by owner: t.gsub('~', ' ')
        truck = Truck.find_by truck_number: t.gsub('~', ' ')
        truck_finance = truck.truck_finances.first
        truck_it = truck.truck_its.first
        if !hardware.blank?
          @tablets.push(hardware.serial_number.gsub(' ', '~'))
        else
          @tablets.push('~')
        end
        if !truck_finance.blank?
          @wexcards.push(truck_finance.wexcard.gsub(' ', '~'))
          @ez_passes.push(truck_finance.ez_pass.gsub(' ', '~'))
        else
          @wexcards.push('~')
          @ez_passes.push('~')
        end
        if !truck_it.blank?
          @temp_statuses.push(truck_it.temp_status.gsub(' ', '~'))
          @temp_verifieds.push(truck_it.temp_verified)
        else
          @temp_statuses.push('~')
          @temp_verifieds.push('~')
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:route_code, :truck, :driver, :user_id, :badge, :issued_flag, :returned_flag)
    end
end
