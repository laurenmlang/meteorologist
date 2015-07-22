require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
     
        @g_url = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
        
          require 'json'
          parsed_data = JSON.parse(open(@g_url).read)

          @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

          @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

          lat_s = @latitude.to_s
          lng_s = @latitude.to_s

          @combine_url = "https://api.forecast.io/forecast/e6befb409a058d889af1b3bd5e71ed02/"+lat_s+","+lng_s

          require 'json'
          parsed_combine = JSON.parse(open(@combine_url).read)

                @current_temperature = parsed_combine["currently"]["temperature"]

             @current_summary = parsed_combine["currently"]["summary"]

            #@summary_of_next_sixty_minutes = parsed_combine["minutely"]["summary"]

          @summary_of_next_several_hours = parsed_combine["hourly"]["summary"]

          @summary_of_next_several_days = parsed_combine["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
