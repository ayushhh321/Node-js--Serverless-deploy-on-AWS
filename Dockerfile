FROM node:18

WORKDIR use/src/app

COPY package.json ./
COPY package-lock.json ./

RUN npm install

COPY . .



CMD ["node", "index.js"]


