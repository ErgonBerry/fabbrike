import { Router } from 'express';
import { exampleController } from '../controllers/exampleController';

const router = Router();

// Definir rotas aqui
router.get('/', exampleController);

export default router;

