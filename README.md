# 🤖 Ollama Qwen 3 — Unraid Docker Container

[![Build and Push Docker Image](https://github.com/PForgeDE/Ollama/actions/workflows/build-push.yml/badge.svg)](https://github.com/PForgeDE/Ollama/actions/workflows/build-push.yml)

Schlanker Ollama Docker Container für Unraid — ohne vorinstalliertes Modell. Das Modell wird beim ersten Start automatisch gezogen und bei jedem Neustart auf Updates geprüft. Kein GPU nötig, läuft auf reiner CPU.

## ✨ Features

- ✅ **Ollama** ready-to-run
- ✅ **Qwen 3** wird beim Start automatisch gezogen & aktuell gehalten
- ✅ **CPU-only** — keine GPU nötig
- ✅ **OpenAI-kompatible API** auf Port 11434
- ✅ **Persistente Modell-Speicherung** via Volume
- ✅ **Unraid Community App Template** enthalten
- ✅ **Frei wählbares Modell** per Umgebungsvariable

---

## 🚀 Quick Start

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
  -e OLLAMA_MODEL=qwen3:1.7b \
  ghcr.io/pforgede/ollama:latest
```

### Unraid
1. Unraid Dashboard → **Apps** → **Community Applications**
2. Oder manuell: **Docker** → **Add Container** → Template URL:
   ```
   https://raw.githubusercontent.com/PForgeDE/Ollama/main/unraid/ollama-qwen3.xml
   ```

---

## ⚙️ Umgebungsvariablen

| Variable | Standard | Beschreibung |
|----------|----------|--------------|
| `OLLAMA_MODEL` | `qwen3:1.7b` | Modell (wird beim Start gezogen) |
| `OLLAMA_HOST` | `0.0.0.0` | Listen-Adresse |
| `OLLAMA_KEEP_ALIVE` | `-1` | Modell im RAM halten (-1 = dauerhaft) |

**Verfügbare Qwen 3 Modelle:**

| Modell | Größe | Empfehlung |
|--------|-------|------------|
| `qwen3:0.6b` | ~500 MB | Sehr schnell, einfache Aufgaben |
| `qwen3:1.7b` | ~1.1 GB | ⭐ Standard — gut & schnell |
| `qwen3:4b` | ~2.5 GB | Mehr Qualität |
| `qwen3:8b` | ~5 GB | Hohe Qualität, mehr RAM nötig |

---

## 🔌 Integration

### OpenClaw (AI Gateway)

In der `openclaw.json` Konfiguration:

```json
{
  "providers": {
    "ollama": {
      "baseUrl": "http://<SERVER-IP>:11434",
      "models": [
        {
          "id": "qwen3:1.7b",
          "name": "Qwen 3 1.7B (local)",
          "contextLength": 32768
        }
      ]
    }
  }
}
```

Modell in einer Session wechseln:
```
/model ollama/qwen3:1.7b
```

Als Fallback-Model für einen Agent:
```json
{
  "agents": {
    "myagent": {
      "model": "ollama/qwen3:1.7b"
    }
  }
}
```

> ⚠️ **Kein `apiKey`** für Ollama setzen — das verursacht Fehler!

---

### Claude Code

Claude Code unterstützt Ollama via OpenAI-kompatiblem Endpoint:

```bash
# Umgebungsvariablen setzen
export ANTHROPIC_BASE_URL=http://<SERVER-IP>:11434/v1
export ANTHROPIC_API_KEY=ollama

# Claude Code starten
claude --model qwen3:1.7b
```

Oder dauerhaft in `~/.claude/settings.json`:
```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://<SERVER-IP>:11434/v1",
    "ANTHROPIC_API_KEY": "ollama"
  }
}
```

---

### Open WebUI (Chat-Interface)

Das beliebteste Chat-UI für lokale Modelle:

```bash
docker run -d \
  --name open-webui \
  -p 3000:8080 \
  -e OLLAMA_BASE_URL=http://<SERVER-IP>:11434 \
  -v open-webui:/app/backend/data \
  ghcr.io/open-webui/open-webui:main
```

Dann im Browser: `http://<SERVER-IP>:3000`

Für Unraid gibt es ebenfalls ein fertiges Community App Template für Open WebUI.

---

### Direkte API-Nutzung

**Chat (OpenAI-kompatibel):**
```bash
curl http://<SERVER-IP>:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"qwen3:1.7b","messages":[{"role":"user","content":"Hallo!"}]}'
```

**Ollama Native API:**
```bash
curl http://<SERVER-IP>:11434/api/generate \
  -d '{"model":"qwen3:1.7b","prompt":"Hallo!","stream":false}'
```

**Verfügbare Modelle anzeigen:**
```bash
curl http://<SERVER-IP>:11434/api/tags
```

---

### Python

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://<SERVER-IP>:11434/v1",
    api_key="ollama",
)

response = client.chat.completions.create(
    model="qwen3:1.7b",
    messages=[{"role": "user", "content": "Erkläre Quantencomputer in 3 Sätzen."}]
)
print(response.choices[0].message.content)
```

---

## 📦 Image

```bash
# GitHub Container Registry (öffentlich)
docker pull ghcr.io/pforgede/ollama:latest
```

---

## 🔄 Build & CI/CD

GitHub Actions baut automatisch bei jedem Push auf `main`:
- **Image:** `ghcr.io/pforgede/ollama:latest`
- **Plattformen:** `linux/amd64`, `linux/arm64`

---

## 📄 Lizenz

MIT — by [PForge](https://github.com/PForgeDE)
