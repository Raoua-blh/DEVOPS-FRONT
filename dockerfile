# Stage 1: Build the Angular application
FROM node:16.15 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Stage 2: Create the Nginx image to serve the built app
FROM nginx:alpine
COPY src/nginx/etc/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist/summer-workshop-angular /usr/share/nginx/html