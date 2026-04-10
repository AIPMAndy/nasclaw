#!/bin/bash

# NASClaw 一键安装脚本
# 支持：极空间、群晖、威联通等 NAS

set -euo pipefail

REPO_RAW_BASE="https://raw.githubusercontent.com/AIPMAndy/nasclaw/main"
INSTALL_DIR="${INSTALL_DIR:-${HOME}/nasclaw}"
CONFIG_PATH="${INSTALL_DIR}/config/openclaw.json"
NO_PROMPT="${NASCLAW_NO_PROMPT:-0}"
AUTO_START="${NASCLAW_AUTO_START:-1}"
FORCE_OVERWRITE="${NASCLAW_FORCE_OVERWRITE:-0}"

log() {
  echo "$1"
}

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "❌ 缺少依赖：$1"
    exit 1
  fi
}

copy_config_if_needed() {
  if [ -f "$CONFIG_PATH" ] && [ "$FORCE_OVERWRITE" != "1" ]; then
    log "ℹ️  检测到已有配置，保留现有 ${CONFIG_PATH}"
    return
  fi

  curl -fsSL "${REPO_RAW_BASE}/examples/config.example.json" -o "$CONFIG_PATH"
  log "✅ 已写入示例配置: ${CONFIG_PATH}"
}

get_compose_cmd() {
  if command -v docker-compose >/dev/null 2>&1; then
    echo "docker-compose"
  else
    echo "docker compose"
  fi
}

get_host_ip() {
  local host_ip
  host_ip=$(hostname -I 2>/dev/null | awk '{print $1}') || true
  if [ -z "${host_ip:-}" ]; then
    host_ip=$(ip route get 1 2>/dev/null | awk '{print $7; exit}') || true
  fi
  if [ -z "${host_ip:-}" ]; then
    host_ip="<NAS_IP>"
  fi
  echo "$host_ip"
}

log "🐱 NASClaw 安装脚本"
log "===================="
log ""

need_cmd docker
need_cmd curl

log "✅ Docker 已安装"

DOCKER_COMPOSE="$(get_compose_cmd)"
if [ "$DOCKER_COMPOSE" = "docker compose" ]; then
  log "⚠️  未检测到 docker-compose，改用 docker compose"
fi

log "📁 安装目录: ${INSTALL_DIR}"
mkdir -p "${INSTALL_DIR}/data" "${INSTALL_DIR}/config"
cd "${INSTALL_DIR}"

log "📥 下载配置文件..."
curl -fsSL "${REPO_RAW_BASE}/docker/docker-compose.yml" -o docker-compose.yml
copy_config_if_needed

log ""
log "📝 请配置你的模型 API Key:"
log "   文件: ${CONFIG_PATH}"
log ""
log "   推荐模型:"
log "   - 通义千问: https://dashscope.aliyun.com/"
log "   - Kimi: https://platform.moonshot.cn/"
log "   - GLM: https://open.bigmodel.cn/"
log ""

if [ "$NO_PROMPT" != "1" ]; then
  read -p "是否现在编辑配置文件? (y/n) " -n 1 -r
  echo
  if [[ ${REPLY:-n} =~ ^[Yy]$ ]]; then
    if command -v nano >/dev/null 2>&1; then
      nano "$CONFIG_PATH"
    elif command -v vi >/dev/null 2>&1; then
      vi "$CONFIG_PATH"
    else
      log "请手动编辑: ${CONFIG_PATH}"
    fi
  fi
else
  log "ℹ️  已跳过交互式编辑，可稍后手动修改配置。"
fi

if [ "$AUTO_START" = "1" ]; then
  log ""
  log "🚀 启动 NASClaw..."
  ${DOCKER_COMPOSE} up -d

  log "⏳ 等待服务启动..."
  sleep 5

  HOST_IP="$(get_host_ip)"
  if docker ps --format '{{.Names}}' | grep -q '^nasclaw$'; then
    log ""
    log "✅ NASClaw 安装成功!"
    log ""
    log "🌐 访问地址:"
    log "   http://${HOST_IP}:18789"
    log ""
    log "📖 下一步:"
    log "   1. 访问上述地址"
    log "   2. 完成初始化向导"
    log "   3. 配置飞书集成"
    log ""
    log "💡 查看日志: ${DOCKER_COMPOSE} logs -f"
    log ""
  else
    echo "❌ 启动失败，请检查日志:"
    echo "   ${DOCKER_COMPOSE} logs"
    exit 1
  fi
else
  log "ℹ️  已跳过自动启动。准备好后可执行: ${DOCKER_COMPOSE} up -d"
fi
