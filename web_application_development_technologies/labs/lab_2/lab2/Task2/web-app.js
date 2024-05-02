const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());

// Middleware для обработки CORS
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*'); 
    res.setHeader('Access-Control-Allow-Methods', 'POST'); 
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, X-Rand-N'); 
    next();
  });

app.post('/', (req, res) => {
  const n = parseInt(req.headers['x-rand-n']);
  if (isNaN(n)) {
    return res.status(400).send('Invalid value for X-Rand-N header');
  }

  const count = Math.floor(Math.random() * 6) + 5; // Случайное количество чисел от 5 до 10
  const randomNumbers = [];
  for (let i = 0; i < count; i++) {
    const randomNumber = Math.floor(Math.random() * (2 * n + 1)) - n; // Случайное число от -n до n
    randomNumbers.push(randomNumber);
  }

  res.json(randomNumbers);
});

app.listen(port, () => {
  console.log(`Server is listening at http://localhost:${port}`);
});
