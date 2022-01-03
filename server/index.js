const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require("mongoose");
const sensorSchema = require('./schemas/sensor-schema')

const app = express();
const port = 3001;

app.use(cors());

mongoose.connect('mongodb://127.0.0.1:27017/homedata',
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }
);

const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error: "));
db.once("open", function () {
    console.log("Connected successfully");
});

// Configuring body parser middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/recentData', async (req, res) => {
    const dateNowMS = new Date().getTime()
    const dateDiffMS = 24 * 60 * 60 * 1000
    const data = await sensorSchema.find({
        date: {$gte : new Date(dateNowMS - dateDiffMS)},
    }).sort({date: 1});
    console.log('Found document: ' + data.toString());
    res.send(data);
});

app.get('/allData', async (req, res) => {
    const data = await sensorSchema.find({}).sort({date: 1});
    console.log('Found data row: ' + data.toString());
    res.send(data);
});

app.listen(port, () => console.log(`Hello world app listening on port ${port}!`))