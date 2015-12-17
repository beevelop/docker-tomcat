FROM beevelop/java

MAINTAINER Maik Hummel <m@ikhummmel.com>

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.30
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p "$CATALINA_HOME"

WORKDIR $CATALINA_HOME

RUN set -x && \
    apt-get update && apt-get install -y curl && \
    curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz && \
    tar -xvf tomcat.tar.gz --strip-components=1 && \
    
    # cleanup
    rm bin/*.bat && \
    rm tomcat.tar.gz*

EXPOSE 8080
CMD ["catalina.sh", "run"]
