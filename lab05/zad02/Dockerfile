FROM node:latest

WORKDIR /usr/src/app

COPY ./app /usr/src/app

RUN npm install

ENV MY_VARIABLE my_value

CMD ["node", "app.js"]
