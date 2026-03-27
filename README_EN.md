<div align="center">

# 🐱 NASClaw

**A practical OpenClaw deployment guide for NAS users**  
**Built for Chinese-friendly setups, domestic model providers, Feishu workflows, and 24/7 uptime**

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-2026.3.8-blue)](https://openclaw.ai)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)](./docker/docker-compose.yml)
[![Quick Start](https://img.shields.io/badge/Quick%20Start-5%20min-brightgreen)](./docs/quickstart.md)
[![Troubleshooting](https://img.shields.io/badge/Troubleshooting-Field%20Notes-orange)](./docs/troubleshooting.md)

[简体中文](./README.md) | **English**

</div>

---

## What is NASClaw?

NASClaw is **not another AI agent framework**. It is a **deployment and documentation project focused on running OpenClaw on NAS devices**.

It exists for a very specific use case:

> You want your AI assistant to stay online 24/7, keep data as local as possible, connect to Feishu, and work well with Chinese model providers — but generic docs do not fully cover NAS-specific setup and failure modes.

NASClaw makes that path clearer and more repeatable.

---

## Who is this for?

- Users with **ZSpace, Synology, QNAP, or self-built NAS**
- People who want OpenClaw to become a **home or personal workflow hub**
- Chinese-speaking users who prefer **domestic LLM providers**
- Users who want AI integrated with **Feishu messages, docs, calendars, and tasks**
- People who prefer **local-first, always-on, lower recurring cost** setups over renting a VPS

---

## Why not just use the official OpenClaw docs?

| Dimension | Official Docs | Generic Docker Guides | **NASClaw** |
|---|---|---|---|
| NAS-focused | Somewhat | Somewhat | ✅ Explicitly focused |
| Chinese-user context | Limited | Limited | ✅ Chinese-first |
| Domestic model provider guidance | Minimal | Minimal | ✅ Actionable suggestions |
| Feishu integration | Scattered | Rarely covered | ✅ Dedicated guide |
| Real deployment pitfalls | Generic | Generic | ✅ Based on field experience |
| 24/7 stability advice | Minimal | Average | ✅ NAS-specific |

In one sentence:

**If you just want to learn OpenClaw, this repo is optional. If you want to run it reliably on a NAS, this repo can save you a lot of time.**

---

## Core value

### 1) NAS-friendly
- Covers ports, volumes, restart strategy, health checks, and always-on operation
- Written with real NAS environments in mind

### 2) Chinese-user friendly
- Starts from the most common Chinese user needs: domestic models, Feishu, permissions, network issues
- More copy-pasteable steps, less abstract theory

### 3) Domestic-model first
- Recommends Kimi, GLM, Qwen, MiniMax, and similar providers
- Better aligned with Chinese workflows and local connectivity constraints

### 4) Feishu workflow integration
- Turns OpenClaw into more than a chat bot by connecting it to docs, calendars, tasks, and messaging

### 5) Field notes, not just tutorials
- Includes not only “how to install” but also “why it breaks” and “how to recover”

---

## Repository structure

```text
.
├── README.md                 # Chinese landing page
├── README_EN.md              # English landing page
├── docker/docker-compose.yml # General Docker Compose example
├── scripts/install.sh        # One-click install script
├── examples/config.example.json
└── docs/
    ├── quickstart.md         # 5-minute quick start
    ├── install.md            # Full install guide
    ├── feishu.md             # Feishu integration
    └── troubleshooting.md    # Pitfalls and fixes
```

---

## Quick start

### Option A: Read the 5-minute guide first

- [📖 5-minute Quick Start](./docs/quickstart.md)
- [🔥 Troubleshooting & field notes](./docs/troubleshooting.md)
- [💬 Feishu integration guide](./docs/feishu.md)

### Option B: Use the install script

```bash
curl -fsSL https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/scripts/install.sh | bash
```

### Option C: Manual Docker Compose setup

```bash
git clone https://github.com/AIPMAndy/nasclaw.git
cd nasclaw
mkdir -p config data
cp examples/config.example.json config/openclaw.json
# Edit config/openclaw.json before starting

docker compose -f docker/docker-compose.yml up -d
```

---

## Recommended model mix

| Model | Why it is recommended | Good for |
|---|---|---|
| Kimi | Strong long-context performance | Document analysis, large context tasks |
| GLM | Solid reasoning and coding | Logic-heavy tasks, coding assistance |
| Qwen | Easy to try, low barrier | Beginners, daily conversations |
| MiniMax | Good creativity / multimodal potential | Content generation, ideation |

> The key question is not “which model is objectively best,” but **which one is most stable for your budget, network, and workload**.

---

## What Feishu integration enables

Once configured, you can typically:

- Chat with your AI assistant directly in Feishu
- Read and update Feishu documents
- Query and create calendar events
- Manage tasks and to-dos
- Run longer-lived automations backed by your NAS

See: [Feishu guide](./docs/feishu.md)

---

## Most valuable parts of this repo right now

If you are new here, start with:

1. **[Quick Start](./docs/quickstart.md)** — get it running fast
2. **[Troubleshooting](./docs/troubleshooting.md)** — avoid wasted hours
3. **[Feishu Guide](./docs/feishu.md)** — turn “running” into “useful”

---

## Roadmap

- [x] NAS-focused installation guide
- [x] Domestic model configuration examples
- [x] Feishu integration guide
- [x] Real deployment troubleshooting notes
- [ ] NAS-specific matrix for ZSpace / Synology / QNAP
- [ ] Demo screenshots / GIFs
- [ ] Common config templates (personal / team / low-cost)
- [ ] Benchmarks and stability comparisons

---

## What the project still lacks

If the goal is to make this repo grow, the biggest gaps are not more text, but these three things:

1. **Demo assets** — homepage GIFs, screenshots, architecture diagrams
2. **Proof from users** — real NAS models, chosen providers, outcome reports
3. **Distribution** — shipping the repo into both Chinese and global communities

In other words:

**The repo already has substance, but it still needs stronger packaging and distribution.**

---

## Contributing

Contributions are welcome, especially:

- Device-specific NAS deployment notes
- Domestic model configuration templates
- Feishu permission / auth fixes
- Recovery steps for failed installs
- Demo screenshots / GIFs / diagrams

Please read [CONTRIBUTING.md](./CONTRIBUTING.md) first.

---

## Related projects

- [OpenClaw](https://openclaw.ai) - Core framework
- [KnowMe](https://github.com/AIPMAndy/knowme) - Personality analysis system
- [DNA Memory](https://github.com/AIPMAndy/dna-memory) - Long-term memory system
- [SO Skill](https://github.com/AIPMAndy/so-skill) - Custom skill framework

---

## License

This project is open sourced under [Apache 2.0](./LICENSE).

---

## If this repo helps you

Please do two simple things:

1. Give it a **⭐ Star**
2. Open an **Issue / PR / deployment report**

That materially increases the chance the project keeps improving.

---

**Made with 🐱 by Andy**  
**Give every NAS its own always-on AI assistant**
