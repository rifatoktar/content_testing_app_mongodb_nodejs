const UserServices = require('../services/user.services');

exports.register = async (req, res, next) => {
    try {
        const { name, email, password } = req.body;
        const successRes = await UserServices.registerUser(name, email, password);
        res.json({ status: true, success: 'User Registered Successfully' });
    } catch (error) {
        next(error);
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserServices.checkUser(email);

        if (!user) {
            throw new Error('User do not exist');
        }

        const isMatch = await user.comparePassword(password);

        if (isMatch == false) {
            throw new Error('Password invalid');
        }

        let tokenData = { _id: user._id, email: user.email };

        const token = await UserServices.generateToken(tokenData, 'secretKey', '1h');

        res.status(200).json({ status: true, token: token })

    } catch (error) {
        next(error);
    }
}