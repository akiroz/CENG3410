
wifi_connect_event = function(T) 
    print("SSID: " .. T.SSID)
end

wifi_got_ip_event = function(T) 
    print("IP: " .. T.IP)
    dofile("main.lua")
end

init = function()
    print("\\")
    print("init...")
    wifi.setmode(wifi.STATION)
    wifi.sta.config({ ssid="xxxx", pwd="xxxx", auto=false })
    wifi.sta.connect()
end

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, wifi_connect_event)
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, wifi_got_ip_event)
tmr.create():alarm(1500, tmr.ALARM_SINGLE, init)

