/*
  Warnings:

  - The values [PENDIND] on the enum `OrderStatus` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `ingredientes` on the `Product` table. All the data in the column will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "OrderStatus_new" AS ENUM ('PENDING', 'IN_PREPARATION', 'FINISHED');
ALTER TABLE "Order" ALTER COLUMN "status" TYPE "OrderStatus_new" USING ("status"::text::"OrderStatus_new");
ALTER TYPE "OrderStatus" RENAME TO "OrderStatus_old";
ALTER TYPE "OrderStatus_new" RENAME TO "OrderStatus";
DROP TYPE "OrderStatus_old";
COMMIT;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "ingredientes",
ADD COLUMN     "ingredients" TEXT[];
