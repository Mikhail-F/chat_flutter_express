import { Router, Response } from "express";
import { RequestWithBody, RequestWithQuery } from "../models/types";
import { AuthRequestCreateUserModel } from "../models/auth/auth_model";
import { authRepository } from "../repositories/auth_repository";
import {
  inputValidationMiddleware,
  loginValidation,
  loginCreateAccountValidation,
} from "../middlewares/auth/auth-middlewares";

export const authRoutes = Router();

authRoutes.get(
  "/",
  loginValidation,
  inputValidationMiddleware,
  async (req: RequestWithQuery<AuthRequestCreateUserModel>, res: Response) => {
    // await registerModel.collection.find().toArray() - Получение всех элементов
    try {
      var query = req.query;

      let findUser = await authRepository.findUser(query.login, query.password);
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
  loginCreateAccountValidation,
  inputValidationMiddleware,
  async (req: RequestWithBody<AuthRequestCreateUserModel>, res: Response) => {
    try {
      const body: AuthRequestCreateUserModel = req.body;
      if (body) {
        let findUser = await authRepository.findUser(body.login, null);

        if (findUser.length > 0)
          return res.status(300).json("Такой логин уже зарегистрирован");
        await authRepository.createUser(body.login, body.password);

        res.status(200).send();
      } else throw "";
    } catch (e) {
      res.status(404).json("Ошибка регистрации");
    }
  }
);
