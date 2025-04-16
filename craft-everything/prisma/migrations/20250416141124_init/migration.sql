-- CreateTable
CREATE TABLE "Element" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "icon" VARCHAR(1) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Element_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Craft" (
    "id" TEXT NOT NULL,
    "element1" TEXT NOT NULL,
    "element2" TEXT NOT NULL,
    "resultId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Craft_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Element_name_key" ON "Element"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Craft_element1_element2_key" ON "Craft"("element1", "element2");

-- AddForeignKey
ALTER TABLE "Craft" ADD CONSTRAINT "Craft_element1_fkey" FOREIGN KEY ("element1") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Craft" ADD CONSTRAINT "Craft_element2_fkey" FOREIGN KEY ("element2") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Craft" ADD CONSTRAINT "Craft_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
