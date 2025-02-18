# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy the project file and restore dependencies
COPY dejting-yarp/dejting-yarp.csproj ./dejting-yarp/
RUN dotnet restore "./dejting-yarp/dejting-yarp.csproj"

# Copy the rest of the application files
COPY dejting-yarp/ ./dejting-yarp/

# Build and publish the application
RUN dotnet publish "./dejting-yarp/dejting-yarp.csproj" -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose port 80
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "dejting-yarp.dll"]