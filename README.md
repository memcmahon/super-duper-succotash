# Set List API

A RESTful API for managing artists and their songs. Built with Ruby on Rails, this application allows you to create, read, update, and delete artists and their associated songs.

## Features

- Full CRUD operations for Artists and Songs
- RESTful API endpoints
- Input validation
- Comprehensive test coverage
- PostgreSQL database

## Prerequisites

- Ruby 3.2.2
- PostgreSQL
- Bundler
- Rails 7.1.5

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd set_list
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the server:
```bash
rails server
```

The application will be available at `http://localhost:3000`

## API Documentation

### Artists

#### Get All Artists
```http
GET /api/v1/artists
```

#### Get a Specific Artist
```http
GET /api/v1/artists/:id
```

#### Create an Artist
```http
POST /api/v1/artists
Content-Type: application/json

{
  "artist": {
    "name": "Artist Name"
  }
}
```

#### Update an Artist
```http
PATCH /api/v1/artists/:id
Content-Type: application/json

{
  "artist": {
    "name": "Updated Name"
  }
}
```

#### Delete an Artist
```http
DELETE /api/v1/artists/:id
```

### Songs

#### Get All Songs
```http
GET /api/v1/songs
```

#### Get Songs for a Specific Artist
```http
GET /api/v1/artists/:artist_id/songs
```

#### Get a Specific Song
```http
GET /api/v1/songs/:id
```

#### Create a Song
```http
POST /api/v1/songs
Content-Type: application/json

{
  "song": {
    "title": "Song Title",
    "length": 180,
    "artist_id": 1
  }
}
```

#### Update a Song
```http
PATCH /api/v1/songs/:id
Content-Type: application/json

{
  "song": {
    "title": "Updated Title",
    "length": 200
  }
}
```

#### Delete a Song
```http
DELETE /api/v1/songs/:id
```

## Validations

### Artist Validations
- Name must be present
- Name must be unique
- Name cannot be empty or contain only whitespace

### Song Validations
- Title must be present
- Length must be present
- Artist must exist

## Testing

The application includes comprehensive test coverage using RSpec. To run the tests:

```bash
rspec
```

## Database

The application uses PostgreSQL as its database. The schema includes:

- Artists table
  - name (string)
  - timestamps

- Songs table
  - title (string)
  - length (integer)
  - artist_id (foreign key)
  - timestamps

## License

This project is licensed under the MIT License - see the LICENSE file for details.
