const connection = require("./database/connection");

module.exports = () => ({
  async getProducts({ n, p }) {
    if (n < 1) {
      n = 10;
    }
    if (p < 1) {
      p = 1;
    }

    const prods = await connection("products")
      .limit(n)
      .offset((p - 1) * n)
      .select("*");

    return { response: prods };
  },
});
