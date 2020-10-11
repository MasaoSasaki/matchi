require 'json'
require 'net/https'

module Gcp
  class << self
    def post_vision_api(image_file)
      uri = URI.parse("https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GCP_API_KEY']}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme === "https"
      params = {
        requests: [{
          image: {
            content: image_file
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ]
        }]
      }.to_json
      headers = {
        "Content-Type" => "application/json",
        'Referer': "https://matchi-gourmet.com/*",
        'Referer': "http://localhost:3000/*"
      }
      response = http.post(uri, params, headers)

      # APIレスポンス出力
      JSON.parse(response.body)['responses'][0]['labelAnnotations'].pluck('description').take(10)
    end

    def post_translation_api(context)
      uri = URI.parse("https://www.googleapis.com/language/translate/v2?key=#{ENV['GCP_API_KEY']}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme === "https"
      params = {
        q: context,
        target: "ja"
      }.to_json
      headers = {
        "Content-Type" => "application/json",
        'Referer': "https://matchi-gourmet.com/*",
        'Referer': "http://localhost:3000/*"
      }
      response = http.post(uri, params, headers)
      JSON.parse(response.body)["data"]["translations"].first["translatedText"]
    end
  end
end
