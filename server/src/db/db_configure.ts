import mongoose from "mongoose";

export class DBConfigure {
  private dbInit: DBConfigure | undefined;

  get db() {
    if (this.dbInit === undefined) this.dbInit = new DBConfigure();
    return this.dbInit;
  }

  private dbUrl: string =
    "mongodb+srv://messenger:testpassword@cluster0.khudbq2.mongodb.net/?retryWrites=true&w=majority";

  connect() {
    mongoose
      .connect(this.dbUrl)
      .then(() => console.log("Connect to DB"))
      .catch((e) => console.log(e));
  }
}
