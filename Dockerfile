# 使用DaoCloud的Ubuntu镜像
FROM daocloud.io/library/ubuntu:14.04

# 设置镜像作者
MAINTAINER muzhi1991 <muzhi1991@gmail.com>

# 设置时区
RUN sudo sh -c "echo 'Asia/Shanghai' > /etc/timezone" && \
    sudo dpkg-reconfigure -f noninteractive tzdata

# 使用阿里云的Ubuntu镜像
RUN echo '\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse\n'\
> /etc/apt/sources.list

# 安装node v6.10.1
RUN sudo apt-get update && sudo apt-get install -y wget

# 使用淘宝镜像安装Node.js v6.10.1
#RUN wget https://npm.taobao.org/mirrors/node/v6.10.1/node-v6.10.1-linux-x64.tar.gz && \
#    tar -C /usr/local --strip-components 1 -xzf node-v6.10.1-linux-x64.tar.gz && \
#    rm node-v6.10.1-linux-x64.tar.gz 
RUN wget https://npm.taobao.org/mirrors/node/v6.9.5/node-v6.9.5-linux-x64.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf node-v6.9.5-linux-x64.tar.gz && \
    rm node-v6.9.5-linux-x64.tar.gz 

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



