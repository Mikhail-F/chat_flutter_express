import mongoose from "mongoose";

export type ProfileRequestCreateUserModel = {
  id: string;
  name: string;
};

export type ProfileResponseUserModel = {
  id: string;
  name: string;
};

export type ProfileResponseChatUserModel = {
  id: string;
  name: string;
};

const profileSchema = new mongoose.Schema({
  id: {
    type: Number,
    require: true,
  },
  name: {
    type: String,
    require: true,
  },
});

export const profileModel = mongoose.model("ProfileUser", profileSchema);
