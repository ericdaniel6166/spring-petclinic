# Use a base image with Maven to install dependencies
FROM maven:3.9.2-amazoncorretto-17 AS dependencies

# Set the working directory inside the container
WORKDIR /app

# Copy only the pom.xml file to the container
COPY pom.xml .

# Install project dependencies
RUN mvn dependency:go-offline -B

# Use a separate stage to build the application
FROM dependencies AS builder

# Copy the rest of the application source code to the container
COPY . .

# Build the application using Maven
RUN mvn package -DskipTests

# Use a lightweight base image for the final image
FROM amazoncorretto:17-alpine-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the builder stage to the final image
COPY --from=builder /app/target/spring-petclinic-*.jar ./spring-petclinic.jar

# Expose the default port (8080) used by the application
EXPOSE 8080

## Set the entrypoint command to run the application when the container starts
#ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]

# Set the entrypoint command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=postgres", "spring-petclinic.jar"]
