FROM bash:5.0

RUN set -ex; \
    apk add --no-cache --virtual \
        grep \
        sed \
    ; \
    \
    # delete a few installed bits for smaller image size
    rm -rf \
        /usr/local/share/doc/bash/*.html \
        /usr/local/share/info \
        /usr/local/share/locale \
        /usr/local/share/man \
    ; \
    \
    runDeps="$( \
      scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-cache --virtual .bash-rundeps $runDeps; \
    apk del .build-deps
