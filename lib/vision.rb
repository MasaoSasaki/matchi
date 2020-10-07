require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      # # APIのURL作成
      # api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GCP_API_KEY']}"

      # # 画像をbase64にエンコード
      # base64_image = Base64.encode64(image_file)

      # # APIリクエスト用のJSONパラメータ
      # params = {
      #   requests: [{
      #     image: {
      #       content: base64_image
      #     },
      #     features: [
      #       {
      #         type: 'LABEL_DETECTION'
      #       }
      #     ]
      #   }]
      # }.to_json

      # # Google Cloud Vision APIにリクエスト
      # uri = URI.parse(api_url)
      # https = Net::HTTP.new(uri.host, uri.port)
      # https.use_ssl = true
      # request = Net::HTTP::Post.new(uri.request_uri)

      # # request['Content-Type'] = 'application/json'
      # headers = {
      #   "Content-Type" => "application/json",
      #   'Referer': 'http://localhost:3000/*'
      # }

      require "net/http"
      require "json"
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
  end
end
