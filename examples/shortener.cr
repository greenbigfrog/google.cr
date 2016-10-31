# First require the main lib
require "../src/google.cr"
# We can use a .env file to avoid leaking credentials
require "dotenv"
Dotenv.load

a = Google::Shortener.new(ENV["API_KEY"])
puts a.shorten_url("http://www.google.com")
