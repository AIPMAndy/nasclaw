<div align="center">

# 🐱 NASClaw

**把 OpenClaw 稳定跑在 NAS 上的实战部署方案**  
**适合中文用户、国产模型、飞书协同、7×24 小时常驻运行**

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-2026.3.8-blue)](https://openclaw.ai)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)](./docker/docker-compose.yml)
[![Quick Start](https://img.shields.io/badge/Quick%20Start-5%20min-brightgreen)](./docs/quickstart.md)
[![Troubleshooting](https://img.shields.io/badge/Troubleshooting-实战踩坑-orange)](./docs/troubleshooting.md)

**简体中文** | [English](./README_EN.md)

</div>

---

## 这是什么

NASClaw 不是另一个 AI Agent 框架，而是一个 **面向 NAS 场景的 OpenClaw 部署方案与文档项目**。

它解决的是很多中文用户都会遇到的同一个问题：

> 想让 AI 助手 24 小时在线、数据尽量留在自己设备上、能接入飞书、还能优先使用国产模型，但官方文档更偏通用，落到 NAS 场景时容易踩坑。

NASClaw 的目标就是把这件事讲清楚、跑起来、少踩坑。

---

## 它适合谁

- 已经有 **极空间 / 群晖 / 威联通 / 自建 NAS** 的用户
- 想把 OpenClaw 跑成 **家庭或个人工作流中枢** 的用户
- 需要 **国产模型优先** 的中文用户
- 想把 AI 助手和 **飞书消息 / 文档 / 日历 / 任务** 打通的人
- 不想租 VPS，或者更在意 **本地化、长期运行、低额外成本** 的用户

---

## 为什么不是直接看 OpenClaw 官方文档

| 维度 | 官方文档 | 普通 Docker 教程 | **NASClaw** |
|---|---|---|---|
| 面向 NAS 用户 | 一般 | 一般 | ✅ 明确聚焦 |
| 中文场景 | 一般 | 一般 | ✅ 中文优先 |
| 国产模型建议 | 少 | 少 | ✅ 直接给可用方案 |
| 飞书打通 | 分散 | 基本没有 | ✅ 单独整理 |
| 踩坑经验 | 通用 | 通用 | ✅ 来自真实部署 |
| 7×24 稳定运行建议 | 少 | 一般 | ✅ 有针对性 |

一句话：

**如果你只是想了解 OpenClaw，本项目不是必需的；如果你想把 OpenClaw 真正稳定跑在 NAS 上，这个项目会更省时间。**

---

## 核心卖点

### 1) NAS 场景友好
- 针对极空间、群晖、威联通、自建 Docker NAS 给出落地方式
- 关注端口、数据目录、容器重启、健康检查、长期开机等问题

### 2) 中文用户友好
- 默认从中文用户最常见的模型、飞书、权限、网络问题出发
- 少讲抽象概念，多给能直接照抄的操作步骤

### 3) 国产模型优先
- 优先推荐 Kimi、GLM、通义千问、MiniMax 等模型
- 适合国内网络环境与中文工作流

### 4) 飞书工作流打通
- 让 OpenClaw 不只是聊天机器人，而是能接入消息、文档、日历、任务的执行节点

### 5) 实战踩坑记录
- 不只是“怎么装”，更包括“为什么会坏、坏了怎么修”

---

## 30 秒看懂仓库结构

```text
.
├── README.md                 # 中文主页
├── README_EN.md              # 英文主页
├── docker/docker-compose.yml # 通用 Docker Compose 示例
├── scripts/install.sh        # 一键安装脚本
├── examples/config.example.json
└── docs/
    ├── quickstart.md         # 5 分钟快速开始
    ├── install.md            # 详细安装说明
    ├── feishu.md             # 飞书配置
    └── troubleshooting.md    # 踩坑与修复
```

---

## 快速开始

### 方案 A：先看 5 分钟快速开始

如果你希望先跑起来，再逐步优化：

- [📖 5 分钟快速开始](./docs/quickstart.md)
- [🔥 踩坑记录与实战经验](./docs/troubleshooting.md)
- [💬 飞书配置指南](./docs/feishu.md)

### 方案 B：直接用安装脚本

```bash
curl -fsSL https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/scripts/install.sh | bash
```

### 方案 C：手动 Docker Compose

```bash
git clone https://github.com/AIPMAndy/nasclaw.git
cd nasclaw
mkdir -p config data
cp examples/config.example.json config/openclaw.json
# 编辑 config/openclaw.json 后再启动

docker compose -f docker/docker-compose.yml up -d
```

---

## 推荐模型组合

| 模型 | 推荐原因 | 适合场景 |
|---|---|---|
| Kimi | 长文本能力强 | 文档分析、复杂上下文 |
| GLM | 推理与代码表现稳 | 逻辑任务、代码辅助 |
| 通义千问 | 上手快、门槛低 | 新手试用、日常对话 |
| MiniMax | 创意和多模态有优势 | 内容生成、灵感任务 |

> 重点不是“哪个模型绝对最好”，而是 **在你的网络、预算、任务类型下哪个最稳**。

---

## 飞书能打通什么

配置完成后，典型可实现：

- 飞书私聊里直接和你的 AI 助手互动
- 读取和更新飞书文档
- 查询和创建日程
- 管理任务和待办
- 基于 NAS 做更长期的自动化运行

详见：
- [飞书配置指南](./docs/feishu.md)

---

## 当前项目最有价值的部分

如果你是第一次接触这个仓库，建议优先看：

1. **[快速开始](./docs/quickstart.md)**：最快把服务跑起来
2. **[踩坑文档](./docs/troubleshooting.md)**：减少 80% 无效折腾
3. **[飞书指南](./docs/feishu.md)**：把“能跑”变成“能用”

---

## Roadmap

- [x] 提供 NAS 场景安装说明
- [x] 提供国产模型配置示例
- [x] 提供飞书接入文档
- [x] 提供真实部署踩坑记录
- [ ] 补充多平台 NAS 差异清单（极空间 / 群晖 / 威联通）
- [ ] 增加 Demo 截图 / GIF
- [ ] 增加常见配置模板（个人版 / 团队版 / 低成本版）
- [ ] 增加 benchmark 与稳定性对比

---

## 现在最缺什么

如果你希望这个项目更火，最缺的不是再多写一页文档，而是下面三件事：

1. **Demo 资产**：首页 GIF / 截图 / 架构图
2. **用户证据**：真实安装案例、NAS 型号、模型选择、效果反馈
3. **分发动作**：把项目发到中文技术社区 + 海外社区

也就是说：

**这项目已经有“内容”，但还缺“门面”和“传播”。**

---

## 贡献方式

欢迎提交：

- 不同 NAS 机型的适配经验
- 国产模型配置模板
- 飞书权限与授权补充
- 安装失败后的修复案例
- 首页 Demo 截图 / GIF / 架构图

请先阅读：[CONTRIBUTING.md](./CONTRIBUTING.md)

---

## 相关项目

- [OpenClaw](https://openclaw.ai) - 核心框架
- [KnowMe](https://github.com/AIPMAndy/knowme) - 性格分析系统
- [DNA Memory](https://github.com/AIPMAndy/dna-memory) - 长期记忆系统
- [SO Skill](https://github.com/AIPMAndy/so-skill) - 自定义技能框架

---

## License

本项目基于 [Apache 2.0](./LICENSE) 开源。

---

## 如果这个项目对你有帮助

请直接做两件事：

1. 给仓库一个 **⭐ Star**
2. 提一个 **Issue / PR / 使用案例**

这会显著提高项目继续迭代的概率。

---

**Made with 🐱 by Andy**  
**让每台 NAS 都拥有一只长期在线的 AI 助手**
