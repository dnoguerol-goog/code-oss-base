FROM golang:1.24
RUN apt install git -y
RUN cd /; git clone https://github.com/GoogleCloudPlatform/vertex-ai-creative-studio.git; cd /vertex-ai-creative-studio/experiments/mcp-genmedia/mcp-genmedia-go; go work sync; cd mcp-imagen-go; go build -o mcp-imagen-go

FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest
RUN sudo apt update
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN sudo apt install python3.12-venv -y
RUN mkdir -p /usr/local/go/bin
COPY --from=0 /vertex-ai-creative-studio/experiments/mcp-genmedia/mcp-genmedia-go/mcp-imagen-go/mcp-imagen-go /usr/local/go/bin

COPY 025_google-install.sh /etc/workstation-startup.d/025_google-install.sh
COPY ws-setup.sh /usr/local/bin

COPY customize_environment /tmp/customize_environment
COPY settings.json /tmp/settings.json
RUN chmod +x /etc/workstation-startup.d/025_google-install.sh; chmod +x /tmp/customize_environment