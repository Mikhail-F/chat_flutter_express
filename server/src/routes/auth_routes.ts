import { Router, Request, Response } from "express";
import { RequestWithBody, RequestWithQuery } from "../models/types";
import {
  AuthRequestCreateUserModel,
  registerModel,
} from "../models/auth/auth_model";

export const authRoutes = Router();

authRoutes.get(
  "/",
  async (req: RequestWithQuery<AuthRequestCreateUserModel>, res: Response) => {    
    // await registerModel.collection.find().toArray() - Получение всех элементов
    try {
      var query = req.query;

      let findUser = await registerModel.find({
        login: query.login,
        password: query.password,
      });
      console.log("Find user - ", findUser);
      if (findUser.length === 0) throw "";
      res.status(200).json({ accessToken: findUser[0].accessToken });
    } catch (e) {
      console.log("TUT");
      
      res.status(404).send();
    }
  }
);

authRoutes.post(
  "/",
  async (req: RequestWithBody<AuthRequestCreateUserModel>, res: Response) => {
    try {
      const body: AuthRequestCreateUserModel = req.body;
      if (body) {
        var findUser = await registerModel.find({ login: body.login });

        if (findUser.length > 0)
          return res.status(300).json("Такой логин уже зарегистрирован");
        let newUser = new registerModel();
        newUser.login = body.login;
        newUser.password = body.password;
        newUser.accessToken = Math.floor(Math.random() * 1000000000000);
        newUser = await newUser.save();

        res.status(200).send();
      } else throw "";
    } catch (e) {
      res.status(404).json("Ошибка регистрации");
    }
  }
);
