#!/bin/bash
set -e

MODEL=${OLLAMA_MODEL:-qwen3:1.7b}

echo "🚀 Starting Ollama server..."
ollama serve &
OLLAMA_PID=$!

# Wait for Ollama to be ready
echo "⏳ Waiting for Ollama to be ready..."
for i in $(seq 1 30); do
    if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
        echo "✅ Ollama is ready!"
        break
    fi
    sleep 2
    if [ "$i" -eq 30 ]; then
        echo "❌ Ollama did not start in time"
        exit 1
    fi
done

# Always pull/update model on start
echo "📦 Pulling/updating model: ${MODEL}..."
ollama pull "${MODEL}"
echo "✅ Model ${MODEL} is up to date!"

echo "🎉 Ollama with ${MODEL} is ready! API: http://0.0.0.0:11434"

# Keep the server running
wait $OLLAMA_PID
