import { chatModel } from "../models/auth/chat_list_model";

export const chatListRepository = {
  async getAllChats(myId: string) {
    var creatorChats = await chatModel.find({ creatorId: myId });
    var anyChats = await chatModel.find({ anyId: myId });
    var myChats = [...creatorChats, ...anyChats];
    return myChats;
  },

  async createChat(chatData: { name: string; anyId: number }, myId: number) {
    let newChat = new chatModel();

    newChat.id = Math.floor(Math.random() * 1000000000000);
    newChat.name = chatData.name;
    newChat.creatorId = myId;
    newChat.anyId = chatData.anyId;
    newChat = await newChat.save();
  },
};
