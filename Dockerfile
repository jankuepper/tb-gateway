FROM maven:3.8.2-openjdk-16 AS MAVEN_BUILD

ARG MAVEN_OPTS

COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn package
FROM openjdk:16
COPY --from=MAVEN_BUILD /build/target/*.jar /app.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app.jar" ]