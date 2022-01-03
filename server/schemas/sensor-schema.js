const mongoose = require('mongoose')

const sensorSchema = new mongoose.Schema({
    date: {
        type: Date,
        required: true,
    },
    gas: {
        type: Number,
        required: true,
    },
    humidity: {
        type: Number,
        required: true,
    },
    pressure: {
        type: Number,
        required: true,
    },
    temperature: {
        type: Number,
        required: true,
    },
})

module.exports = mongoose.model('sensor', socialSchema)