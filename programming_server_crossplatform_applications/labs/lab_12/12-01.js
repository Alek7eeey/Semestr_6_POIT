import * as redis from "redis";

const client = redis.createClient();
client.connect().then(() => {
    console.log('-----------connect-----------');
    client.quit().then(() => {
        console.log('-----------connect close-----------');
    }).catch((err) => {
        console.log('connection error:', err);
    });
}).catch((err) => {
    console.log('connection error:', err);
});