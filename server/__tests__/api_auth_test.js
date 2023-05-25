"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const supertest_1 = __importDefault(require("supertest"));
const src_1 = require("../src");
describe("/auth", () => {
    const userAuthDataTest = {
        login: `admin${Math.floor(Math.random() * 1000000000000)}`,
        password: "admin",
    };
    it("Create account", () => __awaiter(void 0, void 0, void 0, function* () {
        yield (0, supertest_1.default)(src_1.app).post("/auth").send(userAuthDataTest).expect(200);
    }));
    it("Login", () => __awaiter(void 0, void 0, void 0, function* () {
        yield (0, supertest_1.default)(src_1.app).get("/auth").query(userAuthDataTest).expect(200);
    }));
});
describe("/profile", () => {
    const userAuthDataTest = {
        id: `admin${Math.floor(Math.random() * 1000000000000)}`,
        name: "admin",
    };
    it("Create profile", () => __awaiter(void 0, void 0, void 0, function* () {
        yield (0, supertest_1.default)(src_1.app).post("/profile").send(userAuthDataTest).expect(200);
    }));
    // it("Get profile", async () => {
    //   await request(app).get("/profile").query(userAuthDataTest).expect(200);
    // });
});
