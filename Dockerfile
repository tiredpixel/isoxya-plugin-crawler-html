# FROMFREEZE docker.io/library/haskell:8.10
FROM docker.io/library/haskell@sha256:82ac8f76e8608ac4f99adf3f9464b4a005469978c343141d74e6fb173879a8f8

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        daemontools \
        happy \
        hlint \
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
    "cabal.config", \
    "*.cabal", \
    "./"]

RUN cabal update && \
    cabal install --only-dependencies
#-------------------------------------------------------------------------------
ENV PATH=${HOME}/.cabal/bin:$PATH \
    LANG=C.UTF-8

CMD ["cabal", "run", "isoxya-plugin-crawler-html", "--", \
    "-b", "0.0.0.0", "-p", "8000"]

EXPOSE 8000

HEALTHCHECK CMD curl -fs http://localhost:8000 || false
