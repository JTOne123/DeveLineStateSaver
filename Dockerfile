# Stage 1
FROM microsoft/dotnet:2.2-sdk AS builder
WORKDIR /source

# caches restore result by copying csproj file separately
#COPY /NuGet.config /source/
COPY /DeveLineStateSaver/*.csproj /source/DeveLineStateSaver/
COPY /DeveLineStateSaver.ConsoleApp/*.csproj /source/DeveLineStateSaver.ConsoleApp/
COPY /DeveLineStateSaver.Tests/*.csproj /source/DeveLineStateSaver.Tests/
COPY /DeveLineStateSaver.sln /source/
RUN ls
RUN dotnet restore

# copies the rest of your code
COPY . .
RUN dotnet build --configuration Release
RUN dotnet test --configuration Release ./DeveLineStateSaver.Tests/DeveLineStateSaver.Tests.csproj
RUN dotnet publish ./DeveLineStateSaver.ConsoleApp/DeveLineStateSaver.ConsoleApp.csproj --output /app/ --configuration Release

# Stage 2
FROM microsoft/2.2-runtime
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "DeveLineStateSaver.ConsoleApp.dll"]