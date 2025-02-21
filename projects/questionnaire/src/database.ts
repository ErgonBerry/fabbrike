import mongoose from 'mongoose';
import dotenv from 'dotenv';

// Carregar as variáveis de ambiente
dotenv.config();

const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017/questionnaire';

export const connectDB = async () => {
  try {
    await mongoose.connect(MONGO_URI);
    console.log('Conectado ao MongoDB');
  } catch (error) {
    console.error('Erro ao conectar ao MongoDB:', error);
    process.exit(1);
  }
};
