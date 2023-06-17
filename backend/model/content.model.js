const db = require('../config/db');
const mongoose = require('mongoose');
const UserModel = require('../model/user.model');

const { Schema } = mongoose;

const contentSchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    text: {
        type: String,
        required: true
    }
});

const ContentModel = db.model('content', contentSchema);

module.exports = ContentModel;