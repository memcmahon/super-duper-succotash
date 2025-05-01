# Clear existing data
puts "Clearing existing data..."
Song.destroy_all
Artist.destroy_all

# Create Artists
puts "Creating artists..."
artists = [
  "The Rolling Stones",
  "Led Zeppelin",
  "Pink Floyd",
  "Queen",
  "The Beatles",
  "David Bowie",
  "Fleetwood Mac",
  "Eagles",
  "The Who",
  "AC/DC"
].map do |name|
  Artist.create!(name: name)
end

# Song data - title and length (in seconds)
puts "Creating songs..."
song_data = {
  "The Rolling Stones" => [
    ["(I Can't Get No) Satisfaction", 223],
    ["Paint It Black", 202],
    ["Gimme Shelter", 271],
    ["Start Me Up", 214],
    ["Sympathy for the Devil", 378],
    ["Brown Sugar", 228],
    ["Wild Horses", 341],
    ["Jumpin' Jack Flash", 205],
    ["You Can't Always Get What You Want", 448],
    ["Miss You", 252]
  ],
  "Led Zeppelin" => [
    ["Stairway to Heaven", 482],
    ["Kashmir", 508],
    ["Whole Lotta Love", 334],
    ["Black Dog", 295],
    ["Immigrant Song", 146],
    ["Rock and Roll", 221],
    ["Good Times Bad Times", 166],
    ["Ramble On", 263],
    ["Dazed and Confused", 388],
    ["Communication Breakdown", 150]
  ],
  "Pink Floyd" => [
    ["Comfortably Numb", 382],
    ["Wish You Were Here", 285],
    ["Money", 382],
    ["Another Brick in the Wall", 219],
    ["Time", 413],
    ["Us and Them", 462],
    ["Have a Cigar", 307],
    ["Breathe", 163],
    ["Eclipse", 123],
    ["Brain Damage", 228]
  ],
  "Queen" => [
    ["Bohemian Rhapsody", 354],
    ["We Will Rock You", 122],
    ["Another One Bites the Dust", 214],
    ["Don't Stop Me Now", 209],
    ["We Are the Champions", 179],
    ["Radio Ga Ga", 343],
    ["Somebody to Love", 295],
    ["Under Pressure", 248],
    ["Killer Queen", 180],
    ["I Want to Break Free", 222]
  ],
  "The Beatles" => [
    ["Hey Jude", 431],
    ["Let It Be", 243],
    ["Come Together", 259],
    ["Here Comes the Sun", 185],
    ["Yesterday", 125],
    ["Help!", 139],
    ["All You Need Is Love", 227],
    ["While My Guitar Gently Weeps", 285],
    ["A Day in the Life", 337],
    ["Something", 183]
  ],
  "David Bowie" => [
    ["Space Oddity", 315],
    ["Heroes", 371],
    ["Life on Mars?", 228],
    ["Starman", 253],
    ["Changes", 217],
    ["Let's Dance", 249],
    ["Rebel Rebel", 269],
    ["Modern Love", 238],
    ["Ashes to Ashes", 264],
    ["Fame", 241]
  ],
  "Fleetwood Mac" => [
    ["Dreams", 257],
    ["Go Your Own Way", 223],
    ["Landslide", 203],
    ["Rhiannon", 252],
    ["Don't Stop", 193],
    ["The Chain", 270],
    ["Everywhere", 214],
    ["Little Lies", 219],
    ["Gold Dust Woman", 288],
    ["Seven Wonders", 227]
  ],
  "Eagles" => [
    ["Hotel California", 391],
    ["Take It Easy", 211],
    ["One of These Nights", 293],
    ["Desperado", 213],
    ["Life in the Fast Lane", 251],
    ["Take It to the Limit", 287],
    ["Peaceful Easy Feeling", 244],
    ["Tequila Sunrise", 166],
    ["Already Gone", 253],
    ["Lyin' Eyes", 379]
  ],
  "The Who" => [
    ["Baba O'Riley", 303],
    ["Won't Get Fooled Again", 513],
    ["Behind Blue Eyes", 221],
    ["Who Are You", 378],
    ["My Generation", 198],
    ["Pinball Wizard", 199],
    ["The Kids Are Alright", 188],
    ["I Can See for Miles", 262],
    ["Love, Reign O'er Me", 352],
    ["5:15", 289]
  ],
  "AC/DC" => [
    ["Back in Black", 255],
    ["Highway to Hell", 208],
    ["Thunderstruck", 292],
    ["You Shook Me All Night Long", 210],
    ["T.N.T.", 214],
    ["Hells Bells", 312],
    ["For Those About to Rock", 343],
    ["It's a Long Way to the Top", 252],
    ["Dirty Deeds Done Dirt Cheap", 241],
    ["Rock N Roll Train", 264]
  ]
}

# Create Songs
puts "Creating songs..."
song_data.each do |artist_name, songs|
  artist = Artist.find_by(name: artist_name)
  songs.each do |title, length|
    Song.create!(
      title: title,
      length: length,
      artist: artist
    )
  end
end

puts "Seeding completed!"
puts "Created #{Artist.count} artists"
puts "Created #{Song.count} songs"