# NASClaw 安装指南

> 基于极空间应用商店的OpenClaw安装教程

---

## 📱 应用商店安装步骤

### 步骤1：应用商店安装

1. 打开极空间客户端
2. 进入「应用商店」
3. 搜索 "OpenClaw"
4. 点击「安装」
5. 等待安装完成（约2-3分钟）

---

### 步骤2：初始化容器

1. 进入「Docker」界面
2. 在容器列表中找到 `appstore_openclaw`
3. 点击容器名称进入详情
4. 点击「Shell」标签
5. 点击「连接」按钮

---

### 步骤3：执行初始化命令

在Shell界面中依次执行：

```bash
# 切换到node用户
su node

# 设置终端大小
stty rows $(tput lines) cols $(tput cols)

# 启动初始化向导
openclaw onboard
```

---

### 步骤4：选择快速开始

在初始化向导中：

1. 选择 **「快速开始」**（Quick Start）
2. **重要**：Config handling 一定要选择 **「Update values」**
   - ❌ 不要选 "Reset to defaults"
   - ❌ 不要选 "Keep existing"

---

### 步骤5：配置模型

#### 推荐国产模型

**Kimi K2.5（长文本首选）**
- 上下文：200K tokens
- 特点：中文理解强，适合长文档

**GLM-5（推理能力强）**
- 上下文：204K tokens
- 特点：逻辑推理，代码生成

**通义千问（免费试用）**
- 上下文：128K tokens
- 特点：阿里云出品，有免费额度

#### 通义千问免费试用详细步骤

1. 在模型列表中选择「通义千问」
2. 复制红框中的授权链接
3. 在电脑浏览器中打开该链接
4. 登录阿里云账号（没有就注册一个）
5. 点击「确定授权」
6. 返回NAS的终端界面
7. 选择「保存配置」

---

### 步骤6：跳过可选配置

以下配置都可以先跳过，初始化完成后再设置：

| 配置项 | 选择 |
|--------|------|
| 飞书集成 | skip for now |
| Telegram | skip for now |
| Discord | skip for now |
| 其他集成 | skip for now |
| 高级选项 | 全部选 no |

**为什么可以跳过？**
- 飞书配置较复杂，建议初始化完成后再通过Control UI配置
- 龙虾（OpenClaw助手）可以帮你完成后续配置

---

### 步骤7：保存重要信息

初始化完成后，你会看到：

```
Control UI: http://localhost:18789
Token: xxxxxxxxxxxxxxxxxxxxxxxx
```

**务必记住：**
1. **Token** - 登录Control UI的密码
2. **Gateway地址** - 通常是 `http://你的NASIP:18789`

**注意**：命令行显示可能超过边界，复制时：
- 去除所有空格
- 去除 `|` 字符
- 确保token完整

---

### 步骤8：访问Control UI

1. 在极空间应用列表中找到「OpenClaw」图标
2. 点击图标打开 Gateway Control UI
3. 在登录页面填入刚才的Token
4. 点击「登录」

**如果遇到502错误：**
- 等待2-3分钟再刷新
- 容器启动需要时间

**如果Token错误：**
1. 在NAS文件管理中找到 `/安装目录/openclaw/openclaw.json`
2. 搜索 `"token"` 字段
3. 复制正确的token重新填入

---

## 🔧 后续配置

### 配置国产模型API

登录Control UI后：

1. 进入「Models」页面
2. 点击「Add Provider」
3. 选择模型厂商（Kimi/GLM/通义千问）
4. 填入API Key
5. 点击「Save」

**获取API Key：**
- Kimi: https://platform.moonshot.cn/
- GLM: https://open.bigmodel.cn/
- 通义千问: https://dashscope.aliyun.com/

### 配置飞书（可选）

详见 [飞书配置指南](./feishu.md)

---

## ⚠️ 常见问题

### Q1: 应用商店安装失败
**解决**：
1. 检查NAS存储空间是否充足（至少10GB）
2. 检查Docker服务是否正常运行
3. 尝试手动Docker安装

### Q2: 无法进入Shell界面
**解决**：
1. 确保容器状态为「运行中」
2. 刷新Docker界面
3. 重启容器再试

### Q3: 初始化命令执行报错
**解决**：
1. 确保执行了 `su node` 切换用户
2. 检查网络连接是否正常
3. 查看容器日志：`docker logs appstore_openclaw`

### Q4: Control UI打不开
**解决**：
1. 检查端口18789是否被占用
2. 检查NAS防火墙设置
3. 尝试用IP访问：`http://NAS_IP:18789`

---

## 📞 获取帮助

- GitHub Issues: https://github.com/AIPMAndy/nasclaw/issues
- 飞书群：扫描README中的二维码
- 邮件：andy@example.com

---

**下一步：** 建议先阅读 [快速开始](./quickstart.md) 并完成至少一个模型提供商配置。