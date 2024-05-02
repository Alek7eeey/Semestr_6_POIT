const express = require('express');
const bodyParser = require('body-parser');
const swaggerUI = require('swagger-ui-express');

const swaggerConfig = require('./doc/swagger_output.json');
const app = express();

const fs = require('fs');
app.use(bodyParser.json());
let data = require('./data') || [];

// #swagger.tags = ['TS']
// #swagger.description = 'Endpoint to get the full list of phone numbers'
app.get('/TS', (request, response) => {
    /* #swagger.responses[200] = {
               schema: { $ref: "#/definitions/PhoneNumbers" },
               description: 'Phone numbers successfully obtained.'
        } */
    response.json(data);
});

// #swagger.tags = ['TS']
// #swagger.description = 'Endpoint to add a new phone number'
app.post('/TS', (request, response) => {
    /* #swagger.parameters['newPhoneNumber'] = {
               in: 'body',
               description: 'Phone number info.',
               required: true,
               type: 'object',
               schema: { $ref: "#/definitions/AddPhoneNumber" }
        } */
    const { id, name, phone } = request.body;
    const newTs = { id, name, phone };
    console.log(newTs);
    const targetTs = data.find(ts => ts.id === newTs.id);
    if (!targetTs) {
        data.push(newTs);
        fs.writeFile('./data.json', JSON.stringify(data), (err) => {
            if (err) {
                console.log(err);
                return response.status(500).json({ error: 'Ошибка сервера' });
            }
            /* #swagger.responses[200] = {
               schema: { $ref: "#/definitions/PhoneNumber" },
               description: 'Phone number successfully added.'
            } */
            response.json(newTs);
        });
    } else {
        response.status(400).json({ error: 'Объект с этим идентификатором уже существует.' });
    }
});

// #swagger.tags = ['TS']
// #swagger.description = 'Endpoint to update a phone number'
app.put('/TS', (request, response) => {
    /* #swagger.parameters['updatePhoneNumber'] = {
               in: 'body',
               description: 'Phone number info.',
               required: true,
               type: 'object',
               schema: { $ref: "#/definitions/UpdatePhoneNumber" }
        } */
    const {id, name, phone} = request.body;
    const newTs = {id, name, phone};
    const item = data.find(ts => ts.id === newTs.id);
    const targetTs = data.findIndex(ts => ts.id === newTs.id);
    if (id && targetTs !== -1) {
        data[targetTs].name = name;
        data[targetTs].phone = phone;
        fs.writeFile('./data.json', JSON.stringify(data), (err) => {
            if (err) {
                console.log(err);
            }
        });
        /* #swagger.responses[200] = {
               schema: { $ref: "#/definitions/PhoneNumber" },
               description: 'Phone number successfully updated.'
        } */
        response.json(item);
    } else {
        return response.status(400).json({ error: 'Object with this id doesnt exist.' });
    }
});

// #swagger.tags = ['TS']
// #swagger.description = 'Endpoint to delete a phone number'
app.delete('/TS', (request, response) => {
    /* #swagger.parameters['id'] = {
               in: 'query',
               description: 'ID of the phone number to delete.',
               required: true,
               type: 'integer'
        } */
    console.log(request.query.id)
    const item = data.find(ts => ts.id === +request.query.id);
    const target = data.findIndex(ts => ts.id === +request.query.id);
    if (request.query.id && target !== -1) {
        data = data.filter((ts) => ts.id !== item.id);
        console.log(data)
        /* #swagger.responses[200] = {
               schema: { $ref: "#/definitions/PhoneNumber" },
               description: 'Phone number successfully deleted.'
        } */
        response.json(item);
        fs.writeFile('./data.json', JSON.stringify(data), (err) => {
            if (err) {
                console.log(err);
            }
        });
    } else {
        return response.status(400).json({ error: 'Object with this id doesnt exist.' });
    }
});

app.use('/doc', swaggerUI.serve, swaggerUI.setup(swaggerConfig));

app.listen(3000, () => console.log(`http://localhost:3000/doc`));
