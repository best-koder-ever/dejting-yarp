# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy the project file and restore dependencies
COPY src/dejting-yarp/dejting-yarp.csproj src/dejting-yarp/
RUN dotnet restore "src/dejting-yarp/dejting-yarp.csproj"

# Copy the rest of the application files
COPY src/dejting-yarp/ src/dejting-yarp/
COPY src/dejting-yarp.Tests/ src/dejting-yarp.Tests/ # Assuming tests might be needed in build

# Build and publish the application
RUN dotnet publish "src/dejting-yarp/dejting-yarp.csproj" -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose port 80
EXPOSE 8080

# Set the entry point for the application
ENTRYPOINT ["dotnet", "dejting-yarp.dll"]