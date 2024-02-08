import requests
import json

# below will get you all of the various weather api endpoints for the Tahoe Donner Truckee NWS Area
#r = requests.get("https://api.weather.gov/points/39.3547,-120.2574")
r = requests.get("https://api.weather.gov/gridpoints/REV/28,101/forecast")

request_data = json.loads(r.text)

forecast_all = request_data['properties']

forecast_generated_at = forecast_all['updated']

forecast_today = forecast_all['periods'][0]

current_temp = forecast_today['temperature']

temp_units = forecast_today['temperatureUnit']

script_output = '{"temperature": "' + str(current_temp) + temp_units + '", "forecast_generated_at": "' + forecast_generated_at + '"}'

print(script_output)
