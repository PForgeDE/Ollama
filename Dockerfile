FROM ollama/ollama:latest

LABEL maintainer="PForge"       description="Ollama with Qwen 3 30B pre-loaded - Unraid optimized"       org.opencontainers.image.source="https://github.com/gsgphoenix/ollama-qwen3-unraid"

# Default model to pull (can be overridden via ENV)
ENV OLLAMA_MODEL=qwen3:30b
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_KEEP_ALIVE=-1
ENV OLLAMA_MAX_LOADED_MODELS=2

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 11434

ENTRYPOINT ["/entrypoint.sh"]
