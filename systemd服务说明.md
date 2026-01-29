# Systemd服务配置说明

## 为什么需要systemd服务配置？

### 1. **自动启动和管理**
- 服务器重启后，后端服务会自动启动
- 服务崩溃后会自动重启（`Restart=always`）
- 统一管理服务的启动、停止、重启

### 2. **日志管理**
- 所有输出和错误都会记录到指定日志文件
- 方便排查问题：`tail -f /opt/my-blog/logs/backend-error.log`

### 3. **资源控制**
- 可以设置内存限制（`-Xms512m -Xmx1024m`）
- 可以设置启动顺序（`After=network.target mysql.service`）

### 4. **生产环境标准做法**
- 不使用 `nohup java -jar &` 这种临时方式
- 使用systemd是Linux生产环境的标准做法

## 当前问题

从你的终端输出可以看到：
```
Failed to stop my-blog.service: Unit my-blog.service not loaded.
sed: can't read /etc/systemd/system/my-blog.service: No such file or directory
```

**这说明服务文件根本不存在！** 需要先创建，而不是更新。

## 解决方案

### 方案1：使用脚本创建（推荐）

我已经创建了 `创建systemd服务.sh` 脚本，在服务器上执行：

```bash
# 上传脚本到服务器
scp 创建systemd服务.sh root@your_server:/root/

# 在服务器上执行
ssh root@your_server
chmod +x /root/创建systemd服务.sh
/root/创建systemd服务.sh
```

### 方案2：手动创建

在服务器上执行：

```bash
# 1. 创建服务文件
sudo nano /etc/systemd/system/my-blog.service
```

粘贴以下内容：

```ini
[Unit]
Description=My Blog Backend Service
After=network.target mysql.service

[Service]
Type=simple
User=root
WorkingDirectory=/opt/my-blog/backend
ExecStart=/usr/bin/java -jar -Xms512m -Xmx1024m --spring.profiles.active=prod /opt/my-blog/backend/blog-server-1.0.0.jar
Restart=always
RestartSec=10
StandardOutput=append:/opt/my-blog/logs/backend.log
StandardError=append:/opt/my-blog/logs/backend-error.log

[Install]
WantedBy=multi-user.target
```

保存后执行：

```bash
# 2. 创建日志目录
sudo mkdir -p /opt/my-blog/logs

# 3. 重新加载systemd
sudo systemctl daemon-reload

# 4. 启用服务（开机自启）
sudo systemctl enable my-blog

# 5. 启动服务
sudo systemctl start my-blog

# 6. 查看状态
sudo systemctl status my-blog
```

## 关键配置说明

### `--spring.profiles.active=prod`
- **必须添加**，否则后端会使用开发环境配置（`application.yml`）
- 生产环境配置在 `application-prod.yml` 中，包含正确的数据库配置

### `Restart=always`
- 服务崩溃后自动重启
- 服务器重启后自动启动

### 日志文件
- 标准输出：`/opt/my-blog/logs/backend.log`
- 错误输出：`/opt/my-blog/logs/backend-error.log`

## 常用命令

```bash
# 查看服务状态
sudo systemctl status my-blog

# 启动服务
sudo systemctl start my-blog

# 停止服务
sudo systemctl stop my-blog

# 重启服务
sudo systemctl restart my-blog

# 查看日志
sudo journalctl -u my-blog -f

# 查看错误日志
tail -f /opt/my-blog/logs/backend-error.log
```

## 验证服务是否正常

```bash
# 1. 检查服务状态
sudo systemctl status my-blog

# 2. 检查端口
netstat -tlnp | grep 8080

# 3. 测试接口
curl http://localhost:8080/api/health
```

如果以上都正常，502错误应该就解决了！
