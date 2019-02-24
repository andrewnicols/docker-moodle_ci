FROM bash:5.0

RUN set -ex; \
    apk add --no-cache --virtual \
        grep \
        sed
