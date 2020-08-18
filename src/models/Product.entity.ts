import { Entity, PrimaryColumn, Column } from 'typeorm';

@Entity('product')
export class Product {

  @PrimaryColumn({ unsigned: true })
  productId?: number;

  @Column({ type: 'varchar', nullable: false })
  productCategory?: string;

  @Column({ type: 'varchar', nullable: false })
  productName?: string;

  @Column({ type: 'text', nullable: true })
  productImage?: string;

  @Column({ type: 'boolean', nullable: false })
  productStock?: boolean;

  @Column({ type: 'text', unsigned: true, nullable: false })
  productPrice?: number | string;

};
