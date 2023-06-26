import { Router, Response, Request } from "express";
import { RequestWithBody, RequestWithQuery } from "../models/types";
import {
  ChatAllRequestCreateModel,
  ChatDetailRequestModel,
  chatModel,
} from "../models/auth/chat_list_model";
import { chatListRepository } from "../repositories/chat_list_repository";
import { checkAuthMiddleware } from "../middlewares/auth/auth-middlewares";
import {
  chatDetailValidation,
  chatDetailValidationMiddleware,
} from "../middlewares/chat/chat-middleware";

export const chatListRoutes = Router();

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
  chatDetailValidation,
  chatDetailValidationMiddleware,
  async (req: RequestWithQuery<ChatDetailRequestModel>, res: Response) => {
    try {
      let chatData = req.query;

      let findChat = await chatModel.findOne({ id: chatData.id });
      if (findChat == null) throw "";
      res.status(200).json(findChat.messages);
    } catch (e) {
      res.status(404).json("Не удалось загрузить сообщения");
    }
  }
);
