# NASClaw 快速开始

> 目标：用最短路径把 OpenClaw 跑在 NAS 上，并尽快进入可用状态。

---

## 先选你的安装路径

### 路径 A：极空间 / 应用商店用户
如果你已经能在应用商店安装 OpenClaw，优先走这条路。

### 路径 B：通用 Docker 用户
如果你用的是群晖、威联通、自建 NAS，或者更习惯自己控配置，走 Docker Compose。

### 路径 C：安装脚本用户
如果你希望远程 SSH 快速部署，或先一键拉起再补配置，可以直接使用安装脚本。

---

## 路径 A：极空间 5 分钟安装

### 1. 应用商店安装
1. 打开极空间「应用商店」
2. 搜索「OpenClaw」
3. 点击安装
4. 等待 2-3 分钟

### 2. 初始化容器
```bash
# 进入容器 Shell 后执行
su node
openclaw onboard
```

### 3. 初始化时这样选
- 选择 **快速开始**
- `Config handling` 选择 **Update values**
- 先选一个你能拿到 API Key 的模型
- 飞书等集成都可以先 `skip for now`

### 4. 保存 token
初始化完成后你会看到 Control UI 地址和 token。

**注意：**
- 复制时去掉多余空格
- 如果终端折行了，确认 token 没有被截断

### 5. 进入 Control UI
在 NAS 中打开 OpenClaw 的页面，填入 token 登录。

---

## 路径 B：Docker Compose 安装

### 1. 克隆仓库
```bash
git clone https://github.com/AIPMAndy/nasclaw.git
cd nasclaw
```

### 2. 准备目录与配置
```bash
mkdir -p config data
cp examples/config.example.json config/openclaw.json
```

然后编辑：
- `config/openclaw.json`

至少先填好一个模型提供商的 API Key。

### 3. 启动
```bash
docker compose -f docker/docker-compose.yml up -d
```

### 4. 查看状态
```bash
docker compose -f docker/docker-compose.yml logs -f
```

如果容器已启动，再访问：
- `http://你的NAS_IP:18789`

默认示例已经包含：
- `restart: unless-stopped`
- 基础 `healthcheck`
- 持久化目录挂载

如果你所在网络环境访问模型不稳定，可改用 `host` 网络模式。

---

## 路径 C：安装脚本

```bash
curl -fsSL https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/scripts/install.sh | bash
```

适合场景：
- SSH 到 NAS 后快速部署
- 想减少手工建目录与下载文件
- 需要非交互模式

可选环境变量：

```bash
NASCLAW_NO_PROMPT=1 NASCLAW_AUTO_START=1 bash scripts/install.sh
```

---

## 模型建议

### 新手优先
**通义千问**：门槛低，适合先跑通。

### 长文本优先
**Kimi**：适合文档、知识库、长上下文。

### 推理 / 代码优先
**GLM**：适合逻辑型任务和代码类任务。

---

## 飞书建议

第一次安装时，**不要一开始就把飞书也一起折腾完**。

更好的顺序是：
1. 先把 OpenClaw 跑起来
2. 确认模型调用正常
3. 再去配置飞书

这样能显著减少排错维度。

飞书配置见：
- [飞书深度打通配置指南](./feishu.md)

---

## 安装完成后的验证动作

建议按这个顺序验证：

### 验证 1：Control UI 能打开
如果 UI 都打不开，先不要做后续步骤。

### 验证 2：模型能响应
在 UI 或聊天里发一条简单消息，确认模型连接正常。

### 验证 3：飞书能收发消息
再去验证飞书收发和授权。

---

## 遇到问题先看这里

最常见的问题都整理在这里：
- [踩坑记录与实战经验](./troubleshooting.md)

常见问题包括：
- token 复制错误
- 502 Bad Gateway
- 网络访问模型失败
- 飞书授权失败
- NAS 存储空间不足

---

## 推荐下一步

跑起来之后，建议继续做这三件事：

1. 配置飞书接入
2. 固定数据目录并做好备份
3. 打开自动重启 / 健康检查，确保 7×24 稳定运行

---

## 如果你只记住一句话

**先跑通，再联动；先单点验证，再做全链路。**
