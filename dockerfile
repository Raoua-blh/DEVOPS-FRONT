FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod


FROM nginx:latest
# Copy the Nginx configuration
COPY src/ngnix/etc/conf.d/default.conf /etc/nginx/conf.d/default.conf
# Copy the build artifacts from the builder stage
COPY --from=builder /app/dist/summer-workshop-angular /usr/share/nginx/html
# The Nginx image should have the CMD to start Nginx, so no need to specify it here