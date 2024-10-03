# Chọn hình ảnh Node.js chính thức làm base image
FROM node:16-alpine AS builder

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép chỉ package.json và package-lock.json (nếu có)
COPY package*.json ./

# Cài đặt các phụ thuộc cần thiết cho môi trường phát triển
RUN npm install --production

# Sao chép mã nguồn vào container
COPY . .

# Xây dựng dự án TypeScript
RUN npm run build

# Chọn một hình ảnh Node.js chính thức khác để chạy ứng dụng
FROM node:16-alpine AS runner

# Thiết lập thư mục làm việc thành /app
WORKDIR /app

# Sao chép chỉ thư mục dist và node_modules từ builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

# Sao chép package.json (có thể cần cho một số môi trường)
COPY --from=builder /app/package.json ./

# Thiết lập biến môi trường
ENV NODE_ENV=production

# Mở cổng ứng dụng
EXPOSE 3000

# Chạy ứng dụng sử dụng npm start
CMD ["npm", "start"]
