import { registerModel } from "../models/auth/auth_model";

export const authRepository = {
  async findUser(login: string, password: string | null) {
    var data: {
      [key: string]: string;
    } = {
      login: login,
    };
    if (password) {
      data["password"] = password;
    }

    return await registerModel.find(data);
  },

  async createUser(login: string, password: string) {
    let newUser = new registerModel();
    newUser.login = login;
    newUser.password = password;
    newUser.accessToken = Math.floor(Math.random() * 1000000000000);
    await newUser.save();
  },
};
