# Start from the latest golang image
FROM golang:latest

LABEL maintainer="Jeremy Muhia <jmuhia80@gmail.com>"

# Set the working directory in the container
WORKDIR /go/src/github.com/veganafro/mono/

# Copy local files into the container's working directory
COPY . .

# Read the project argument from the yml file
ARG project

# Build the go module
RUN go build -o main $project

CMD ["./main"]

