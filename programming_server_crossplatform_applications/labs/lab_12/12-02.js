import * as redis from "redis";

const client = redis.createClient();

async function testSet() {
    for (let i = 1; i <= 10000; i++) {
        await  client.set(`key${i}`, `val${i}`);
    }
}

async function testGet() {
    for (let i = 1; i <= 10000; i++) {
        await  client.get(`key${i}`);
    }
}

async function testDel() {
    for (let i = 1; i <= 10000; i++) {
        await client.del(`key${i}`);
    }
}

async function runTests() {
    try {
        console.time('SET');
        await testSet();
        console.timeEnd('SET');

        console.time('GET');
        await testGet();
        console.timeEnd('GET');

        console.time('DEL');
        await testDel();
        console.timeEnd('DEL');
    } catch (error) {
        console.error('Error:', error);
    } finally {
        client.quit().then(() => {
            console.log('-----------connect close-----------');
        }).catch((err) => {
            console.log('connection error:', err);
        });    }
}

client.connect().then(async () => {
    console.log('-----------connect Redis-----------');
    await runTests();
}).catch((err) => {
    console.log('connection error Redis:', err);
});
