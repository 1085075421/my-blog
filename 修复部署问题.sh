#!/bin/bash
# 快速修复部署问题的脚本
# 在服务器上执行此脚本

echo "=== 开始修复部署问题 ==="

# 1. 停止服务
echo "1. 停止后端服务..."
sudo systemctl stop my-blog

# 2. 更新systemd配置（添加生产环境配置）
echo "2. 更新systemd服务配置..."
sudo sed -i 's|ExecStart=/usr/bin/java -jar -Xms512m -Xmx1024m /opt/my-blog/backend/blog-server-1.0.0.jar|ExecStart=/usr/bin/java -jar -Xms512m -Xmx1024m --spring.profiles.active=prod /opt/my-blog/backend/blog-server-1.0.0.jar|' /etc/systemd/system/my-blog.service

# 3. 重新加载systemd
echo "3. 重新加载systemd配置..."
sudo systemctl daemon-reload

# 4. 启动服务
echo "4. 启动后端服务..."
sudo systemctl start my-blog

# 5. 等待2秒
sleep 2

# 6. 查看状态
echo ""
echo "=== 服务状态 ==="
sudo systemctl status my-blog --no-pager

echo ""
echo "=== 最近30条日志 ==="
sudo journalctl -u my-blog -n 30 --no-pager

echo ""
echo "=== 检查端口 ==="
netstat -tlnp | grep 8080 || echo "警告：8080端口未监听，服务可能未启动成功"

echo ""
echo "=== 测试后端接口 ==="
curl -s http://localhost:8080/api/health || echo "警告：后端接口无法访问"

echo ""
echo "=== 修复完成 ==="
echo "如果服务未启动，请检查日志："
echo "  sudo tail -f /opt/my-blog/logs/backend-error.log"
