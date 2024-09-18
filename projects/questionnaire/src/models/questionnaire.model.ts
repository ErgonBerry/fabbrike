import mongoose, { Schema, Document } from 'mongoose';

export interface IQuestionnaire extends Document {
    q1: string;
    q2: string;
    q3: string;
    q4: string;
    q5: string;
}

const QuestionnaireSchema: Schema = new Schema({
    q1: { type: String, required: true },
    q2: { type: String, required: true },
    q3: { type: String, required: true },
    q4: { type: String, required: true },
    q5: { type: String, required: true },
});

export default mongoose.model<IQuestionnaire>('Questionnaire', QuestionnaireSchema);
