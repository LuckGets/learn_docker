# Set up the baseImage
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm config set strict-ssl false
RUN npm install --force --loglevel verbose, logging level
COPY . . 
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
