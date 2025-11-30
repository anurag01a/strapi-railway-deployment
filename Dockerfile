# =============================================================================
# STRAPI DOCKERFILE FOR RAILWAY
# =============================================================================

# Build stage
FROM node:20-alpine AS build

RUN apk update && apk add --no-cache \
    build-base \
    gcc \
    autoconf \
    automake \
    zlib-dev \
    libpng-dev \
    vips-dev

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source files
COPY . .

# Build admin panel
ENV NODE_ENV=production
RUN npm run build

# Production stage
FROM node:20-alpine AS production

RUN apk add --no-cache vips-dev

WORKDIR /app

# Copy built application
COPY --from=build /app ./

# Create uploads directory and set permissions
RUN mkdir -p /app/public/uploads && \
    chmod 777 /app/public/uploads

ENV NODE_ENV=production
ENV HOST=0.0.0.0

EXPOSE 1337

CMD ["npm", "run", "start"]