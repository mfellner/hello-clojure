FROM ubuntu:15.04

# Install system tools
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

RUN apt-get update && apt-get -y install \
    openjdk-8-jdk \
    wget

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -P /usr/local/bin \
    https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod +x /usr/local/bin/lein

ENV LEIN_ROOT true

RUN lein upgrade

# Build app jar
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

COPY project.clj project.clj

RUN lein install

COPY src/ src/

# Configure Docker container
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

EXPOSE 8080

ENTRYPOINT ["lein", "run"]
