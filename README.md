# 🤖 Ollama Qwen 3 - Unraid Docker Container

Ein Docker Container für Unraid mit Ollama und Qwen 3 vorinstalliert.

## Features

- ✅ **Ollama** vorinstalliert und konfiguriert
- ✅ **Qwen 3 30B** automatisch geladen
- ✅ **Persistente Modell-Speicherung** via Volume
- ✅ **OpenAI-kompatible API** auf Port 11434
- ✅ **Unraid Community Template** enthalten
- ✅ **GPU-Support** vorbereitet (NVIDIA/AMD)

## Quick Start

### Docker Compose
```bash
docker compose up -d
```

### Docker Run
```bash
docker run -d \
  --name ollama-qwen3 \
  -p 11434:11434 \
  -v ollama_data:/root/.ollama \
  -e OLLAMA_MODEL=qwen3:30b \
  docker.reacue-game.eu/ollama-qwen3-unraid:latest
```

### Unraid
1. In Unraid Dashboard: **Apps** → Community Applications
2. Oder direkt: **Docker** → **Add Container** → Template URL einfügen:
   `https://raw.githubusercontent.com/gsgphoenix/ollama-qwen3-unraid/main/unraid/ollama-qwen3.xml`

## Umgebungsvariablen

| Variable | Standard | Beschreibung |
|----------|----------|--------------|
| `OLLAMA_MODEL` | `qwen3:30b` | Zu ladendes Modell |
| `OLLAMA_HOST` | `0.0.0.0` | Listen-Adresse |
| `OLLAMA_KEEP_ALIVE` | `-1` | RAM-Haltezeit (-1 = dauerhaft) |
| `OLLAMA_MAX_LOADED_MODELS` | `2` | Max. geladene Modelle |

## API Verwendung

```bash
# Chat Completion (OpenAI-kompatibel)
curl http://localhost:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3:30b",
    "messages": [{"role": "user", "content": "Hallo!"}]
  }'

# Ollama Native API
curl http://localhost:11434/api/generate \
  -d '{"model": "qwen3:30b", "prompt": "Hallo!"}'
```

## Registry

Image verfügbar unter: `docker.reacue-game.eu/ollama-qwen3-unraid:latest`

## Build

GitHub Actions baut automatisch bei jedem Push auf `main`.
