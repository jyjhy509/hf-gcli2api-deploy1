# 使用官方推荐的更轻量的基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装 uv，一个快速的 Python 包安装器
RUN pip install uv

# 复制依赖文件并安装依赖
# 这样可以利用 Docker 的层缓存，只有当 requirements.txt 变化时才会重新安装
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

# 克隆 gcli2api 仓库到 /app/gcli2api
RUN git clone https://github.com/su-kaka/gcli2api.git

# 设置最终的工作目录
WORKDIR /app/gcli2api

# 暴露端口
EXPOSE 7861

# 启动应用的命令
CMD ["python", "web.py"]
