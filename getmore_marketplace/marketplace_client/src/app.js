const express = require("express");
const bodyParser = require("body-parser");
const helmet = require("helmet");
const cors = require("cors");
const routes = require("./routes");

const app = express();

const setupApplication = () => {
  app.use(bodyParser.json());
  app.use(cors());
  app.use(helmet());

  app.use("/api", routes);

  return app;
};

module.exports = setupApplication;
