#!/bin/bash
# Lưu là update-local.sh

# Thay YOUR_DOCKERHUB_USERNAME bằng username thật
DOCKER_USERNAME="hoangcntt2k3"  # Thay username Docker Hub của bạn ở đây

echo "🔄 Updating local environment from Docker Hub..."

# Pull latest images
echo "📥 Pulling latest images..."
docker pull $DOCKER_USERNAME/backend:latest
docker pull $DOCKER_USERNAME/frontend:latest

# Update backend
echo "🔄 Updating backend..."
docker stop backend || true
docker rm backend || true
# Kiểm tra cổng trước khi chạy lại container
if ! docker run -d --name backend -p 5002:5000 --restart unless-stopped $DOCKER_USERNAME/backend:latest; then
  echo "⚠️ Port 5002 already in use, trying another port."
  docker run -d --name backend -p 5003:5000 --restart unless-stopped $DOCKER_USERNAME/backend:latest
fi

# Update frontend
echo "🔄 Updating frontend..."
docker stop frontend || true
docker rm frontend || true
# Kiểm tra cổng trước khi chạy lại container
if ! docker run -d --name frontend -p 3000:3000 --restart unless-stopped $DOCKER_USERNAME/frontend:latest; then
  echo "⚠️ Port 3000 already in use, trying another port."
  docker run -d --name frontend -p 3001:3000 --restart unless-stopped $DOCKER_USERNAME/frontend:latest
fi

# Cleanup
echo "🧹 Cleaning up..."
docker system prune -f

echo "✅ Update completed!"
