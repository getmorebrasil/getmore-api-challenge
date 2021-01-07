const { v4: uuidV4 } = require("uuid");

function generateUuid() {
  return uuidV4();
}

module.exports = generateUuid;
