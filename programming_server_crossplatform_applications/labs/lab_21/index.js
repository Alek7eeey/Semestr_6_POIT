import bodyParser from 'body-parser';
import express from 'express';
import fs from 'fs';
import path from 'path';
import formidable from 'formidable';
import { createClient } from 'webdav';

const __dirname = path.resolve();

const app = express();
const { urlencoded, json } = bodyParser;

app.use(urlencoded({ extended: false }));
app.use(json());
app.use(function (err, req, res, next) {
    res.send(err.message);
});


const client = createClient('https://webdav.yandex.ru', {
    username: 'a1eeek7ey',
    password: 'mvceikgbcoiivzxb',
});

app.post('/md/:name', async (req, res) => {
    const dirName = req.params.name;
    if (await client.exists(`/${dirName}`)) {
        res.status(408);
        res.send('Error 404: directory is not found');
    } else {
        await client.createDirectory(`/${dirName}`);
        res.send('Ok: all operations are completed');
    }
});

app.post('/rd/:name', async (req, res) => {
    const dirName = req.params.name;
    if (await client.exists(`/${dirName}`)) {
        await client.deleteFile(`/${dirName}`);
        res.send('Ok: all operations are completed');
    } else {
        res.status(404);
        res.send('Error 404: directory is not found');
    }
});

const form = formidable();

app.post('/up/:file', async (req, res) => {

    const file = req.params.file;
    if (file.includes('.')) {
        if (fs.existsSync(__dirname + `/${file}`)) {
            fs.createReadStream(__dirname + `/${file}`).pipe(
                client.createWriteStream(`/${file}`)
            );
            res.send('Ok: all operations are completed');
        } else {
            res.status(404);
            res.send('Error 404: File not found');
        }
    } else {
        res.status(404);
        res.send('Error 404: this is not a file!');
    }

});

app.post('/down/:file', async (req, res) => {
    const file = req.params.file;
    if (file.includes('.')) {
        if (await client.exists(`/${file}`)) {
            const downloadFilePath = 'D:\\studing\\6_semestr\\programming_server_crossplatform_applications\\labs\\lab_21\\' + file;
            const readStream = client.createReadStream(file);
            const writeStream = fs.createWriteStream(downloadFilePath);
            readStream.pipe(writeStream);
            res.status(200).send('Ok: all operations are completed');
        } else {
            res.status(404);
            res.send('Error 404: File not found');
        }
    } else {
        res.status(404);
        res.send('Error 404: this is not a file!');
    }
});

app.post('/del/:file', async (req, res) => {
    const file = req.params.file;
    if (file.includes('.')) {
        if (await client.exists(`/${file}`)) {
            await client.deleteFile(file);
            res.send('Ok: all operations are completed');
        } else {
            res.status(404);
            res.send('Error 404: File not found');
        }
    } else {
        res.send('Error 404: this is not a file!');
    }
});

app.post('/copy/:oldName/:newName', async (req, res) => {
    const oldName = req.params.oldName;
    const newName = req.params.newName;
    if (await client.exists(`/${oldName}`)) {
        await client.copyFile(`/${oldName}`, `/${newName}`);
        res.send('Ok: all operations are completed');
    } else {
        res.status(404);
        res.send('Error 404: File not found');
    }

});

app.post('/move/:oldName/:newName', async (req, res) => {
    const oldName = req.params.oldName;
    const newName = req.params.newName;
    if (await client.exists(`/${oldName}`)) {
        await client.moveFile(`/${oldName}`, `/${newName}`);
        res.send('Ok: all operations are completed');
    } else {
        res.status(404);
        res.send('Error 404: File not found');
    }

});

app.listen(3000);