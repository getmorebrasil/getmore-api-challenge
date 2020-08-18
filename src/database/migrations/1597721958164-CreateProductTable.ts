import {MigrationInterface, QueryRunner} from "typeorm";

export class CreateProductTable1597721958164 implements MigrationInterface {
    name = 'CreateProductTable1597721958164'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "gitmore_api_challenge"."product" ("productId" integer NOT NULL, "productCategory" character varying NOT NULL, "productName" character varying NOT NULL, "productImage" text, "productStock" boolean NOT NULL, "productPrice" numeric(3) NOT NULL, CONSTRAINT "PK_df6b7800e59359cfaa9d3d6e3ef" PRIMARY KEY ("productId"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "gitmore_api_challenge"."product"`);
    }

}
