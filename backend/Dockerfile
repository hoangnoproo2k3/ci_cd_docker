# Sử dụng image Node.js làm base image
FROM node:16-alpine

# Đặt thư mục làm việc trong container
WORKDIR /app

# Sao chép package.json và cài đặt dependencies
COPY package.json package-lock.json ./
RUN npm install

# Sao chép mã nguồn của backend vào container
COPY . .

# Build ứng dụng NestJS
RUN npm run build

# Expose port mà backend sẽ chạy
EXPOSE 5000

# Lệnh chạy ứng dụng khi container khởi động
CMD ["npm", "run", "start:prod"]
