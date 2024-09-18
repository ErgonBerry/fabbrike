import { Request, Response } from 'express';

export const exampleController = (req: Request, res: Response) => {
  res.send('Bem-vindo à aplicação Node.js com TypeScript!');
};

