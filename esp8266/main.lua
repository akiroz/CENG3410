
city = "id=1819730"
app = "appid=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
url = "http://api.openweathermap.org/data/2.5/weather?" .. city .. "&" .. app
weatherText = {
    nil,
    "Thunderstorm",
    "Drizzle",
    nil,
    "Rainy",
    "Snowing",
    "Foggy",
    "Clear Sky"
}

dirText = {
    "N", "NE", "E", "SE",
    "S", "SW", "W", "NW",
    "N"
}

formatTimestamp = function(ts)
    local c = rtctime.epoch2cal(ts + 8*3600)
    return string.format(
        "%04d/%02d/%02d %02d:%02d:%02d",
        c["year"], c["mon"], c["day"], c["hour"], c["min"], c["sec"])
end

fetchTimer = tmr.create()
fetchTimer:register(10000, tmr.ALARM_SEMI, function()
    http.get(url, nil, function(code, data)
        if (code < 0) then return end
        local resp = sjson.decode(data)
        print("\\")
        tmr.delay(50*1000)
        print("Hong Kong")
        tmr.delay(50*1000)
        print(formatTimestamp(resp["dt"]))
        print("")
        tmr.delay(50*1000)
        local desc = resp["weather"][1]["description"]
        desc = string.upper(desc:sub(1,1)) .. desc:sub(2,-1)
        print(desc)
        tmr.delay(50*1000)
        print("Temp:     " .. (resp["main"]["temp"] - 273) .. "C")
        tmr.delay(50*1000)
        print("Humidity: " .. resp["main"]["humidity"] .. "%")
        tmr.delay(50*1000)
        print("Pressure: " .. math.floor(resp["main"]["pressure"] / 10) .. "kPa")
        tmr.delay(50*1000)
        local spd = string.format("%.1f", resp["wind"]["speed"] * 3.6)
        local dir = dirText[math.floor((resp["wind"]["deg"] + 22.5) / 45) + 1]
        print("Wind:     " .. spd .. "km/h " .. dir)
        fetchTimer:start()
    end)
end)

fetchTimer:start()
