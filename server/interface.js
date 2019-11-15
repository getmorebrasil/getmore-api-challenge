const db = require('../database');

// just for test
function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

module.exports = () => ({
    /* getProducts(itemsPerPage = 5, page = 0): [Object] */
    async getProducts({itemsPerPage = 5, page = 0}) {
        let res = await db.getProducts(itemsPerPage, page);

        // await timeout(5000);
        return { response: res };
    }
})
