#!/bin/bash

# 部署脚本
# 使用方法: ./deploy.sh [server_ip] [server_user]

SERVER_IP=${1:-"your_server_ip"}
SERVER_USER=${2:-"root"}
DEPLOY_DIR="/opt/my-blog"

echo "开始部署博客项目到服务器..."

# 1. 构建前端
echo "构建前端..."
cd client
npm install
npm run build
cd ..

# 2. 构建后端
echo "构建后端..."
cd server
mvn clean package -DskipTests
cd ..

# 3. 创建部署包
echo "创建部署包..."
mkdir -p deploy-package/frontend deploy-package/backend
cp -r client/dist/* deploy-package/frontend/
cp server/target/blog-server-1.0.0.jar deploy-package/backend/

# 4. 上传到服务器
echo "上传文件到服务器..."
scp -r deploy-package/* ${SERVER_USER}@${SERVER_IP}:${DEPLOY_DIR}/

# 5. 在服务器上执行部署命令
echo "在服务器上执行部署..."
ssh ${SERVER_USER}@${SERVER_IP} << 'ENDSSH'
# 停止服务
sudo systemctl stop my-blog

# 备份旧文件
sudo mkdir -p /opt/my-blog/backup
sudo cp -r /opt/my-blog/frontend /opt/my-blog/backup/frontend-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
sudo cp /opt/my-blog/backend/blog-server-1.0.0.jar /opt/my-blog/backup/blog-server-1.0.0.jar-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true

# 更新文件
sudo rm -rf /opt/my-blog/frontend/*
sudo cp -r /opt/my-blog/deploy-package/frontend/* /opt/my-blog/frontend/
sudo cp /opt/my-blog/deploy-package/backend/blog-server-1.0.0.jar /opt/my-blog/backend/

# 设置权限
sudo chown -R root:root /opt/my-blog/frontend
sudo chown root:root /opt/my-blog/backend/blog-server-1.0.0.jar

# 启动服务
sudo systemctl start my-blog
sudo systemctl status my-blog

# 重载Nginx
sudo systemctl reload nginx

echo "部署完成！"
ENDSSH

# 6. 清理本地临时文件
echo "清理临时文件..."
rm -rf deploy-package

echo "部署完成！请访问 http://${SERVER_IP}/my-blog/ 查看效果"
