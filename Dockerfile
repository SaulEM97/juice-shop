FROM node:22-alpine

# Create non-root user
RUN addgroup -g 10001 app && adduser -u 10001 -G app -s /bin/sh -D app

WORKDIR /app

# Copy source and install deps as root
COPY . .
RUN npm ci

# Fix permissions so runtime user can write
RUN chown -R app:app /app

ENV NODE_ENV=production
EXPOSE 3000

USER app
CMD ["npm", "start"]

