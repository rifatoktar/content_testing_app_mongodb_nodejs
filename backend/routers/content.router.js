const router = require('express').Router();
const ContentController = require('../controller/content.controller');

router.post('/storeContent', ContentController.createContent);

router.get('/getUserContent', ContentController.getContent);

router.get('/deleteContent', ContentController.deleteContent);

module.exports = router;