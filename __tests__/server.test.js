const axios = require('axios').create({ baseURL: 'http://localhost:4000/' });
require('dotenv').config();

describe('Server Test', () => {

  // test - it should test if server is online
  it('should be online', async () => {
    let res = await axios.get('');
    expect(res.data).toBe('online');
  })

  // test - it should get second page of 4 products from the server
  it('should get second page of 4 products', async () => {
    let page = 2;
    let itemsPerPage = 4;
    let maxPerPage = process.env.MAX_ITEMS_PER_PAGE || 10;

    try {
      let res = await axios.get(`products/${page}&${itemsPerPage}`)
      let data = res.data.response;
      // first product of res
      expect(data[0].productid).toBe(1009);
      // last product of res
      expect(data[data.length - 1].productid).toBe(1012);
    } catch ({ response }) {
      if (itemsPerPage > maxPerPage)
        return expect(response.data.error).toBe(`Maximum of ${maxPerPage} items per page`);
    }
  })

});