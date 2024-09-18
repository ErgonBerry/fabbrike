import mongoose, { Schema, Document } from 'mongoose';

export interface IExample extends Document {
  name: string;
  description: string;
}

const ExampleSchema: Schema = new Schema({
  name: { type: String, required: true },
  description: { type: String, required: true }
});

export const Example = mongoose.model<IExample>('Example', ExampleSchema);

