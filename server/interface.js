const db = require('../database');

// just for test
function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

module.exports = () => ({
    /* getProducts(page = 0, itemsPerPage = 5): [Object] */
    async getProducts({page = 0, itemsPerPage = 5}) {
        let res = await db.getProducts(page, itemsPerPage);

        // await timeout(5000);
        return { response: res };
    }
})
