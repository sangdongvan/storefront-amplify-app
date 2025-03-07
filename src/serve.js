import express from "express";
// @ts-ignore
import compression from "compression";

// @ts-ignore
import { StorefrontApi } from "./config.gen.js";
// @ts-ignore
import expressjsHandler from "./server/index.js";

// Default port of Amplify hosting
const port = 3000;

const app = express();
app.disable("x-powered-by");

app.set("Config.StorefrontApi", StorefrontApi);

app.use(compression());
app.use(expressjsHandler);

app.listen(port, () => {
  console.log(`server is listening on ${port}`);
});
