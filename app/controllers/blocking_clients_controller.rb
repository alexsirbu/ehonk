class BlockingClientsController < ApplicationController
  # GET /blocking_clients
  # GET /blocking_clients.json
  def index
    @blocking_clients = BlockingClient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blocking_clients }
    end
  end

  # GET /blocking_clients/1
  # GET /blocking_clients/1.json
  def show
    @blocking_client = BlockingClient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blocking_client }
    end
  end

  # GET /blocking_clients/new
  # GET /blocking_clients/new.json
  def new
    @blocking_client = BlockingClient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blocking_client }
    end
  end

  # GET /blocking_clients/1/edit
  def edit
    @blocking_client = BlockingClient.find(params[:id])
  end

  # POST /blocking_clients
  # POST /blocking_clients.json
  def create
    @blocking_client = BlockingClient.new(params[:blocking_client])

    respond_to do |format|
      if @blocking_client.save
        format.html { redirect_to @blocking_client, notice: 'Blocking client was successfully created.' }
        format.json { render json: @blocking_client, status: :created, location: @blocking_client }
      else
        format.html { render action: "new" }
        format.json { render json: @blocking_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blocking_clients/1
  # PUT /blocking_clients/1.json
  def update
    @blocking_client = BlockingClient.find(params[:id])

    respond_to do |format|
      if @blocking_client.update_attributes(params[:blocking_client])
        format.html { redirect_to @blocking_client, notice: 'Blocking client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blocking_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blocking_clients/1
  # DELETE /blocking_clients/1.json
  def destroy
    @blocking_client = BlockingClient.find(params[:id])
    @blocking_client.destroy

    respond_to do |format|
      format.html { redirect_to blocking_clients_url }
      format.json { head :no_content }
    end
  end
end
