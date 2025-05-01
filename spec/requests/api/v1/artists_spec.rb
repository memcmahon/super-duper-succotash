require 'rails_helper'

RSpec.describe "Api::V1::Artists", type: :request do
  describe "GET /api/v1/artists" do
    it "returns all artists" do
      artist1 = Artist.create!(name: "The Beatles")
      artist2 = Artist.create!(name: "Led Zeppelin")
      artist3 = Artist.create!(name: "Pink Floyd")

      get '/api/v1/artists'

      expect(response).to have_http_status(:success)
      
      artists = JSON.parse(response.body)
      expect(artists.size).to eq(3)
      expect(artists.map { |a| a["name"] }).to match_array(["The Beatles", "Led Zeppelin", "Pink Floyd"])
    end
  end

  describe "GET /api/v1/artists/:id" do
    it "returns a specific artist" do
      artist = Artist.create!(name: "Queen")

      get "/api/v1/artists/#{artist.id}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq("Queen")
    end

    it "returns 404 for non-existent artist" do
      get "/api/v1/artists/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/artists" do
    let(:valid_attributes) { { artist: { name: "New Artist" } } }
    let(:invalid_attributes) { { artist: { name: "" } } }
    let(:whitespace_attributes) { { artist: { name: "   " } } }

    it "creates a new artist with valid attributes" do
      expect {
        post "/api/v1/artists", params: valid_attributes
      }.to change(Artist, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq("New Artist")
    end

    it "fails to create artist with empty name" do
      expect {
        post "/api/v1/artists", params: invalid_attributes
      }.not_to change(Artist, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['name']).to include("can't be blank")
    end

    it "fails to create artist with whitespace-only name" do
      expect {
        post "/api/v1/artists", params: whitespace_attributes
      }.not_to change(Artist, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['name']).to include("can't be blank")
    end
  end

  describe "PATCH /api/v1/artists/:id" do
    let!(:artist) { Artist.create!(name: "Original Name") }

    it "updates artist with valid attributes" do
      patch "/api/v1/artists/#{artist.id}", params: { artist: { name: "Updated Name" } }

      expect(response).to have_http_status(:success)
      expect(artist.reload.name).to eq("Updated Name")
    end

    it "fails to update artist with empty name" do
      patch "/api/v1/artists/#{artist.id}", params: { artist: { name: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(artist.reload.name).to eq("Original Name")
      expect(JSON.parse(response.body)['name']).to include("can't be blank")
    end

    it "fails to update artist with whitespace-only name" do
      patch "/api/v1/artists/#{artist.id}", params: { artist: { name: "   " } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(artist.reload.name).to eq("Original Name")
      expect(JSON.parse(response.body)['name']).to include("can't be blank")
    end
  end

  describe "DELETE /api/v1/artists/:id" do
    it "deletes the artist" do
      artist = Artist.create!(name: "Artist to Delete")

      expect {
        delete "/api/v1/artists/#{artist.id}"
      }.to change(Artist, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end 