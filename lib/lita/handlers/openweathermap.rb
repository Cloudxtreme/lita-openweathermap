module Lita
  module Handlers
    class Openweathermap < Handler
      config :metric, type: String, default: 'metric'

      route /^weather\s+(.+)\,(.+)/, :weather, command: true, help: {
        "weather city, country" => "Outputs current weather for city, country"
      }

      def weather(response)
        city = response.matches[0][0].strip
        country = response.matches[0][1].strip

        response.reply get_weather(city, country)
      end

      private

        def get_weather(city, country = nil)
          resp = http.get("http://api.openweathermap.org/data/2.5/weather?q=#{city},#{country}&units=#{config.metric}")
          raise 'InvalidResponse' unless resp.status == 200

          obj = MultiJson.load(resp.body)

          lat_lon = "Lat/Lon: #{obj['coord']['lat']}/#{obj['coord']['lon']}"
          temp = "Temp: #{obj['main']['temp']} (Min: #{obj['main']['temp_min']} / Max: #{obj['main']['temp_max']})"
          humidity = "Humidity: #{obj['main']['humidity']}%"
          weather_in_words = "#{temp}, #{obj['weather'][0]['main'].to_s} (#{obj['weather'][0]['description'].to_s})"

          line = []
          line << "Weather for: #{city.capitalize} #{country.capitalize} (#{lat_lon})"
          line << temp
          line << humidity
          line << weather_in_words
          line.join(' - ')

        rescue
          return "Couldn't retrieve weather informations for #{city}, #{country}"
        end

    end

    Lita.register_handler(Openweathermap)
  end
end
