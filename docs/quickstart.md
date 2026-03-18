# NASClaw 快速开始

> 5分钟在NAS上部署你的AI猫

---

## 1. 一键安装脚本

```bash
# 下载安装脚本
curl -fsSL https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/scripts/install.sh | bash

# 或者使用wget
wget -qO- https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/scripts/install.sh | bash
```

---

## 2. 手动安装（极空间用户）

### 2.1 应用商店安装

1. 打开极空间「应用商店」
2. 搜索「OpenClaw」
3. 点击安装
4. 等待2-3分钟

### 2.2 初始化配置

```bash
# 进入容器Shell
docker exec -it appstore_openclaw /bin/bash

# 切换到node用户
su node

# 启动初始化向导
openclaw onboard
```

### 2.3 选择配置

- ✅ 选择「快速开始」
- ✅ Config handling 选择「Update values」
- ✅ 选择国产模型（推荐通义千问免费试用）
- ✅ 其他选项选择「skip for now」

### 2.4 记住Token

```
Control UI: http://localhost:18789
Token: your-token-here
```

**注意**：去除token中的空格和 `|` 字符

### 2.5 访问Control UI

1. 点击极空间应用图标
2. 填入Token
3. 开始配置模型和飞书

---

## 3. Docker Compose安装（通用NAS）

```bash
# 1. 克隆仓库
git clone https://github.com/AIPMAndy/nasclaw.git
cd nasclaw

# 2. 修改配置
cp examples/config.example.json config/openclaw.json
# 编辑 config/openclaw.json，填入你的API Key

# 3. 启动
docker-compose up -d

# 4. 查看日志
docker-compose logs -f
```

---

## 4. 配置国产模型

### 4.1 通义千问（推荐新手）

**免费额度：**
- 100万token免费额度
- 有效期：3个月

**配置步骤：**
1. 访问 https://dashscope.aliyun.com/
2. 注册阿里云账号
3. 开通DashScope
4. 复制API Key
5. 填入NASClaw Control UI

### 4.2 Kimi（长文本首选）

**特点：**
- 200K上下文
- 中文理解强

**获取API Key：**
1. 访问 https://platform.moonshot.cn/
2. 注册账号
3. 创建API Key
4. 填入NASClaw

### 4.3 GLM（推理能力强）

**特点：**
- 204K上下文
- 代码生成好

**获取API Key：**
1. 访问 https://open.bigmodel.cn/
2. 注册账号
3. 创建API Key
4. 填入NASClaw

---

## 5. 配置飞书（可选）

### 5.1 创建飞书应用

1. 访问 https://open.feishu.cn/
2. 创建企业自建应用
3. 开启权限（详见 docs/feishu.md）
4. 获取AppID和AppSecret

### 5.2 配置NASClaw

1. 进入Control UI
2. 点击「Channels」→「Feishu」
3. 填入AppID和AppSecret
4. 点击「Authorize」完成授权

---

## 6. 验证安装

在飞书私聊中发送：

```
你好，圆圆
```

如果收到回复，说明安装成功！🎉

---

## 7. 常见问题

### Q: 安装失败怎么办？
A: 尝试腾讯SkillHub镜像：
```bash
https://skillhub.tencent.com/
```

### Q: 模型无法调用？
A: 检查网络，或使用宿主机网络模式：
```yaml
network_mode: host
```

### Q: 502错误？
A: 等待2-3分钟后刷新，容器启动需要时间。

---

## 8. 下一步

- 📖 阅读 [完整文档](../README.md)
- 🐱 了解 [猫咪哲学](./cat-philosophy.md)
- 🔧 查看 [高级配置](./advanced.md)
- 💬 加入 [交流群](https://github.com/AIPMAndy/nasclaw/discussions)

---

**5分钟后，你将拥有一只7×24小时在线的AI猫！** 🐱