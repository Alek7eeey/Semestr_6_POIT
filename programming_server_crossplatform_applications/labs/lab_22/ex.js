const TelegramBot = require('node-telegram-bot-api');
const cron = require('node-cron');
const axios = require('axios');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const token = '6816533295:AAHmV8BKn-pyDuXc8OhIKWMResIDz5b-r58';
const openWeatherMapApiKey = 'bdb834a8288e06286161c3f84358adbc';

const bot = new TelegramBot(token, { polling: true });
let check;
bot.onText(/\/subscribe/, async (msg) => {
    const chatId = msg.chat.id;
    const userId = msg.from.id;

    try {
        const existingSubscriber = await prisma.Subscribers.findFirst({
            where: {
                userId: userId
            }
        });

        if (existingSubscriber) {
            bot.sendMessage(chatId, "Вы уже подписаны на рассылку случайных фактов!");
            return;
        }


        await prisma.Subscribers.create({
            data: {
                userId: userId
            }
        });

        bot.sendMessage(chatId, "Вы успешно подписались на ежедневную рассылку случайных фактов!");

        /*cron.schedule('00 12 * * *', () => { //в 12 00 каждый день
            sendRandomFact(chatId);
        });*/

        check = cron.schedule('*/10 * * * * *', () => { //каждые 10 секунд
            sendRandomFact(chatId);
        });

    } catch (error) {
        console.error('Error subscribing:', error.message);
        bot.sendMessage(chatId, "Не удалось подписаться на рассылку. Пожалуйста, попробуйте еще раз.");
    }
});

bot.onText(/\/unsubscribe/, async (msg) => {
    const chatId = msg.chat.id;
    const userId = msg.from.id;

    try {
        const existingSubscriber = await prisma.Subscribers.findFirst({
            where: {
                userId: userId
            }
        });

        if (!existingSubscriber) {
            bot.sendMessage(chatId, "Вы не подписаны на рассылку случайных фактов!");
            return;
        }

        await prisma.Subscribers.delete({
            where: {
                id: existingSubscriber.id
            }
        });
        check.stop();
        bot.sendMessage(chatId, "Вы успешно отписались от рассылки случайных фактов!");
    } catch (error) {
        console.error('Error unsubscribing:', error.message);
        bot.sendMessage(chatId, "Не удалось отписаться от рассылки. Пожалуйста, попробуйте еще раз.");
    }
});

bot.onText(/\/weather (.+)/, async (msg, match) => {
    const chatId = msg.chat.id;
    const city = match[1];

    try {
        const weatherData = await getWeatherData(city);
        const message = formatWeatherMessage(weatherData);
        bot.sendMessage(chatId, message);
    } catch (error) {
        bot.sendMessage(chatId, "Не удалось получить данные о погоде. Пожалуйста, попробуйте позже.");
    }
});

async function getWeatherData(city) {
    try {
        const apiUrl = `http://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${openWeatherMapApiKey}`;
        const response = await axios.get(apiUrl);
        return response.data;
    } catch (error) {
        console.error("Ошибка при получении данных о погоде:", error.response ? error.response.data : error.message);
        throw new Error("Не удалось получить данные о погоде. Пожалуйста, попробуйте позже.");
    }
}
function formatWeatherMessage(weatherData) {
    const cityName = weatherData.name;
    const temperature = weatherData.main.temp;
    const humidity = weatherData.main.humidity;
    const pressure = weatherData.main.pressure;
    const windSpeed = weatherData.wind.speed;

    return `Погода в городе ${cityName}:
    Температура: ${temperature}°C
    Влажность: ${humidity}%
    Давление: ${pressure} hPa
    Скорость ветра: ${windSpeed} м/с`;
}

bot.onText(/\/joke/, async (msg) => {
    const chatId = msg.chat.id;
    try {
        const response = await axios.get('https://icanhazdadjoke.com/', {
            headers: {
                'Accept': 'application/json'
            }
        });
        const joke = response.data.joke;
        bot.sendMessage(chatId, joke);
    } catch (error) {
        console.error('Ошибка при получении шутки:', error.message);
        bot.sendMessage(chatId, 'Не удалось получить шутку. Пожалуйста, попробуйте позже.');
    }
});

bot.on('message', (msg) => {
    const chatId = msg.chat.id;
    if (msg.text === null) {
        return;
    }
    if (msg.text.toLowerCase().includes('привет')) {
        bot.sendSticker(chatId, 'CAACAgIAAxkBAAEFHrRmMpvssozIRWArx-N-_qwRafo8QgAC8BsAAiLQWUrbMO0-gdnl7TQE');
    } else {
        bot.sendMessage(chatId, msg.text);
    }
});

bot.onText(/\/cat/, async (msg) => {
    const chatId = msg.chat.id;
    try {
        const response = await axios.get('https://api.thecatapi.com/v1/images/search');
        const catImageUrl = response.data[0].url;
        bot.sendPhoto(chatId, catImageUrl);
    } catch (error) {
        console.error('Ошибка при получении изображения кота:', error.message);
        bot.sendMessage(chatId, 'Не удалось получить изображение кота. Пожалуйста, попробуйте позже.');
    }
});

async function sendRandomFact(chatId) {
    try {
        const response = await axios.get('http://numbersapi.com/random/trivia');
        const fact = response.data;
        bot.sendMessage(chatId, fact);
    } catch (error) {
        console.error('Error getting random fact:', error.message);
        bot.sendMessage(chatId, "Не удалось получить случайный факт. Пожалуйста, попробуйте позже.");
    }
}


console.log('Бот запущен!');
