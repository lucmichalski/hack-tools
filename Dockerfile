# This stage installs our modules
FROM mhart/alpine-node:12

WORKDIR /app
COPY package.json ./

# If you have native dependencies, you'll need extra tools
# RUN apk add --no-cache make gcc g++ python3
RUN yarn install

COPY . .

# VOLUME ["/app/dist"]

CMD ["yarn", "build"]
