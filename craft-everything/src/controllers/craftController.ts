import { Hono } from 'hono';
import { prisma } from '../db';
import { handleCraftGeneration } from '../handlers/handleCraftGeneration';

const craftController = new Hono();

// GET /crafts/:element1/:element2 -> retourne le résultat de la combinaison
craftController.get('/:element1/:element2', async (c) => {
    const { element1, element2 } = c.req.param();

    let craft = await prisma.craft.findFirst({
        where: {
            OR: [
                { element1, element2 },
                { element1: element2, element2: element1 },
            ],
        },
        include: {
            resultElement: true,
        },
    });

    if (craft) {
        return c.json(craft.resultElement);
    }

    const generated = await handleCraftGeneration(element1, element2);

    if (!generated) return c.notFound();

    return c.json(generated);
});

export default craftController;
