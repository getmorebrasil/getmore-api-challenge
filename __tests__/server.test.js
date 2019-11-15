const axios = require('axios').create({ baseURL: 'http://localhost:4000/' });

describe('Server Test', () => {
  
  // test - it should test if server is online
  it('should be online', async () => {
    let res = await axios.get('');
    // console.log(res);
    expect(res.data).toBe('online');
  })
  
  // test - it should get second page of 4 products from the server
  it('should get second page of 4 products', async () => {
    let res = await axios.get('products/4&2');
    // first product of res
    expect(res.data.response[0].productid).toBe(1009);
    // last product of res
    expect(res.data.response[res.data.response.length-1].productid).toBe(1012);
  })

});