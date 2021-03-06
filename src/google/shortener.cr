require "json"

module Google
  class Shortener
    include Google::REST
    SHORTENER_BASE = "https://www.googleapis.com/urlshortener/v1/url"

    def initialize(@api_key : String)
    end

    def shorten_url(url : String)
      response = request("POST", SHORTENER_BASE + "?key=#{@api_key}", {longUrl: "#{url}"}.to_json)
      Shortened.from_json(response)
    end

    def expand(url : String)
      unless url.starts_with?("http://") || url.starts_with?("https://")
        url = "https://" + url
      end
      response = request("GET", SHORTENER_BASE + "?key=#{@api_key}" + "&shortUrl=#{url}")
      Shortened.from_json(response)
    end
  end

  class Shortened
    JSON.mapping(
      kind: String,
      id: String,
      longUrl: String
    )
  end
end
