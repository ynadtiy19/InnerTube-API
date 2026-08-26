# 使用官方轻量 Python 3.10
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 先安装依赖（利用 Docker 缓存加速构建）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目所有文件
COPY . .

# 暴露 FastAPI 端口
EXPOSE 8080

# 🌟 生产环境启动：绑定 0.0.0.0
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
