const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb+srv://test:gAOA39hAEm7QhgmE@flutterexample.li38xcu.mongodb.net/?retryWrites=true&w=majority').on('open', () => {
    console.log("MongoDB Connected");
}).on('error', () => {
    console.log('MongoDB Connection Error');
});

module.exports = connection;