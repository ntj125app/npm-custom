FROM node:lts-alpine

# Set Cypress Environment Variables
ENV CYPRESS_CACHE_FOLDER=/var/cache/Cypress

# Install git
RUN apk --no-cache update && apk --no-cache upgrade && \
    apk add --no-cache openssh git && \
    mkdir -p ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts && \
    mkdir -p /var/cache/Cypress && chmod a+rwx /var/cache/Cypress && \
    npm install -g npm && \
    npm install -g @ionic/cli native-run @capacitor/core

# Check NPM test
RUN npm --version