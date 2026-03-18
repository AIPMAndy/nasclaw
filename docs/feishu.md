# 飞书深度打通配置指南

> 让NASClaw成为你的飞书超级助手

---

## 🎯 配置目标

打通后，NASClaw可以：
- ✅ 读取你的飞书文档和知识库
- ✅ 管理日历和日程
- ✅ 创建和追踪任务
- ✅ 发送和回复消息
- ✅ 自动备份数据到NAS

---

## 📋 前置要求

1. 飞书企业版账号（个人版部分功能受限）
2. 飞书开放平台管理员权限
3. NASClaw已初始化完成

---

## 🔧 配置步骤

### 步骤1：创建飞书应用

1. 访问 [飞书开放平台](https://open.feishu.cn/)
2. 登录你的飞书账号
3. 点击「创建应用」
4. 选择「企业自建应用」
5. 填写应用信息：
   - 应用名称：NASClaw
   - 应用描述：你的个人AI助手
   - 应用图标：上传猫咪图标

### 步骤2：配置权限

进入应用详情页，点击「权限管理」：

**必须开启的权限：**

| 权限类别 | 权限名称 | 用途 |
|---------|---------|------|
| 通讯录 | 获取用户基本信息 | 识别你的身份 |
| 消息 | 读取消息 | 读取聊天记录 |
| 消息 | 发送消息 | 主动发送消息 |
| 文档 | 读取文档 | 读取云文档内容 |
| 文档 | 编辑文档 | 更新文档内容 |
| 日历 | 读取日历 | 查看日程安排 |
| 日历 | 创建日程 | 自动创建会议 |
| 任务 | 管理任务 | 创建和追踪任务 |

**批量导入权限JSON：**

```json
{
  "scopes": {
    "tenant": [
      "contact:user.basic_profile:readonly",
      "docx:document:readonly",
      "docx:document:write_only",
      "im:chat:read",
      "im:message:send_as_bot",
      "im:message:readonly",
      "calendar:calendar:read",
      "calendar:calendar.event:create",
      "task:task:read",
      "task:task:write"
    ],
    "user": [
      "contact:user.basic_profile:readonly",
      "docx:document:readonly",
      "im:message:readonly"
    ]
  }
}
```

### 步骤3：发布应用

1. 点击「版本管理与发布」
2. 创建新版本
3. 填写版本信息
4. 提交审核（企业应用通常秒过）
5. 发布应用

### 步骤4：获取凭证

在「凭证与基础信息」页面，获取：
- **App ID** (cli_xxxxxxxx)
- **App Secret** (xxxxxxxx)

**保存好这两个值！**

### 步骤5：配置NASClaw

登录NASClaw的Control UI：

1. 进入「Channels」页面
2. 点击「Feishu」
3. 填入：
   - App ID: 你的App ID
   - App Secret: 你的App Secret
4. 点击「Save」
5. 点击「Authorize」完成授权

### 步骤6：测试连接

在飞书私聊中给NASClaw发消息：

```
你好
```

如果收到回复，说明配置成功！

---

## 🚀 高级配置

### 流式输出

在 `openclaw.json` 中添加：

```json
{
  "channels": {
    "feishu": {
      "streaming": true
    }
  }
}
```

效果：消息逐步显示，而不是一次性发送。

### 自动备份

配置每天自动备份飞书文档到NAS：

```bash
# 编辑crontab
crontab -e

# 添加定时任务（每天凌晨2点备份）
0 2 * * * /usr/local/bin/openclaw feishu backup --output /volume1/backup/feishu
```

### 消息同步

配置消息同步到NAS本地存储：

```json
{
  "channels": {
    "feishu": {
      "syncMessages": true,
      "syncPath": "/volume1/data/messages"
    }
  }
}
```

---

## ⚠️ 常见问题

### Q1: 授权失败
**原因**：权限未开通或应用未发布

**解决**：
1. 检查权限管理中的权限是否全部开启
2. 确认应用已发布
3. 重新授权

### Q2: 无法读取文档
**原因**：文档权限未开通

**解决**：
1. 检查是否开通了 `docx:document:readonly`
2. 确保文档在应用可见范围内

### Q3: 消息发送失败
**原因**：机器人不在群聊中

**解决**：
1. 将机器人添加到群聊
2. 确保机器人有发送消息权限

---

## 📚 相关文档

- [飞书开放平台文档](https://open.feishu.cn/document/)
- [OpenClaw飞书插件指南](https://bytedance.larkoffice.com/docx/MFK7dDFLFoVlOGxWCv5cTXKmnMh)

---

**配置完成后，你的NASClaw就可以：**
- 自动读取你的飞书知识库
- 每天生成日程简报
- 自动追踪任务进度
- 成为你的飞书超级助手 🐱