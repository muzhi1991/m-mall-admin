# 使用基于alpine的node6.x,相比ubuntu版本体积较小，注意编译的node lib不同，可能引入bug
FROM node:6-alpine

# 设置镜像作者
MAINTAINER muzhi1991 <muzhi1991@gmail.com>

# 设置时区, alpine为apk安装工具
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone



# 安装根目录
WORKDIR /app
# 安装npm模块
ADD package.json /app/package.json
# 使用淘宝的npm镜像
RUN npm install --registry=https://registry.npm.taobao.org

# 安装public目录
WORKDIR /app/public
ADD public/package.json /app/public/package.json
RUN npm install --registry=https://registry.npm.taobao.org

# 添加源代码
WORKDIR /app
ADD . /app

# 编译public目录
WORKDIR /app/public
RUN npm run build

#ENV VIRTUAL_HOST=foo.bar.com

# 切换回主目录
WORKDIR /app
EXPOSE 3000

# 运行app.js
CMD ["npm", "start"]

