import redis from 'redis';
const publisher = redis.createClient();
(async () => {
    await publisher.connect();
    await publisher.publish('myChanel', JSON.stringify('Hello'));
})();