export default class Paginator {

  data: any[];
  page: number;
  size: number;

  constructor(dataToPaginate: any[], page: any = '1', size: any = '10') {
    this.data = dataToPaginate;
    this.page = Math.floor(+page);
    this.size = Math.floor(+size);
  }

  apply() {
    const paginatedData: any[] = [];
    const offset: number = this.size;
    const final: number = offset * this.page;
    const start: number = final - offset;
    const processingData = this.data[0];
    const totalPages: number = Math.ceil(processingData.length / this.size);

    for(var i = 0; i < this.size; i++) {
      const position: number = start + i;
      if (typeof processingData[position] !== 'undefined') {
        paginatedData.push(processingData[position]);
      } else {
        break;
      }
    }

    var payloadReturn: any = {
      data: this.page <= totalPages ? paginatedData.filter(() => (true)) : {},
      metadata: [{
        size: this.size,
        page: this.page,
        total_pages: totalPages
      }]
    };

    if (this.size <= 0) {
      payloadReturn = {
        errors: [{
          title: 'Invalid Parameter.',
          detail: 'size must be a positive integer; got ' + this.size,
          source: { parameter: 'size' }
        }]
      };
    } else if (this.page <= 0) {
      payloadReturn = {
        errors: [{
          title: 'Invalid Parameter.',
          detail: 'page must be a positive integer; got ' + this.page,
          source: { parameter: 'page' }
        }]
      };
    }

    return payloadReturn;
  }
}
