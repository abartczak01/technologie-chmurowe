FROM node:latest
RUN apt update && apt install -y iputils-ping
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["npm", "start"]