import mongoose from "mongoose";

export type ChatAllRequestCreateModel = {
  anyId: number;
  name: string;
};

export type ChatAllResponseModel = {
  id: string;
  name: string;
};

export type ChatRequestMessageModel = {
  id: number;
  text: string;
  time: number;
};

export type ChatDetailRequestModel = {
  id: number;
};

const chatSchema = new mongoose.Schema({
  id: {
    type: Number,
    require: true,
  },
  creatorId: {
    type: Number,
    require: true,
  },
  anyId: {
    type: Number,
    require: true,
  },
  name: {
    type: String,
    require: true,
  },
  messages: {
    type: [],
    default: [],
  },
});

export const chatModel = mongoose.model("сhats", chatSchema);
