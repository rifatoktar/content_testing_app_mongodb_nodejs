const express = require('express');
const body_parser = require('body-parser');
const userRouter = require('./backend/routers/user.router');
const ContentRouter = require('./backend/routers/content.router');

const app = express();

app.use(body_parser.json());

app.use('/', userRouter);
app.use('/', ContentRouter);

module.exports = app;