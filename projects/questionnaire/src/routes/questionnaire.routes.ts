import { Router } from 'express';
import { submitQuestionnaire } from '../controllers/questionnaire.controller';

const router = Router();

router.post('/submit', submitQuestionnaire);

export default router;
