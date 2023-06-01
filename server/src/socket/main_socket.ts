import { Server } from "socket.io";
import { chatModel } from "../models/auth/chat_list_model";

export class MainSocket {
  init(server: any) {
    console.log("TUT");

    const io = new Server(server);

    io.on("connection", (socket) => {
      console.log("Socket connected!");

      socket.on("Add new chat", () => {
        io.emit("Update all chats");
      });

      socket.on("Chat detail join/leave", ({ id, isJoin }) => {
        console.log(id + " " + isJoin);

        if (isJoin) socket.join(id.toString());
        else socket.leave(id.toString());
      });

      socket.on("Send message", async ({ chatId, myId, text }) => {
        try {
          let findChat = (await chatModel.find({ id: chatId }))[0];
          let nowTime = Date.now();
          let msg = { id: nowTime, myId, text, time: nowTime };

          findChat.messages.push(msg);
          findChat.lastMessage = msg;

          await findChat.save();
          io.to(chatId.toString()).emit("Success send message", {
            ...msg,
            chatId: chatId,
          });
        } catch (e) {
          io.to(chatId.toString()).emit("Error send message");
        }
      });

      socket.on("Remove message", async ({ chatId, id }) => {
        try {
          let findChat = (await chatModel.find({ id: chatId }))[0];

          findChat.messages = findChat.messages.filter((el) => el.id != id);

          findChat = await findChat.save();
          io.to(chatId.toString()).emit("Success remove message", {
            id,
          });
        } catch (e) {
          io.to(chatId.toString()).emit("Error remove message");
        }
      });
    });
  }
}
