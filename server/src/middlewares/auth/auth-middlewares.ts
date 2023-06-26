import { NextFunction, Request, Response } from "express";
import { body, query, validationResult } from "express-validator";

export const checkAuthMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let myId = Number(req.headers["token"]);

  if (myId) {
    next();
  } else {
    res.status(401).json("Вы не авторизованы");
  }
};

export const loginValidation = query(["login", "password"])
  .trim()
  .isLength({ min: 1 })
  .withMessage("Введтие логин и пароль");

export const loginCreateAccountValidation = body(["login", "password"])
  .trim()
  .isLength({ min: 1 })
  .withMessage("Введтие логин и пароль");

export const inputValidationMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).send({ errors: errors.array() });
  }
  next();
};
