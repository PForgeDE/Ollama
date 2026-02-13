#!/bin/bash
set -e

echo 🚀 Starting Ollama server...
ollama serve &
OLLAMA_PID=

# Wait for Ollama to be ready
echo ⏳ Waiting for Ollama to be ready...
for i in 1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30; do
    if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
        echo ✅ Ollama is ready!
        break
    fi
    sleep 2
    if [ $i -eq 30 ]; then
        echo ❌ Ollama did not start in time
        exit 1
    fi
done

# Pull the model if not already present
MODEL=${OLLAMA_MODEL:-qwen3:30b}
echo "📦 Checking model: ${MODEL}..."

if ! ollama list | grep -q "${MODEL}"; then
    echo "⬇️ Pulling model ${MODEL} (this may take a while)..."
    ollama pull "${MODEL}"
    echo "✅ Model ${MODEL} pulled successfully!"
else
    echo "✅ Model ${MODEL} already available!"
fi

echo "🎉 Ollama with ${MODEL} is ready! API: http://0.0.0.0:11434"

# Keep the server running
wait $OLLAMA_PID
