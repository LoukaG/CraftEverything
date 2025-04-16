import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const elements = [
    { id: 'water', name: 'Water', icon: '💧' },
    { id: 'fire', name: 'Fire', icon: '🔥' },
    { id: 'earth', name: 'Earth', icon: '🌎' },
    { id: 'wind', name: 'Wind', icon: '🌬️' },
    { id: 'life', name: 'Life', icon: '🧬' }
];

async function main() {
    await Promise.all(
        elements.map((element) =>
            prisma.element.upsert({
                where: { name: element.name },
                update: {},
                create: element,
            })
        )
    );

    console.log('Seed completed!');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(() => prisma.$disconnect());
