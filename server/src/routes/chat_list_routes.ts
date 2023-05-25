import { Router, Response, Request } from "express";
import { RequestWithBody, RequestWithQuery } from "../models/types";
import { profileModel } from "../models/auth/profile_model";
import {
  ChatAllRequestCreateModel,
  ChatDetailRequestModel,
  ChatRequestMessageModel,
  chatModel,
} from "../models/auth/chat_list_model";

export const chatListRoutes = Router();

chatListRoutes.get("/", async (req: Request, res: Response) => {
  var myId = req.headers['token'];
  console.log("TUT" + myId);
  try {
    if (myId) {
      var creatorChats = await chatModel.find({ creatorId: myId });
      var anyChats = await chatModel.find({ anyId: myId });
      var myChats = [...creatorChats, ...anyChats]
      console.log(myChats);
      
      res.status(200).json(myChats);
    } else {
      throw "";
    }
  } catch (e) {
    res.status(404).json("Чаты не найены");
  }
});

chatListRoutes.post(
  "/",
  async (req: RequestWithBody<ChatAllRequestCreateModel>, res: Response) => {
    try {
      let chatData = req.body;
      let myId = Number(req.headers['token']);

      if (chatData) {
        let newChat = new chatModel();

        newChat.id = Math.floor(Math.random() * 1000000000000);
        newChat.name = chatData.name;
        newChat.creatorId = myId;
        newChat.anyId = chatData.anyId;
        newChat = await newChat.save();

        res.status(200).json(newChat);
      } else {
        throw "";
      }
    } catch (e) {
      res.status(404).json("Не удалось создать чат");
    }
  }
);

chatListRoutes.get(
  "/chatDetail",
  async (req: RequestWithQuery<ChatDetailRequestModel>, res: Response) => {
    try {
      let chatData = req.query;

      if (chatData) {
        let findChat = (await chatModel.find({id: chatData.id}))[0];

        res.status(200).json(findChat.messages);
      } else {
        throw "";
      }
    } catch (e) {
      res.status(404).json("Не удалось загрузить сообщения");
    }
  }
);
