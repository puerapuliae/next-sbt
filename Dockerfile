FROM puerapuliae/next-java:8u77

ENV SBT_VERSION 0.13.11

RUN mkdir -p /usr/local/bin && wget -P /usr/local/bin/ http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar && ls /usr/local/bin

COPY sbt /usr/local/bin/

# create an empty sbt project;
# then fetch all sbt jars from Maven repo so that your sbt will be ready to be used when you launch the image
COPY init-sbt.sh /tmp/

ENV SCALA_VERSION 2.11.8

RUN cd /tmp  && \
    mkdir -p src/main/scala && \
    echo "object Main {}" > src/main/scala/Main.scala && \
    ./init-sbt.sh  && \
    rm -rf *

# Define default command.
CMD ["sbt"]
