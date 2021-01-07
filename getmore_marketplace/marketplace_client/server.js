const setupApplication = require("./src/app");
const app = setupApplication();

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`App is running on port: ${PORT}`));
