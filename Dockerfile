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

# Use the official Tomcat image as the runtime environment
FROM tomcat:8.5-jdk8-openjdk-slim

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build environment to the runtime environment
COPY --from=build target/demo.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]