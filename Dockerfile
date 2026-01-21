# Stage 1: build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia tutto il progetto
COPY . .

# Sostituisci "FieldPro.Api.csproj" col nome reale del tuo csproj
RUN dotnet restore "./FieldPro.Api.csproj"
RUN dotnet publish "./FieldPro.Api.csproj" -c Release -o /app/publish

# Stage 2: runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

# Porta standard per ASP.NET
EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "FieldPro.Api.dll"]
