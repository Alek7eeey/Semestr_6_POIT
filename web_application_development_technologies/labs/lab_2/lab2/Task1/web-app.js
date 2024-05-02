const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Парсинг JSON-тела запроса
app.use(bodyParser.json());

// Middleware для обработки CORS
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*'); 
  res.setHeader('Access-Control-Allow-Methods', 'POST'); 
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, X-Value-x, X-Value-y'); 
  res.setHeader('Access-Control-Expose-Headers', 'X-Value-z');
  next();
});


app.post('/', (req, res) => {
  if (!req.headers['x-value-x'] || !req.headers['x-value-y']) {
    return res.status(400).send('Missing required headers');
  }

  const x = parseInt(req.headers['x-value-x']);
  const y = parseInt(req.headers['x-value-y']);

  if (isNaN(x) || isNaN(y)) {
    return res.status(400).send('Invalid values for x or y');
  }

  const z = x + y;
  res.setHeader('X-Value-z', z.toString());
  res.status(200).send(`Sum is calculated and returned in header X-Value-z: ${z}`);
});


app.listen(port, () => {
  console.log(`Server is listening at http://localhost:${port}`);
});
