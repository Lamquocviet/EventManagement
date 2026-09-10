FROM node:18-alpine

ENV NODE_ENV=production
WORKDIR /app

RUN apk add --no-cache dumb-init

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY . .

# Create uploads directory
RUN mkdir -p uploads && chown -R node:node /app

# Use non-root user
USER node

# Expose port
EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=5 \
  CMD node -e "require('http').get('http://127.0.0.1:5000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1); }).on('error', () => process.exit(1));"

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

CMD ["node", "src/app.js"]
