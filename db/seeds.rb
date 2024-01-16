# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'json'

Movie.destroy_all
url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")
puts "Fetching movies from"
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = IMAGE_API_KEY

response = http.request(request)

# Check if the response is successful (HTTP status 200)
if response.code == '200'
  # Parse the JSON response
  data = JSON.parse(response.body)

  # Extract the array of movies from the "results" field
  movies = data["results"]

  # Iterate over each movie and create Movie records
  movies.each do |movie|
    Movie.create!(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: movie["poster_path"],
      rating: movie["vote_average"]
    )
  end
else
  puts "Error: #{response.code} - #{response.message}"
end
