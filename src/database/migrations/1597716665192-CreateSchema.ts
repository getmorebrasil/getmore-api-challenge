import {MigrationInterface, QueryRunner} from "typeorm";

export class CreateSchema1597716665192 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
      queryRunner.createSchema('getmore_api_challenge', true);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
      queryRunner.dropSchema('getmore_api_challenge');
    }

}
