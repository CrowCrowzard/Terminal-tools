#!/bin/sh

WEATHER_CITY=250010

#curl -s http://weather.livedoor.com/forecast/webservice/json/v1\?city\=$WEATHER_CITY | jq -r '.forecasts[] | select(.dateLabel == "今日").telop'
curl -s http://weather.livedoor.com/forecast/webservice/json/v1\?city\=$WEATHER_CITY | jq -r '.location.city+"("+.forecasts[0].telop+")"'

# 詳細情報
#curl -s http://weather.livedoor.com/forecast/webservice/json/v1\?city\=$WEATHER_CITY | jq -r '.location.prefecture+"-"+.location.city+"("+.forecasts[0].telop+")  最高気温: "+ if .forecasts[0].temperature.max == null then "不明" else .forecasts[0].temperature.max.celsius+"度" end +" / 最低気温: "+ if .forecasts[0].temperature.min == null then "不明" else .forecasts[0].temperature.min.celsius+"度"end'
#curl -s http://weather.livedoor.com/forecast/webservice/json/v1\?city\=$WEATHER_CITY | jq -r '.location.prefecture+" - "+.location.city+" ( "+.publicTime+" 発表 )\n  今日の天気は "+.forecasts[0].telop+"\n  最高気温: "+ if .forecasts[0].temperature.max == null then "不明" else .forecasts[0].temperature.max.celsius+"度" end +" / 最低気温: "+ if .forecasts[0].temperature.min == null then "不明" else .forecasts[0].temperature.min.celsius+"度"end'
