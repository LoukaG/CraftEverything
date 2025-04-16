import { Hono } from 'hono';
import { prisma } from '../db';

const elementController = new Hono();


// GET /elements/:id -> récupère un élément par ID
elementController.get('/:id', async (c) => {
  const { id } = c.req.param();

  const element = await prisma.element.findUnique({
    where: { id },
  });

  if (!element) {
    return c.notFound();
  }

  return c.json(element);
});


export default elementController;
