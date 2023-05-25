import mongoose from "mongoose";

export type AuthRequestCreateUserModel = {
  login: string;
  password: string;
};

const registerSchema = new mongoose.Schema({
  accessToken: {
    type: Number,
    require: true,
  },
  login: {
    type: String,
    require: true,
  },
  password: {
    type: String,
    require: true,
  },
});

export const registerModel = mongoose.model("RegisterUsers", registerSchema)
