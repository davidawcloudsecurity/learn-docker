# Use a Node.js base image
FROM node:18-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build Storybook
RUN npx storybook build -o /app/storybook-static

# Use NGINX to serve Storybook
FROM nginx:alpine

# Copy built Storybook static files
COPY --from=builder /app/storybook-static /usr/share/nginx/html

# Expose port 80 (the default NGINX port)
EXPOSE 80
