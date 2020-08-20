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

    try {
      for(var i = 0; i < this.size; i++) {
        paginatedData.push(this.data[start + i]);
      }

      return {
        data: paginatedData,
        size: this.size,
        page: this.page,
        total_pages: Math.trunc(this.data.length / this.size),
        status: 200
      };
    } catch (error) {
      console.log(error);
    }

    if (this.page <= 0) {
      return {
        errors: [{
          title: 'Invalid Parameter.',
          detail: 'size must be a positive integer; got ' + this.size,
          source: { parameter: 'size' },
          status: 400
        }]
      };
    } if (this.size <= 0) {
      return {
        errors: [{
          title: 'Invalid Parameter.',
          detail: 'page must be a positive integer; got ' + this.page,
          source: { parameter: 'page' },
          status: 400
        }]
      };
    } else {
      return {};
    }
  }
}
