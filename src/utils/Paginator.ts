export default class Paginator {

  data: any[];
  page: number;
  size: number;

  constructor(data: any[], page: any = '1', size: any = '10') {
    this.data = data;
    this.page = +page;
    this.size = +size;
  }

  apply() {
    const paginatedData: any[] = [];
    const offset: number = this.size - 1;
    const final: number = offset * this.page;
    const start: number = final - offset;

    var payloadReturn: any = {};

    for(var i = 0; i < this.size; i++) {
      if (this.data[start + i] !== 'undefined') {
        paginatedData.push(this.data[start + i]);
      } else {
        break;
      }
    }

    payloadReturn = {
      data: paginatedData,
      size: this.size,
      page: this.page,
      total_pages: Math.trunc(this.data.length / this.size),
      status: 200
    };

    if (this.size <= 0) {
      payloadReturn = {
        errors: [{
          title: 'Invalid Parameter.',
          detail: 'size must be a positive integer; got ' + this.size,
          source: { parameter: 'size' },
          status: 400
        }]
      };
    } else if (this.page <= 0) {
      payloadReturn = {
        errors: [{
          title: 'Invalid Parameter.',
          detail: 'page must be a positive integer; got ' + this.page,
          source: { parameter: 'page' },
          status: 400
        }]
      };
    }

    return payloadReturn;
  }
}
