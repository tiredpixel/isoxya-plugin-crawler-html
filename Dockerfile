# FROMFREEZE docker.io/library/haskell:8.10
FROM docker.io/library/haskell@sha256:709e35840416e118dcb4b954925d0c7b39c7d681f955d2d59e70932cef0cb29c

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        daemontools \
        jq \
        libpcre3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ${USER} -d ${HOME} && \
    mkdir -p ${HOME}/repo && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo

COPY --chown=x:x [ \
    "cabal.project.freeze", \
    "*.cabal", \
    "./"]

RUN cabal update && \
    cabal build --only-dependencies --enable-tests
#-------------------------------------------------------------------------------
ENV PATH=${HOME}/.cabal/bin:$PATH \
    LANG=C.UTF-8

CMD ["cabal", "run", "isoxya-plugin-crawler-html", "--", \
    "-b", "0.0.0.0", "-p", "80"]

EXPOSE 80

HEALTHCHECK CMD curl -fs http://localhost || false
