import request from "supertest";
import { app } from "../src";

describe("/auth", () => {
  const userAuthDataTest = {
    login: `admin${Math.floor(Math.random() * 1000000000000)}`,
    password: "admin",
  };

  it("Create account", async () => {
    await request(app).post("/auth").send(userAuthDataTest).expect(200);
  });

  it("Login", async () => {
    await request(app).get("/auth").query(userAuthDataTest).expect(200);
  });
});

describe("/profile", () => {
  const userAuthDataTest = {
    id: `admin${Math.floor(Math.random() * 1000000000000)}`,
    name: "admin",
  };

  it("Create profile", async () => {
    await request(app).post("/profile").send(userAuthDataTest).expect(200);
  });

  // it("Get profile", async () => {
  //   await request(app).get("/profile").query(userAuthDataTest).expect(200);
  // });
});