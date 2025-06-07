# Build stage
FROM node:20-alpine AS builder

# 作業ディレクトリの設定
WORKDIR /app

# 依存関係ファイルのコピー
COPY package*.json ./

# ソースコードのコピー
COPY . .

# TypeScriptのビルド
RUN npm run build

# Production stage
FROM node:20-alpine

WORKDIR /app

# Copy package.json and lock file
COPY --from=builder /app/package*.json ./

# 🔥 Install only production dependencies
RUN npm install --only=production

# Copy the built app
COPY --from=builder /app/dist ./dist

# Security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "dist/index.js"]

