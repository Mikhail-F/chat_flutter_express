import express, { Request, Response } from "express";
import { authRoutes } from "./routes/auth_routes";
import bodyParser from "body-parser";
import { DBConfigure } from "./db/db_configure";
import { MainSocket } from "./socket/main_socket";
import { createServer } from "http";
import { profileRoutes } from "./routes/profile.routes";
import { chatListRoutes } from "./routes/chat_list_routes";

require('dotenv').config()

export const app = express();

// const jsonParser = bodyParser()
app.use(express.json());

const server = createServer(app);

new DBConfigure().db!.connect();

new MainSocket().init(server);

app.use("/auth", authRoutes);
app.use("/profile", profileRoutes);
app.use("/allChats", chatListRoutes);

app.get("/", (req: Request, res: Response) => {
  res.status(200).send({ title: "Work" });
});

const port = process.env.PORT || 3000;

server.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
