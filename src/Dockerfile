FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /src

COPY ./*.sln .
COPY ./*/*.csproj ./
RUN for file in $(ls *.csproj); do mkdir -p ./${file%.*}/ && mv $file ./${file%.*}/; done
RUN dotnet restore ./SaT.Service1.sln

COPY . ./
RUN dotnet build ./SaT.Service1.sln -c Release --no-restore

FROM base AS test-stage
ENTRYPOINT ["dotnet", "test", "-c", "Release", "--logger", "trx", "--results-directory", "testsResults", "--no-build"]

FROM base as publish-stage
RUN dotnet publish ./SaT.Service1.sln --no-build -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
EXPOSE 80
COPY --from=publish-stage /src/out .
ENTRYPOINT ["dotnet", "SaT.Service1.dll"]