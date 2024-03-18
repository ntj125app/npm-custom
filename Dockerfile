FROM debian:12-slim

ENV NODE_PACKAGE_VERSION=8.15.0
ENV NPM_PACKAGE_VERSION=6.4.1

# INSTALL NODE
RUN apt-get update && apt-get install -y curl xz-utils && \
    curl -o node-v8.15.0-linux-x64.tar.xz https://nodejs.org/dist/v8.15.0/node-v8.15.0-linux-x64.tar.xz && \
    tar -xf node-v8.15.0-linux-x64.tar.xz && \
    mv node-v8.15.0-linux-x64 /opt/nodejs && \
    ln -s /opt/nodejs/bin/node /usr/local/bin/node && \
    ln -s /opt/nodejs/bin/npm /usr/local/bin/npm && \
    ln -s /opt/nodejs/bin/npx /usr/local/bin/npx && \
    rm -f node-v8.15.0-linux-x64.tar.xz && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # SMOKE TEST
    node -v && \
    npm -v && \
    npx -v

# ADD ENTRYPOINT
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["node"]
