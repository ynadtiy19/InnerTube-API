# 1. 使用官方轻量 Python 3.10
FROM python:3.10-slim

# 2. 设置环境变量：关闭 Python 输出缓冲，默认端口设为 8080
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8080

# 3. 设置工作目录
WORKDIR /app

# 4. 先安装依赖（利用 Docker 层缓存加速重复构建）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. 复制项目所有代码
COPY . .

# 6. 暴露 8080 端口
EXPOSE 8080

# 🌟 7. 生产环境启动：绑定 0.0.0.0，优先读取 Zeabur 的 $PORT，若无则使用 8080
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8080}"]
