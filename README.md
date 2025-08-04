# Ansible Web Management Platform - 完整部署解决方案

一个功能完整的 Ansible Web 管理平台，包含多个集成的监控和管理组件，支持一键部署，拉取即用。

## 🚀 项目特色

- **完整解决方案**：包含 Ansible Web 平台、监控系统、MIB 管理等完整组件
- **一键部署**：提供多种部署脚本，支持单机、集群等不同场景
- **生产就绪**：包含完整的配置文件、依赖管理和部署验证
- **多技术栈**：整合 Go、Python、Node.js、React 等多种技术

## 📁 项目结构

```
├── ansible/                    # Ansible Web 管理平台
│   ├── ansible-web/           # 主要的 Web 应用
│   ├── backend/               # 后端 API 服务
│   ├── frontend/              # 前端界面
│   ├── docs/                  # 项目文档
│   └── deployment/            # 部署相关文件
├── all-in-one/                # 集成监控平台
├── mib-platform/              # MIB 管理平台
├── monitoring-alert-system/   # 监控告警系统
├── monitoring-deployment-platform/ # 监控部署平台
├── script/                    # 部署脚本集合
├── deploy-*.sh               # 各种部署脚本
└── README-VM-Deploy.md       # VM 部署说明
```

## 🎯 核心功能

### Ansible Web 平台
- Web 界面管理 Ansible 任务
- 主机管理和库存管理
- Playbook 执行和监控
- 用户权限管理
- RESTful API 接口

### 监控系统
- 多维度监控指标收集
- 实时告警和通知
- 图表可视化展示
- 性能分析和报告

### MIB 管理
- SNMP MIB 文件管理
- 设备监控配置
- 网络设备管理
- 数据流监控

## 🛠️ 技术栈

### 后端技术
- **Go**: 高性能 API 服务
- **Python**: Ansible 集成和自动化
- **SQLite/PostgreSQL**: 数据存储
- **Docker**: 容器化部署

### 前端技术
- **React**: 用户界面框架
- **TypeScript**: 类型安全的 JavaScript
- **Next.js**: 全栈 React 框架
- **Tailwind CSS**: 现代化 CSS 框架
- **Vite**: 前端构建工具

### 运维工具
- **Nginx**: Web 服务器和反向代理
- **Docker Compose**: 多容器编排
- **Systemd**: 系统服务管理
- **Shell Scripts**: 自动化部署

## 🚀 快速开始

### 环境要求

- **操作系统**: Linux (Ubuntu 18.04+, CentOS 7+)
- **Docker**: 20.10+
- **Docker Compose**: 2.0+
- **Node.js**: 16.x+
- **Python**: 3.8+
- **Go**: 1.19+

### 一键部署

#### 单机部署
```bash
# 克隆项目
git clone https://github.com/Oumu33/ansible-web-management-platform.git
cd ansible-web-management-platform

# 单机 VM 部署
./deploy-vm-single.sh

# 验证部署
./validate-deployment.sh
```

#### 集群部署
```bash
# 动态集群部署
./deploy-vm-dynamic-cluster.sh

# 增强集群部署
./deploy-vm-dynamic-cluster-enhanced.sh

# 集群验证
./final-validation.sh
```

#### 生产环境部署
```bash
# 生产环境预检查
./precheck-public-deployment.sh

# 生产环境部署
./deploy-production.sh

# 公开生产环境部署
./deploy-public-production.sh
```

### 组件独立部署

#### Ansible Web 平台
```bash
cd ansible/ansible-web
./deploy.sh
```

#### 监控平台
```bash
cd all-in-one
./deploy.sh
```

#### MIB 平台
```bash
cd mib-platform
./deploy.sh
```

## 📊 服务访问

部署完成后，可以通过以下地址访问各个服务：

- **Ansible Web 平台**: http://localhost:3000
- **API 文档**: http://localhost:8080/docs
- **监控面板**: http://localhost:3001
- **Grafana 监控**: http://localhost:3002
- **MIB 管理**: http://localhost:3003

默认登录凭据：
- 用户名: `admin`
- 密码: `admin` (首次登录后请修改)

## 🚀 超快速部署

使用我们的一键部署脚本：

```bash
# 下载并运行快速部署脚本
./quick-deploy.sh
```

这个脚本会自动：
- 检查并安装所有依赖
- 配置环境变量
- 构建和启动所有服务
- 运行健康检查
- 显示访问地址

## 📝 配置说明

### 环境配置
复制 `.env.example` 为 `.env` 并根据需要修改：

```bash
cp .env.example .env
# 编辑配置文件
nano .env
```

### 主机配置
编辑 `host-example.txt` 文件，配置目标主机：
```ini
[web_servers]
web1 ansible_host=192.168.1.10 ansible_user=ubuntu
web2 ansible_host=192.168.1.11 ansible_user=ubuntu

[db_servers]
db1 ansible_host=192.168.1.20 ansible_user=ubuntu

[monitoring]
monitor1 ansible_host=192.168.1.30 ansible_user=ubuntu
```

## 🔧 维护和管理

### 常用命令
```bash
# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f [服务名]

# 停止服务
docker-compose down

# 重启服务
docker-compose restart

# 更新服务
git pull
docker-compose build --no-cache
docker-compose up -d
```

### 备份数据
```bash
# 备份数据库
./scripts/backup-database.sh

# 备份配置文件
tar -czf config-backup-$(date +%Y%m%d).tar.gz ansible/ mib-platform/ all-in-one/
```

## 📈 特色功能

✅ **一键部署** - 真正的拉取即用，无需复杂配置  
✅ **完整监控** - 集成 Prometheus + Grafana 监控栈  
✅ **生产就绪** - 包含 SSL、安全配置、备份策略  
✅ **多环境支持** - 开发、测试、生产环境配置  
✅ **容器化** - 完整的 Docker 部署方案  
✅ **高可用** - 支持集群部署和负载均衡  
✅ **安全加固** - 内置安全最佳实践  
✅ **API 完整** - RESTful API 和 Swagger 文档  

## 🛠️ 故障排除

### 常见问题

1. **服务无法启动**
   ```bash
   # 检查端口占用
   sudo netstat -tlnp | grep :3000
   
   # 检查 Docker 服务
   systemctl status docker
   ```

2. **数据库连接失败**
   ```bash
   # 检查数据库容器
   docker-compose logs postgres
   
   # 重启数据库服务
   docker-compose restart postgres
   ```

3. **前端构建失败**
   ```bash
   # 清理并重新安装依赖
   rm -rf node_modules package-lock.json
   npm install
   ```

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 技术支持

- 项目 Issues: [GitHub Issues](https://github.com/Oumu33/ansible-web-management-platform/issues)
- 项目主页: [GitHub Repository](https://github.com/Oumu33/ansible-web-management-platform)

---

**🎉 这是一个完整的生产就绪解决方案！**

克隆仓库，运行 `./quick-deploy.sh`，几分钟内就能拥有一个功能完整的 Ansible Web 管理平台！

包含所有配置文件、依赖管理、部署脚本，真正做到「拉取即用」！