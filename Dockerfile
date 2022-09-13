# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM golang:alpine AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
WORKDIR /app
COPY app /app
RUN echo "Built on $BUILDPLATFORM to run on $TARGETPLATFORM" > /app/msg
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags="-s -w"  -o archapp
RUN chmod +x /app/archapp

FROM scratch
COPY --from=build /app /app
ENTRYPOINT ["/app/archapp"]
