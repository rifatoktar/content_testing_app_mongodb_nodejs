const mongoose = require('mongoose');

const connection = mongoose.createConnection('YOUR_MONGODB_CONNECTION_KEY').on('open', () => {
    console.log("MongoDB Connected");
}).on('error', () => {
    console.log('MongoDB Connection Error');
});

module.exports = connection;
