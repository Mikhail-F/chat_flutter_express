import { NextFunction, Response } from "express";
import { query, validationResult } from "express-validator";
import { ChatDetailRequestModel } from "../../models/auth/chat_list_model";
import { RequestWithQuery } from "../../models/types";

export const chatDetailValidation = query("id")
  .trim()
  .isLength({ min: 1 })
  .withMessage("Нет id чата");

export const chatDetailValidationMiddleware = (
  req: RequestWithQuery<ChatDetailRequestModel>,
  res: Response,
  next: NextFunction
) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).send({ errors: errors.array() });
  }
  next();
};
