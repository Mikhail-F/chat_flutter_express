import { Router, Response, Request } from "express";
import { RequestWithBody } from "../models/types";
import {
  ProfileRequestCreateUserModel,
  profileModel,
} from "../models/auth/profile_model";
import { profileRepository } from "../repositories/profile_repository";

export const profileRoutes = Router();

profileRoutes.get("/", async (req: Request, res: Response) => {
  try {
    let myId = Number(req.headers["token"]);

    if (myId) {
      var findUser = await profileRepository.getProfile(myId);

      res.status(200).json(findUser);
    } else {
      throw "";
    }
  } catch (e) {
    res.status(404).json("Не найден пользователь");
  }
});

profileRoutes.post(
  "/",
  async (
    req: RequestWithBody<ProfileRequestCreateUserModel>,
    res: Response
  ) => {
    try {
      let myId = Number(req.headers["token"]);
      let userData = req.body;

      if (userData) {
        var newUser = await profileRepository.createProfile(
          myId,
          userData.name
        );
        res.status(200).json(newUser);
      } else {
        throw "";
      }
    } catch (e) {
      res.status(404).json("Не удалось создать аккаунт");
    }
  }
);

profileRoutes.get("/allUsers", async (req: Request, res: Response) => {
  try {
    let myId = Number(req.headers["token"]);
    var allUsers = await profileRepository.getAllUsers(myId);

    res.status(200).json(allUsers);
  } catch (e) {
    res.status(404).json("Пользователи не найдены");
  }
});
