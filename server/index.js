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

app.get('/allData', async (req, res) => {
    sensorSchema.find({}, (err, result) => {
        if(err){
            print(err.toString())
            res.send(err);
        }

        console.log('Data length: ' + result.length.toString())
        console.log('Data found: ' + result.toString())
        res.send(result);
    });

});

app.get('/recentData', async (req, res) => {
    const dateNowMS = new Date().getTime()
    const dateDiffMS = 24 * 60 * 60 * 1000
    const data = await sensorSchema.find({
        date: {$gte : new Date(dateNowMS - dateDiffMS)},
    }).sort({date: 1});
    console.log('Found document: ' + data.toString());
    res.send(data);
});

app.listen(port, () => console.log(`Node server listening on port ${port}!`))