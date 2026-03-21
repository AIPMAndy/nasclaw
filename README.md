# NASClaw

> 在NAS上部署OpenClaw的完整指南 - 国产模型 + 飞书打通 + 7×24小时自动化

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-2026.3.8-blue)](https://openclaw.ai)
[![Troubleshooting](https://img.shields.io/badge/踩坑记录-6887字-orange)](./docs/troubleshooting.md)

---

## 📢 重要提示

**新手必读：** [📖 5分钟快速开始](./docs/quickstart.md)  
**遇到问题：** [🔥 踩坑记录与实战经验](./docs/troubleshooting.md)（6887字真实踩坑记录）  
**飞书打通：** [💬 飞书配置指南](./docs/feishu.md)

---

## 🎯 项目简介

NASClaw 是一个专门面向NAS用户的OpenClaw部署方案，让你在家里的NAS上运行7×24小时的AI助手。

**核心特色：**
- 🏠 **NAS原生支持**：极空间、群晖、威联通等主流NAS
- 🇨🇳 **国产模型优先**：Kimi、GLM、MiniMax、通义千问
- 💬 **飞书深度打通**：文档/日历/任务/消息全打通
- 🐱 **猫咪哲学**：独立、敏锐、优雅、傲娇的AI助手
- ⚡ **7×24小时运行**：NAS不停，AI不停

---

## 📋 系统要求

- **NAS设备**：极空间/群晖/威联通/自建NAS
- **Docker支持**：必须支持Docker容器
- **网络**：可访问国内模型API（部分模型需要特殊网络配置）
- **存储**：至少10GB可用空间

---

## 🚀 快速开始

### 方法一：应用商店安装（推荐极空间用户）

#### 步骤1：应用商店安装
1. 打开极空间应用商店
2. 搜索并安装 "OpenClaw"
3. 等待安装完成

#### 步骤2：初始化容器
1. 进入Docker界面
2. 找到名为 `appstore_openclaw` 的容器
3. 点击容器 → 进入Shell界面 → 点击"连接"

#### 步骤3：执行初始化命令
```bash
su node
stty rows $(tput lines) cols $(tput cols)
openclaw onboard
```

#### 步骤4：选择快速开始
- 选择 **"快速开始"**
- **重要**：Config handling 一定要选择 **"Update values"**

#### 步骤5：配置模型

**国产模型推荐：**

| 模型 | 特点 | 配置方式 |
|------|------|----------|
| **Kimi K2.5** | 长文本强，200K上下文 | API Key |
| **GLM-5** | 推理能力强 | API Key |
| **MiniMax** | 创意生成好 | API Key |
| **通义千问** | 免费额度，推荐新手 | 浏览器授权 |

**通义千问免费试用（推荐新手）：**
1. 选择通义千问模型
2. 复制红框中的授权链接
3. 在浏览器中打开完成授权
4. 登录阿里云账号，点击确定
5. 返回终端，选择保存

#### 步骤6：跳过可选配置
以下步骤都可以先跳过，初始化完成后再配置：
- 飞书配置 → 选择 "skip for now"
- 其他集成 → 选择 "skip for now"
- 高级选项 → 全部选择 "no"

#### 步骤7：保存Token
1. 在Control UI结果中**记住自己的token**
2. How do you want to hatch your bot? 选择 **"Do this later"**
3. 初始化向导结束

#### 步骤8：访问Control UI
1. 通过应用图标打开 Gateway Control UI
2. 填入刚才复制的token
3. **注意**：命令行可能超过边界，复制时去除空格和 `|` 字符

---

### 方法二：Docker手动安装

适用于所有支持Docker的NAS。

```bash
# 1. 拉取镜像
docker pull openclaw/openclaw:latest

# 2. 创建目录
mkdir -p /volume1/docker/openclaw/{data,config}

# 3. 运行容器
docker run -d \
  --name openclaw \
  --restart unless-stopped \
  -p 18789:18789 \
  -v /volume1/docker/openclaw/data:/home/node/.openclaw \
  -v /volume1/docker/openclaw/config:/app/config \
  openclaw/openclaw:latest

# 4. 进入容器初始化
docker exec -it openclaw /bin/bash
su node
openclaw onboard
```

---

## ⚙️ 配置详解

### 国产模型配置

#### Kimi K2.5（推荐）
```json
{
  "models": {
    "custom": {
      "baseUrl": "https://api.moonshot.cn/v1",
      "apiKey": "your-kimi-api-key",
      "models": [{
        "id": "kimi-k2.5",
        "contextWindow": 200000
      }]
    }
  }
}
```

#### GLM-5
```json
{
  "models": {
    "custom": {
      "baseUrl": "https://open.bigmodel.cn/api/paas/v4",
      "apiKey": "your-glm-api-key",
      "models": [{
        "id": "glm-5",
        "contextWindow": 204800
      }]
    }
  }
}
```

#### 通义千问（免费额度）
```json
{
  "models": {
    "custom": {
      "baseUrl": "https://dashscope.aliyuncs.com/api/v1",
      "apiKey": "your-qwen-api-key",
      "models": [{
        "id": "qwen-max",
        "contextWindow": 128000
      }]
    }
  }
}
```

### 飞书深度打通

详见 [飞书配置指南](./docs/feishu.md)

---

## 🔧 常见问题

### Q1: 模型无法调用，网络错误
**原因**：部分模型API需要特殊网络环境

**解决**：
- 方法1：使用国内可直接访问的模型（Kimi/GLM/通义千问）
- 方法2：配置NAS的网络代理
- 方法3：使用宿主机的网络方案（Docker `--network host`）

### Q2: 升级后第一次启动502错误
**原因**：初始化需要时间

**解决**：等待2-3分钟后刷新页面

### Q3: Token错误或无法登录
**解决**：
1. 在 `/安装目录/openclaw/openclaw.json` 中找到token
2. 重新填入Control UI
3. 如仍报错，重启OpenClaw容器

### Q4: 官方命令安装失败
**解决**：尝试腾讯SkillHub的镜像
```bash
https://skillhub.tencent.com/
```

---

## 🐱 进阶玩法

### 猫咪哲学注入

让你的AI助手拥有猫咪特质：
- **独立**：有自己的判断，不盲从
- **敏锐**：观察细节，预判需求
- **优雅**：做事干净利落
- **傲娇**：有原则，只服务值得的人

详见 [猫咪哲学指南](./docs/cat-philosophy.md)

### 7×24小时自动化

配置每日自动任务：
```bash
# 编辑 crontab
crontab -e

# 添加定时任务
0 8 * * * /usr/local/bin/openclaw send "morning-brief"
0 20 * * * /usr/local/bin/openclaw analyze-investment
0 23 * * * /usr/local/bin/openclaw reflect-and-update
```

### 双猫架构

参考 [双猫架构指南](./docs/dual-cat.md) 配置：
- **小天**（Mac版）：Claude Opus，深度思考
- **圆圆**（NAS版）：国产三剑客，日常自动化

---

## 📚 相关项目

- [OpenClaw](https://openclaw.ai) - 核心框架
- [KnowMe](https://github.com/AIPMAndy/knowme) - 性格分析系统
- [DNA Memory](https://github.com/AIPMAndy/dna-memory) - 长期记忆系统
- [SO Skill](https://github.com/AIPMAndy/so-skill) - 自定义技能框架

---

## 🤝 贡献指南

欢迎提交Issue和PR！

**贡献方式：**
1. 提交NAS适配问题
2. 补充国产模型配置
3. 完善文档教程
4. 分享使用案例

---

## 📄 许可证

Apache 2.0 License - 详见 [LICENSE](./LICENSE)

---

## 💬 交流群

- GitHub Issues: [NASClaw Issues](https://github.com/AIPMAndy/nasclaw/issues)
- 飞书群：扫描下方二维码加入

---

**Made with 🐱 by Andy | AI酋长**

*让每只NAS都养一只AI猫*