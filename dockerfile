# Stage 1: Build the Angular application
FROM node:16.15 AS builder
# Set the working directory within the container
WORKDIR /usr/src/app
# Copy package.json and package-lock.json to the container
COPY package*.json ./
# Install application dependencies
RUN npm install
# Copy the rest of your application code
COPY . .
# Build the Angular application
RUN npm run build --prod


# Stage 2: Create the Nginx image to serve the built app
FROM nginx:alpine
# Copy the Nginx configuration
COPY src/ngnix/etc/conf.d/default.conf /etc/nginx/conf.d/default.conf
# Copy the build artifacts from the builder stage
COPY --from=builder /app/dist/summer-workshop-angular /usr/share/nginx/html