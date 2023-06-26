import { NextFunction, Response } from "express";
import { query, validationResult } from "express-validator";
import { RequestWithBody } from "../../models/types";
import { ProfileRequestCreateUserModel } from "../../models/auth/profile_model";

export const profileValidation = query("id")
  .trim()
  .isLength({ min: 1 })
  .withMessage("Нет имени юзера");

export const profileValidationMiddleware = (
  req: RequestWithBody<ProfileRequestCreateUserModel>,
  res: Response,
  next: NextFunction
) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).send({ errors: errors.array() });
  }
  next();
};
