import { Hono } from 'hono';
import craftController from './controllers/craftController';
import elementController from './controllers/elementController';

const app = new Hono().basePath("/api");

app.get('/ping', (c) => {
  return c.text('Pong');
});

app.route('/crafts', craftController);
app.route('/elements', elementController);

export default {
	port: 3000,
	fetch: app.fetch,
	idleTimeout: 255
};