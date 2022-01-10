const mongoose = require('mongoose')

const bedroomSchema = new mongoose.Schema({
    date: Date,
    gas: Number,
    humidity: Number,
    pressure: Number,
    temperature: Number,
});

module.exports = mongoose.model('bedrooms', bedroomSchema)