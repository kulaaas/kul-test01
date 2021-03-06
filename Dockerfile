FROM microsoft/dotnet:3.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:3.1-sdk AS build
WORKDIR /src
COPY ["kul-test01.csproj", "./"]
RUN dotnet restore "kul-test01.csproj"
COPY . .

RUN dotnet build "kul-test01.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "kul-test01.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "kul-test01.dll"]
