# Stage 1: Build Stage
FROM maven:3.8.8-eclipse-temurin-8 AS builder
LABEL maintainer="RADHA"

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the project and create a JAR file
RUN mvn clean package -DskipTests

# Stage 2: Runtime Stage
FROM gcr.io/distroless/java:8
LABEL maintainer="RADHA"

# Set the working directory in the runtime image
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar mahesh.jar

# Expose the application port
EXPOSE 8080

# Start the application
CMD ["mahesh.jar"]
