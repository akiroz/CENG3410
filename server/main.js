const { promisify } = require('util');
const request = require('request');

//const weather = require('openweather-apis');
//weather.setCityId(1819730);
//weather.setAPPID("xxxxxxxxxxxxxxxxxxxxxxxx");

const server = require('server');
const { get } = server.router;

server({ port: 8000 }, [
    get('/', async (ctx) => {
        console.log("recieved request", new Date());
        let payload = await promisify(request)(`api.openweathermap.org${ctx.url}`);
        payload.city = "Hong Kong";
        payload.time = new Date().toLocaleString();
        payload.temp = Math.round(payload.temp);
        return payload;
    }),
]);
console.log("server started");
