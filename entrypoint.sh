#!/bin/bash
set -e

MODEL=${OLLAMA_MODEL:-qwen3:1.7b}

echo "Starting Ollama server..."
ollama serve &
OLLAMA_PID=$!

# Wait for Ollama to be ready (curl OR wget fallback, 120s for ARM)
echo "Waiting for Ollama to be ready..."
READY=0
for i in $(seq 1 60); do
    if curl -sf http://localhost:11434/api/tags > /dev/null 2>&1; then
        READY=1; break
    elif wget -q -O /dev/null http://localhost:11434/api/tags 2>/dev/null; then
        READY=1; break
    fi
    sleep 2
done

if [ "$READY" -eq 0 ]; then
    echo "Ollama did not start in time (120s timeout)"
    exit 1
fi

echo "Ollama is ready!"

# Always pull/update model on start
echo "Pulling/updating model: ${MODEL}..."
ollama pull "${MODEL}"
echo "Model ${MODEL} is up to date!"

echo "Ollama with ${MODEL} is ready! API: http://0.0.0.0:11434"

# Keep the server running
wait $OLLAMA_PID
