# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Cd into the api gateway code directory
WORKDIR /go/src/github.com/clarenceyou/log-sample

# Download the wait-for-me.sh script
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh .
RUN chmod +x ./wait-for-it.sh

# Create a new unprivileged user
RUN useradd --user-group --shell /bin/false gps

# Chown /go/src/github.com/yougroupteam/you-gps/ to gps user
RUN chown -R gps:gps /go/src/github.com/clarenceyou/log-sample

# Use the unprivileged user
USER gps

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/clarenceyou/log-sample

# Install the gps program
RUN go install .

# Set environment variables
ENV PATH /go/bin:$PATH

# Copy the docker-entrypoint.sh script and use it as entrypoint
# COPY ./docker-entrypoint.sh .
# ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["log-sample"]
