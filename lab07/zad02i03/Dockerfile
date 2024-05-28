FROM node:latest

WORKDIR /app

COPY package.json package-lock.json ./
COPY server.js .

RUN npm install

EXPOSE 3003

CMD ["node", "server.js"]
