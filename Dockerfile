#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["BankLoginPage1.20/BankLoginPage1.20.csproj", "BankLoginPage1.20/"]
RUN dotnet restore "./BankLoginPage1.20/./BankLoginPage1.20.csproj"
COPY . .
WORKDIR "/src/BankLoginPage1.20"
RUN dotnet build "./BankLoginPage1.20.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./BankLoginPage1.20.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BankLoginPage1.20.dll"]