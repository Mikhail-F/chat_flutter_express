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

      socket.on("Send message", async ({ id, myId, text }) => {
        try {
          let findChat = (await chatModel.find({ id: id }))[0];
          let nowTime = Date.now();

          findChat.messages.push({ id, myId, text, time: nowTime });
          findChat = await findChat.save();
          io.to(id.toString()).emit("Success send message", { id, myId, text, time: nowTime });
        } catch (e) {
          io.to(id.toString()).emit("Error send message");
        }
      });
    });
  }
}
