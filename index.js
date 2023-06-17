const app = require('./app');
const db = require('./backend/config/db');
const UserModel = require('./backend/model/user.model');
const ContentModel = require('./backend/model/content.model');

const port = 3000;

app.get('/', (req, res) => {
    res.send('System All Good');
});

app.listen(port, () => {
    console.log(`Server listening on port http://localhost:${port}`);
})