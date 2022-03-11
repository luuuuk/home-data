const mongoose = require('mongoose')

const officeSchema = new mongoose.Schema({
    date: Date,
    gas: Number,
    humidity: Number,
    pressure: Number,
    temperature: Number,
});

module.exports = mongoose.model('offices', officeSchema)