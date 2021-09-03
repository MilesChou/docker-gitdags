FROM alpine:3.14

LABEL org.opencontainers.image.source https://github.com/MilesChou/docker-gitdags

RUN set -xe && \
        apk add --no-cache \
            curl \
            imagemagick \
            make \
            perl

COPY ./texlive.profile /opt

# Install texlive
RUN set -xe && \
        cd /opt &&\
        curl -LO mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
        tar xzf install-tl-unx.tar.gz && rm -f install-tl-unx.tar.gz && \
        mv install-tl-[0-9]* install-tl && \
        /opt/install-tl/install-tl -profile /opt/texlive.profile && \
        rm -rf /opt/install-tl/ /opt/texlive.profile

# Install gitdags
RUN set -xe && \
        mkdir -p /root/texmf/tex/latex && \
        cd /root/texmf/tex/latex && \
        curl -LO https://github.com/jubobs/xcolor-solarized/archive/refs/heads/master.zip && \
        unzip master.zip && rm master.zip && \
        curl -LO https://github.com/jubobs/gitdags/archive/refs/heads/master.zip && \
        unzip master.zip && rm master.zip

WORKDIR /tex

ENV LATEX_TO_PDF=0;
ENV LATEX_TO_PNG=1;

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
