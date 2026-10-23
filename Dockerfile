FROM maven:3.10.0-amazoncorretto-21 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package

FROM amazoncorretto:21-headless AS runtime

WORKDIR /app
COPY --from=build /app/target/hackaton-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
USER 10001

ENTRYPOINT ["java", "-jar", "app.jar"]
