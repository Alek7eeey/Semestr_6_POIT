import * as redis from "redis";

const client = redis.createClient();

async function testIncr() {
    for (let i = 1; i <= 10000; i++) {

        await client.incr('incr');
    }
}

async function testDecr() {
    for (let i = 1; i <= 10000; i++) {
        await client.decr('incr');
    }
}

async function runTests() {
    try {
        await client.set('incr', 0);

        console.time('INCR');
        await testIncr();
        console.timeEnd('INCR');

        console.time('DECR');
        await testDecr();
        console.timeEnd('DECR');
    } catch (error) {
        console.error('Error tests:', error);
    } finally {
        client.quit().then(() => {
            console.log('-----------Connection closed-----------');
        }).catch((err) => {
            console.log('Error closing connection:', err);
        });
    }
}

client.connect().then(async () => {
    console.log('-----------connect Redis-----------');
    await runTests();
}).catch((err) => {
    console.log('connection error Redis:', err);
});
