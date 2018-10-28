class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /memories
  # GET /memories.json
  def index
    @memories = Memory.ordered_by_attributes.where(user_id: current_user.id)
  end

  # GET /memories/1
  # GET /memories/1.json
  def show
  end

  # GET /memories/new
  def new
    request.env['HTTP_X_REAL_IP'] = '164.41.4.26' if Rails.env.development?
    @memory = Memory.new(weather: get_weather, local: request.location.city)
  end

  # GET /memories/1/edit
  def edit
  end

  # POST /memories
  # POST /memories.json
  def create
    @memory = Memory.new(memory_params)
    @memory.user = current_user

    respond_to do |format|
      if @memory.save
        format.html { redirect_to @memory, notice: 'Memory was successfully created.' }
        format.json { render :show, status: :created, location: @memory }
      else
        format.html { render :new }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memories/1
  # PATCH/PUT /memories/1.json
  def update
    respond_to do |format|
      if @memory.update(memory_params)
        format.html { redirect_to @memory, notice: 'Memory was successfully updated.' }
        format.json { render :show, status: :ok, location: @memory }
      else
        format.html { render :edit }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memories/1
  # DELETE /memories/1.json
  def destroy
    @memory.destroy
    respond_to do |format|
      format.html { redirect_to memories_url, notice: 'Memory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_memory
    @memory = Memory.find(params[:id])
  end

  def memory_params
    params.require(:memory).permit(:description, :date, :weather, :local, :user_id)
  end

  def get_weather
    lat = request.location.coordinates[0]
    lon = request.location.coordinates[1]
    response = RestClient.get(
      "api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&APPID=13f011f2cc8ad799fba2ffa35d99a50f"
    )
    (JSON.parse(response.body)['weather'].first['description']).capitalize
  end
end
