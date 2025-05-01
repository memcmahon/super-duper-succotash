class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show update destroy ]

  # GET /api/v1/artists
  def index
    @artists = Artist.all

    render json: @artists
  end

  # GET /api/v1/artists/1
  def show
    render json: @artist
  end

  # POST /api/v1/artists
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created, location: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/artists/1
  def destroy
    @artist.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name)
    end
end
