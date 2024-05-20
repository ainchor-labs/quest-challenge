FROM node:latest
COPY src src
COPY package.json .
RUN npm install
EXPOSE 3000

ENTRYPOINT ["npm", "start"]