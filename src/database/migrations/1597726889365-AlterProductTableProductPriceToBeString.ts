import {MigrationInterface, QueryRunner} from "typeorm";

export class AlterProductTableProductPriceToBeString1597726889365 implements MigrationInterface {
    name = 'AlterProductTableProductPriceToBeString1597726889365'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "gitmore_api_challenge"."product" DROP COLUMN "productPrice"`);
        await queryRunner.query(`ALTER TABLE "gitmore_api_challenge"."product" ADD "productPrice" text NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "gitmore_api_challenge"."product" DROP COLUMN "productPrice"`);
        await queryRunner.query(`ALTER TABLE "gitmore_api_challenge"."product" ADD "productPrice" numeric(3,0) NOT NULL`);
    }

}
