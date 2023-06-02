import { Router, Response, Request, NextFunction } from "express";
import { RequestWithBody, RequestWithQuery } from "../models/types";
import { profileModel } from "../models/auth/profile_model";
import {
  ChatAllRequestCreateModel,
  ChatDetailRequestModel,
  ChatRequestMessageModel,
  chatModel,
} from "../models/auth/chat_list_model";
import { chatListRepository } from "../repositories/chat_list_repository";

export const chatListRoutes = Router();

const checkAuthMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let myId = Number(req.headers["token"]);

  if (myId) {
    next();
  } else {
    res.status(401).json("Вы не авторизованы");
  }
};

chatListRoutes.use(checkAuthMiddleware);

chatListRoutes.get("/", async (req: Request, res: Response) => {
  var myId = req.headers["token"];
  console.log("TUT" + myId);
  try {
    var myChats = await chatListRepository.getAllChats(myId as string);
    console.log(myChats);

    res.status(200).json(myChats);
  } catch (e) {
    res.status(404).json("Чаты не найены");
  }
});

chatListRoutes.post(
  "/",
  async (req: RequestWithBody<ChatAllRequestCreateModel>, res: Response) => {
    try {
      let chatData = req.body;
      let myId = Number(req.headers["token"]);

      if (chatData) {
        var newChat = await chatListRepository.createChat(chatData, myId);
        console.log(newChat);

        if (typeof newChat === "string")
          return res.status(300).json({ errorText: newChat });
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
        let findChat = (await chatModel.find({ id: chatData.id }))[0];

        res.status(200).json(findChat.messages);
      } else {
        throw "";
      }
    } catch (e) {
      res.status(404).json("Не удалось загрузить сообщения");
    }
  }
);
