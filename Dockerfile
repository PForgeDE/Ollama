FROM ollama/ollama:latest

LABEL maintainer="PForge" \
      description="Ollama with Qwen 3 - CPU optimized for Unraid" \
      org.opencontainers.image.source="https://github.com/PForgeDE/Ollama"

# Default model (small Qwen3, pulled at runtime - not baked in)
ENV OLLAMA_MODEL=qwen3:1.7b
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_KEEP_ALIVE=-1

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 11434

ENTRYPOINT ["/entrypoint.sh"]
