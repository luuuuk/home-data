const mongoose = require('mongoose')

const sensorSchema = new mongoose.Schema({
    date: Date,
    gas: Number,
    humidity: Number,
    pressure: Number,
    temperature: Number,
});

module.exports = mongoose.model('sensors', sensorSchema)