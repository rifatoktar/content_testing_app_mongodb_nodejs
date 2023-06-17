const ContentModel = require('../model/content.model');

class ContentServices {

    static async createContent(userId, text) {

        const createContent = new ContentModel({ userId, text });
        return await createContent.save();

    }

    static async getContentData(userId) {

        const contentData = await ContentModel.find({ userId });
        return contentData;

    }

    static async deleteContent(id) {

        const deleted = await ContentModel.findOneAndDelete({ _id: id });
        return deleted;

    }

}

module.exports = ContentServices;