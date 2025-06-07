import express from "express";
import dotenv from "dotenv";
import morgan from "morgan";

dotenv.config();

export const port = process.env.PORT || 8080;

export const app = express();

app.use(morgan("dev"));
app.use(express.urlencoded({ extended: true }));
