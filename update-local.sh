#!/bin/bash
# Lưu là update-local.sh

# Thay YOUR_DOCKERHUB_USERNAME bằng username thật
DOCKER_USERNAME="YOUR_DOCKERHUB_USERNAME"

echo "🔄 Updating local environment from Docker Hub..."

# Pull latest images
echo "📥 Pulling latest images..."
docker pull $DOCKER_USERNAME/backend:latest
docker pull $DOCKER_USERNAME/frontend:latest

# Update backend
echo "🔄 Updating backend..."
docker stop backend_container || true
docker rm backend_container || true
docker run -d --name backend_container \
  -p 5002:5000 \
  --restart unless-stopped \
  $DOCKER_USERNAME/backend:latest

# Update frontend
echo "🔄 Updating frontend..."
docker stop frontend_container || true
docker rm frontend_container || true
docker run -d --name frontend_container \
  -p 3000:3000 \
  --restart unless-stopped \
  $DOCKER_USERNAME/frontend:latest

# Cleanup
echo "🧹 Cleaning up..."
docker system prune -f

echo "✅ Update completed!"