
OAFROM mcr.microsoft.com/dotnet/core/sdk:2.1 as builder

WORKDIR /Worker
COPY src/Worker/Worker.csproj .
RUN dotnet restore

COPY src/Worker/ .
RUN dotnet publish -c Release -o /out Worker.csproj

# app image

FROM mcr.microsoft.com/dotnet/core/runtime:2.1

WORKDIR /app
ENTRYPOINT ["dotnet", "Worker.dll"]

COPY --from=builder /out .

CMD [echo test]
