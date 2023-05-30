import { profileModel } from "../models/auth/profile_model";

export const profileRepository = {
  async getProfile(myId: number) {
    var findUser = await profileModel.find({ id: myId });
    return findUser[0];
  },

  async createProfile(myId: number, name: string) {
    let newUser = new profileModel();
    newUser.id = myId;
    newUser.name = name;
    newUser = await newUser.save();
    return newUser;
  },

  async getAllUsers(myId: number) {
    var allUsers = await profileModel.collection.find().toArray();

    allUsers = allUsers.filter((el) => el.id !== myId);
    return allUsers;
  },
};
