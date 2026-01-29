#!/bin/bash
# 创建systemd服务文件的脚本
# 在服务器上执行此脚本

echo "=== 创建systemd服务配置 ==="

# 1. 创建服务文件
echo "1. 创建 /etc/systemd/system/my-blog.service 文件..."
sudo tee /etc/systemd/system/my-blog.service > /dev/null << 'EOF'
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
EOF

# 2. 创建日志目录
echo "2. 创建日志目录..."
sudo mkdir -p /opt/my-blog/logs
sudo chmod 755 /opt/my-blog/logs

# 3. 重新加载systemd
echo "3. 重新加载systemd配置..."
sudo systemctl daemon-reload

# 4. 启用服务（开机自启）
echo "4. 启用服务（开机自启）..."
sudo systemctl enable my-blog

# 5. 启动服务
echo "5. 启动服务..."
sudo systemctl start my-blog

# 6. 等待2秒
sleep 2

# 7. 查看状态
echo ""
echo "=== 服务状态 ==="
sudo systemctl status my-blog --no-pager

echo ""
echo "=== 最近30条日志 ==="
sudo journalctl -u my-blog -n 30 --no-pager

echo ""
echo "=== 检查端口 ==="
netstat -tlnp | grep 8080 || echo "警告：8080端口未监听"

echo ""
echo "=== 测试后端接口 ==="
curl -s http://localhost:8080/api/health || echo "警告：后端接口无法访问"

echo ""
echo "=== 完成 ==="
echo "如果服务未启动，请检查："
echo "  1. jar文件是否存在：ls -la /opt/my-blog/backend/blog-server-1.0.0.jar"
echo "  2. Java是否安装：java -version"
echo "  3. 错误日志：tail -f /opt/my-blog/logs/backend-error.log"
