require 'rails_helper'

RSpec.describe "Api::V1::Songs", type: :request do
  describe "GET /api/v1/songs" do
    it "returns all songs" do
      artist = Artist.create!(name: "The Beatles")
      song1 = Song.create!(title: "Hey Jude", length: 431, artist: artist)
      song2 = Song.create!(title: "Let It Be", length: 243, artist: artist)
      song3 = Song.create!(title: "Yesterday", length: 125, artist: artist)

      get '/api/v1/songs'

      expect(response).to have_http_status(:success)
      
      songs = JSON.parse(response.body)
      expect(songs.size).to eq(3)
      expect(songs.map { |s| s["title"] }).to match_array(["Hey Jude", "Let It Be", "Yesterday"])
    end
  end

  describe "GET /api/v1/artists/:artist_id/songs" do
    it "returns all songs for a specific artist" do
      artist1 = Artist.create!(name: "Queen")
      artist2 = Artist.create!(name: "Pink Floyd")

      # Create songs for first artist
      song1 = Song.create!(title: "Bohemian Rhapsody", length: 354, artist: artist1)
      song2 = Song.create!(title: "We Will Rock You", length: 122, artist: artist1)
      song3 = Song.create!(title: "Another One Bites the Dust", length: 214, artist: artist1)

      # Create songs for second artist
      Song.create!(title: "Money", length: 382, artist: artist2)
      Song.create!(title: "Time", length: 413, artist: artist2)

      get "/api/v1/artists/#{artist1.id}/songs"

      expect(response).to have_http_status(:success)
      
      songs = JSON.parse(response.body)
      expect(songs.size).to eq(3)
      expect(songs.map { |s| s["title"] }).to match_array([
        "Bohemian Rhapsody",
        "We Will Rock You",
        "Another One Bites the Dust"
      ])
    end
  end

  describe "GET /api/v1/songs/:id" do
    it "returns a specific song" do
      artist = Artist.create!(name: "Led Zeppelin")
      song = Song.create!(
        title: "Stairway to Heaven",
        length: 482,
        artist: artist
      )

      get "/api/v1/songs/#{song.id}"

      expect(response).to have_http_status(:success)
      
      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq("Stairway to Heaven")
      expect(json_response['length']).to eq(482)
    end

    it "returns 404 for non-existent song" do
      get "/api/v1/songs/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/songs" do
    let!(:artist) { Artist.create!(name: "AC/DC") }

    it "creates a new song with valid attributes" do
      valid_attributes = {
        song: {
          title: "Back in Black",
          length: 255,
          artist_id: artist.id
        }
      }

      expect {
        post "/api/v1/songs", params: valid_attributes
      }.to change(Song, :count).by(1)

      expect(response).to have_http_status(:created)
      
      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq("Back in Black")
      expect(json_response['length']).to eq(255)
    end

    it "fails to create song with invalid attributes" do
      invalid_attributes = {
        song: {
          title: "",
          length: nil,
          artist_id: artist.id
        }
      }

      expect {
        post "/api/v1/songs", params: invalid_attributes
      }.not_to change(Song, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /api/v1/songs/:id" do
    let!(:artist) { Artist.create!(name: "The Rolling Stones") }
    let!(:song) { Song.create!(title: "Original Title", length: 180, artist: artist) }

    it "updates song with valid attributes" do
      patch "/api/v1/songs/#{song.id}", params: {
        song: { title: "Updated Title", length: 200 }
      }

      expect(response).to have_http_status(:success)
      
      song.reload
      expect(song.title).to eq("Updated Title")
      expect(song.length).to eq(200)
    end

    it "fails to update song with invalid attributes" do
      patch "/api/v1/songs/#{song.id}", params: {
        song: { title: "", length: nil }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      
      song.reload
      expect(song.title).to eq("Original Title")
      expect(song.length).to eq(180)
    end
  end

  describe "DELETE /api/v1/songs/:id" do
    it "deletes the song" do
      artist = Artist.create!(name: "The Who")
      song = Song.create!(
        title: "Baba O'Riley",
        length: 303,
        artist: artist
      )

      expect {
        delete "/api/v1/songs/#{song.id}"
      }.to change(Song, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end 