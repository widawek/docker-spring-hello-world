FROM gradle:7.2.0-jdk11 as builder

COPY --chown=gradle:gradle build.gradle /home/gradle/src/
COPY --chown=gradle:gradle src /home/gradle/src/src

WORKDIR /home/gradle/src

RUN gradle clean build --no-daemon


FROM openjdk:11-jre-slim

COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-hello-world.jar

WORKDIR /app

CMD ["java", "-jar", "spring-hello-world.jar"]