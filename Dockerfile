# Use the official Apache Maven image as the build environment
FROM maven:3.8.3-openjdk-8-slim AS build

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the dependencies and keep them in the Docker cache
RUN mvn dependency:go-offline -B

# Copy the application source code to the container
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk8-openjdk-slim

# Change ownership of the copied files
RUN chown -R root:root /usr/local/tomcat/webapps

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --chown=root:root ./target/demo.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]


