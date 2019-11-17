const db = require('../database/index');
require('dotenv').config();

describe('Database Test', () => {

  // runs before all tests
  beforeAll(async() => await db.client.connect());
  
  // runs after all tests
  afterAll(async() => await db.client.end());
  
  // test - it should create a table
  it('should create a table', async () => {
    expect(async () => await db.createTableProducts()).not.toThrow();
  })
  
  // test - it should insert the products in the table
  it('should insert the products in the table', async () => {
    let res = await db.insertProducts();
    expect(res).toBe('success');
  })
  
  // test - it should get the second page of 4 products
  it('should get the second page of 4 products', async () => {
    let page = 2;
    let itemsPerPage = 4;

    let maxPerPage = process.env.MAX_ITEMS_PER_PAGE || 10;
    
    let res = await db.getProducts(page, itemsPerPage)

    if (itemsPerPage > maxPerPage)
      return expect(res.error).toBe(`Maximum of ${maxPerPage} items per page`);

    // first product of res
    expect(res[0].productid).toBe(1009);
    // last product of res
    expect(res[res.length-1].productid).toBe(1012);
  })
});
