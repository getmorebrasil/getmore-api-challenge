import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import 'reflect-metadata';
import './database/connection';
import routes from './routes/routes';

const PORT = 3333;
const HOST = '0.0.0.0';

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(routes);

app.listen(PORT, HOST);
