const ContentServices = require('../services/content.services');

exports.createContent = async (req, res, next) => {
    try {
        const { userId, text } = req.body;
        let content = await ContentServices.createContent(userId, text);
        res.json({ status: true, success: content });
    } catch (error) {
        next(error);
    }
}

exports.getContent = async (req, res, next) => {
    try {
        const { userId } = req.body;
        let content = await ContentServices.getContentData(userId);
        res.json({ status: true, success: content });
    } catch (error) {
        next(error);
    }
}

exports.deleteContent = async (req, res, next) => {
    try {
        const { id } = req.body;
        let deleted = await ContentServices.deleteContent(id);
        res.json({ status: true, success: deleted });
    } catch (error) {
        next(error);
    }
}