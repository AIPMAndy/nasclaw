#!/bin/bash

# NASClaw 一键安装脚本
# 支持：极空间、群晖、威联通等NAS

set -e

echo "🐱 NASClaw 安装脚本"
echo "===================="
echo ""

# 检查Docker
if ! command -v docker &> /dev/null; then
    echo "❌ 错误：未检测到Docker"
    echo "请先安装Docker后再运行此脚本"
    exit 1
fi

echo "✅ Docker已安装"

# 检查Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "⚠️  未检测到Docker Compose，尝试使用docker compose..."
    DOCKER_COMPOSE="docker compose"
else
    DOCKER_COMPOSE="docker-compose"
fi

# 创建安装目录
INSTALL_DIR="${HOME}/nasclaw"
echo "📁 创建安装目录: ${INSTALL_DIR}"
mkdir -p ${INSTALL_DIR}/{data,config,scripts}
cd ${INSTALL_DIR}

# 下载docker-compose.yml
echo "📥 下载配置文件..."
curl -fsSL https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/docker/docker-compose.yml -o docker-compose.yml

# 下载示例配置
curl -fsSL https://raw.githubusercontent.com/AIPMAndy/nasclaw/main/examples/config.example.json -o config/openclaw.json

echo ""
echo "📝 请配置你的模型API Key:"
echo "   编辑文件: ${INSTALL_DIR}/config/openclaw.json"
echo ""
echo "   推荐模型:"
echo "   - 通义千问: https://dashscope.aliyun.com/ (免费额度)"
echo "   - Kimi: https://platform.moonshot.cn/"
echo "   - GLM: https://open.bigmodel.cn/"
echo ""

read -p "是否现在编辑配置文件? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v nano &> /dev/null; then
        nano config/openclaw.json
    elif command -v vi &> /dev/null; then
        vi config/openclaw.json
    else
        echo "请手动编辑: ${INSTALL_DIR}/config/openclaw.json"
    fi
fi

# 启动NASClaw
echo ""
echo "🚀 启动NASClaw..."
${DOCKER_COMPOSE} up -d

# 等待启动
echo "⏳ 等待服务启动..."
sleep 5

# 检查状态
if docker ps | grep -q nasclaw; then
    echo ""
    echo "✅ NASClaw 安装成功!"
    echo ""
    echo "🌐 访问地址:"
    echo "   http://$(hostname -I | awk '{print $1}'):18789"
    echo ""
    echo "📖 下一步:"
    echo "   1. 访问上述地址"
    echo "   2. 完成初始化向导"
    echo "   3. 配置飞书集成"
    echo ""
    echo "💡 查看日志: ${DOCKER_COMPOSE} logs -f"
    echo ""
else
    echo "❌ 启动失败，请检查日志:"
    echo "   ${DOCKER_COMPOSE} logs"
    exit 1
fi
