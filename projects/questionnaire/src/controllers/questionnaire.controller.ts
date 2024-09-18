import { Request, Response } from 'express';
import Questionnaire from '../models/questionnaire.model';

export const submitQuestionnaire = async (req: Request, res: Response) => {
    try {
        const { q1, q2, q3, q4, q5 } = req.body;
        const newEntry = new Questionnaire({ q1, q2, q3, q4, q5 });
        await newEntry.save();
        res.status(200).send('Questionário enviado com sucesso!');
    } catch (error) {
        res.status(500).send('Erro ao enviar o questionário.');
    }
};
