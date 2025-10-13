FROM node:22.20-alpine3.21 as Builder

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm ci

FROM node:22.20-alpine3.21

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app/node_modules ./node_modules
COPY --chown=appuser:appgroup . .
USER appuser

EXPOSE 3000

CMD ["node", "index.js"]

