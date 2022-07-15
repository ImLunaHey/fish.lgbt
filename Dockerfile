FROM node:18-alpine

# Set work directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install node deps
RUN npm install

# Copy source files
COPY . ./

# Run build script
RUN npm run build

######################################################################
# Above is the build container
# Below is the production container
######################################################################

FROM node:18-alpine

# Set work directory
WORKDIR /app

# Install http-server
RUN npm i -g http-server

# Copy app files from the build image
COPY --from=0 /app/dist/ ./dist
COPY --from=0 /app/dist/index.html ./dist/404.html

# Start http server
CMD http-server --proxy http://localhost:8080? dist