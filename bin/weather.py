#!/usr/bin/env python
import requests

city = "45.484086, 0.3796839"
api_key = "2f8b21ecbbe1c9f3c156a1ead5fabaa9"

weather = requests.get("https://api.darksky.net/forecast/{}/{}"
                       "?exclude=minutely,hourly,daily,alerts,flags"
                       "&lang=fr&units=si".format(api_key, city))
info = weather.json()['currently']['summary']
temp = weather.json()['currently']['temperature']

print("%s, %i °C" % (info, temp))
