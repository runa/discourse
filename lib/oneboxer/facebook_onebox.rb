require_dependency 'oneboxer/handlebars_onebox'

module Oneboxer
  class FacebookOnebox < HandlebarsOnebox

    matcher /^https?:\/\/www\.facebook\.com\/[a-z0-9_.-]+$/i
    favicon 'facebook.png'

    def template
      template_path('simple_onebox')
    end

    def translate_url
      uri = URI.parse(@url)
      "http://graph.facebook.com#{uri.path}"
    end

    def parse(json)

      data = JSON.parse(json)

      result = {}

      result[:title] = data["name"]

      result[:image] = data["cover"]["source"] if data["cover"] and data["cover"]["source"]

      text = []
      text << data["about"]
      text << [data["location"]["street"],data["location"]["city"],data["location"]["state"],data["location"]["country"]].reject(&:blank?).join(", ")
      text << data["products"]
      text << data['website']

      result[:text] = text.join("\n")

      result
    end

  end
end
