import { Router, Response, Request } from "express";
import { RequestWithBody } from "../models/types";
import { ProfileRequestCreateUserModel } from "../models/auth/profile_model";
import { profileRepository } from "../repositories/profile_repository";
import { checkAuthMiddleware } from "../middlewares/auth/auth-middlewares";
import {
  profileValidation,
  profileValidationMiddleware,
} from "../middlewares/profile/profile-middleware";

export const profileRoutes = Router();

profileRoutes.use(checkAuthMiddleware);

profileRoutes.get("/", async (req: Request, res: Response) => {
  try {
    let myId = Number(req.headers["token"]);

    var findUser = await profileRepository.getProfile(myId);

    res.status(200).json(findUser);
  } catch (e) {
    res.status(404).json("Не найден пользователь");
  }
});

profileRoutes.post(
  "/",
  profileValidation,
  profileValidationMiddleware,
  async (
    req: RequestWithBody<ProfileRequestCreateUserModel>,
    res: Response
  ) => {
    try {
      let myId = Number(req.headers["token"]);
      let userData = req.body;

      var newUser = await profileRepository.createProfile(myId, userData.name);
      res.status(200).json(newUser);
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
