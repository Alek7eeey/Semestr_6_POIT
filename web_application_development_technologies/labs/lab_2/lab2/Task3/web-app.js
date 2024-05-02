const express = require('express');
const app = express();
const port = 3000;

app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, X-Value-x, X-Value-y, X-Rand-N');
  res.setHeader('Access-Control-Expose-Headers', 'X-Value-z');
  next();
});


app.post('/sum', (req, res) => {
  setTimeout(() => {
    const x = parseInt(req.headers['x-value-x']);
    const y = parseInt(req.headers['x-value-y']);
    const z = x + y;
    res.setHeader('X-Value-z', z.toString());
    res.status(200).send();
  }, 10000); 
});


app.post('/random', (req, res) => {
  setTimeout(() => {
    const n = parseInt(req.headers['x-rand-n']);
    const count = Math.floor(Math.random() * 6) + 5; 
    const randomNumbers = [];
    for (let i = 0; i < count; i++) {
      randomNumbers.push(Math.floor(Math.random() * (2 * n + 1)) - n);
    }
    res.json(randomNumbers);
  }, 1000);
});

app.post('/randomSum', (req, res) => {
  setTimeout(() => {
    const x = parseInt(req.headers['x-value-x']);
    const y = parseInt(req.headers['x-value-y']);
    const z = x + y;
    res.setHeader('X-Value-z', z.toString());
    const n = parseInt(req.headers['x-rand-n']);
    const count = Math.floor(Math.random() * 6) + 5; 
    const randomNumbers = [];
    for (let i = 0; i < count; i++) {
      randomNumbers.push(Math.floor(Math.random() * (2 * n + 1)) - n);
    }
    res.json(randomNumbers);
  }, 100); 
});

app.listen(port, () => {
  console.log(`Server is listening at http://localhost:${port}`);
});
