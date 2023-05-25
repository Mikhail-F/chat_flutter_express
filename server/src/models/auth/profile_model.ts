import mongoose from "mongoose";
import { chatModel } from "./chat_list_model";

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
  chatList: {
    type: [Number],
    default: [],
  },
});

export const profileModel = mongoose.model("ProfileUser", profileSchema);
