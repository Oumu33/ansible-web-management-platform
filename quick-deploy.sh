#!/bin/bash

# Ansible Web Management Platform - 一键部署脚本
# 作者: UltraThink Platform Team
# 版本: 1.0.0

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否以root权限运行
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_warning "检测到以root权限运行，建议使用普通用户账户运行此脚本"
        read -p "是否继续? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# 检查系统依赖
check_dependencies() {
    log_info "检查系统依赖..."
    
    local missing_deps=()
    
    # 检查 Docker
    if ! command -v docker >/dev/null 2>&1; then
        missing_deps+=("docker")
    fi
    
    # 检查 Docker Compose
    if ! command -v docker-compose >/dev/null 2>&1 && ! docker compose version >/dev/null 2>&1; then
        missing_deps+=("docker-compose")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "缺少以下依赖: ${missing_deps[*]}"
        log_info "请手动安装 Docker 和 Docker Compose"
        exit 1
    else
        log_success "所有依赖已安装"
    fi
}

# 创建环境配置文件
setup_environment() {
    log_info "设置环境配置..."
    
    if [[ ! -f .env ]]; then
        if [[ -f .env.example ]]; then
            cp .env.example .env
            log_info "已从 .env.example 创建 .env 文件"
        else
            log_warning ".env.example 文件不存在，创建基础 .env 文件"
            cat > .env << EOF
NODE_ENV=production
POSTGRES_PASSWORD=secure_postgres_password_$(openssl rand -hex 8)
REDIS_PASSWORD=secure_redis_password_$(openssl rand -hex 8)
SECRET_KEY=$(openssl rand -base64 32)
ADMIN_PASSWORD=admin_$(openssl rand -hex 4)
GRAFANA_ADMIN_PASSWORD=grafana_$(openssl rand -hex 4)
EOF
        fi
        
        log_warning "请编辑 .env 文件并设置适当的密码和配置"
        log_info "生成的随机密码已保存在 .env 文件中"
    else
        log_success "环境配置文件已存在"
    fi
}

# 部署服务
deploy_services() {
    log_info "开始部署服务..."
    
    # 创建必要的目录
    mkdir -p logs nginx/ssl monitoring/grafana/{dashboards,datasources} database/init
    
    # 启动服务
    log_info "启动服务..."
    docker-compose up -d
    
    log_success "服务部署完成"
}

# 等待服务就绪
wait_for_services() {
    log_info "等待服务启动..."
    
    local max_attempts=60
    local attempt=0
    
    while [ $attempt -lt $max_attempts ]; do
        if curl -s http://localhost > /dev/null 2>&1; then
            log_success "服务已就绪"
            return 0
        fi
        
        attempt=$((attempt + 1))
        echo -n "."
        sleep 2
    done
    
    log_error "服务启动超时"
    return 1
}

# 显示部署信息
show_deployment_info() {
    log_success "部署完成！"
    echo
    echo "===================================="
    echo "  Ansible Web Management Platform  "
    echo "===================================="
    echo
    echo "服务访问地址:"
    echo "  主应用:        http://localhost"
    echo "  API 文档:      http://localhost/api/docs"
    echo "  监控平台:      http://localhost/monitoring"
    echo "  MIB 管理:      http://localhost/mib"
    echo "  Grafana:       http://localhost/grafana"
    echo
    echo "默认登录凭据:"
    echo "  用户名: admin"
    echo "  密码: 请查看 .env 文件中的 ADMIN_PASSWORD"
    echo
    echo "常用命令:"
    echo "  查看服务状态:  docker-compose ps"
    echo "  查看日志:      docker-compose logs -f [服务名]"
    echo "  停止服务:      docker-compose down"
    echo "  重启服务:      docker-compose restart"
    echo
}

# 主函数
main() {
    echo "=========================================="
    echo "  Ansible Web Management Platform 部署器  "
    echo "=========================================="
    echo
    
    check_root
    check_dependencies
    setup_environment
    deploy_services
    
    if wait_for_services; then
        show_deployment_info
    else
        log_warning "部署完成，但部分服务可能需要额外配置"
        log_info "请检查 'docker-compose logs' 获取详细信息"
    fi
}

# 脚本入口点
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi