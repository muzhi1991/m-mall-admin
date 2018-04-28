# m-mall-admin
后台管理界面[Demo](https://www.skyvow.cn)用户名/密码：admin/123456

## 项目说明：

- 基于 [Node.js](https://nodejs.org)、[MongoDB](https://www.mongodb.org)、[Redis](http://redis.io) 开发的系统
- 基于 [Express](http://expressjs.com) 提供 RESTful API
- 基于 [apidoc](http://apidocjs.com) 提供接口文档
- 基于 [Angular.js](https://angularjs.org)、[Ionic](http://ionicframework.com)、[Webpack](http://webpack.github.io) 构建前端
- 基于 ECMAScript 6 编码风格

## 目录结构：

```
m-mall-admin/
  |-bin/                      # 启动文件
     |- wwww
  |-common/                   # 公共文件
     |- ...
  |-controllers/              # 控制器
     |- ...
  |-db/                       # 数据库配置
     |- ...
  |-logs/                     # 日志文件
     |- ...
  |-middlewares/              # 中间件
     |- ...
  |-models/                   # 模型
     |- ...
  |-proxy/                    # 代理
     |- ...
  |-public/                   # 静态资源文件
     |- ...
  |-routes/                   # 路由文件
     |- ...
  |-test/                     # 测试文件
     |- ...
  |-views/                    # 视图文件
     |- ...
  |-apidoc.json               # 接口文档配置
  |-app.js                    # 入口文件
  |-config.js                 # 配置文件--默认是docker容器版本
  |-config-local.js           # 配置文件--本地运行服务的版本，如果需要重命名替换config.js
  |-...
```

##  安装部署：

### 克隆文件：

```
git clone git@github.com:skyvow/m-mall-admin.git
cd m-mall-admin
```

### 环境准备(for mac)：
#### mongodb
安装：brew install mongodb
启动：
  * 后台服务：mongod --config /usr/local/etc/mongod.conf（我添加了alias手动启动： start-mongod）
  * 客户端：mongo
配置/usr/local/etc/mongod.conf 
  * 日志：/usr/local/var/log/mongodb/mongo.log
  * 数据库位置：/usr/local/var/mongodb
  * 默认绑定本地127.0.0.1（其他机器无法连接）
开机启动：(brew services list)
   brew services start mongodb

#### redis
安装：brew install redis
启动：
  * 后台服务：redis-server /usr/local/etc/redis.conf（我添加了alias手动启动： start-redis-server，并配置启动参数，指定日志 --logfile "redis.log" --loglevel verbose ）
  * 客户端：redis-cli
配置/usr/local/etc/mongod.conf 
  * 日志：logfile配置默认是"",即/dev/null，mac中用brew安装，logfile="redis.log"，则表示/usr/local/var/db/redis/redis.log。（也可以加入路径）
  * 数据库位置：/usr/local/var/db/redis/
  * 默认绑定本地127.0.0.1（其他机器无法连接）
开机启动：(brew services list)
   brew services start redis

> 注意：conda按照的redis与他冲突了(查看redis-server的位置)，conda uninstall redis

#### nvm&&node
nvm来管理node版本，brew install nvm
* nvm install node 安装最新版 Node
* nvm ls 查看当前的node版本
* nvm install 6.9 按照6.9.x的最新版本

> ** 这个小程序系统用了node 6.9.5，使用node 7会报buffer相关api的错误。**

### 后端服务：
```
1. 安装 `Node.js[必须]` `MongoDB[必须]` `Redis[必须]`
2. 启动 MongoDB 和 Redis
3. 进入根目录下执行 `npm install` 安装项目所需依赖包
3. 如果本地执行，修改`config.js`（使用`config-local.js` 替换）执行 `npm start` 启动服务
4. 打开前端小程序，api可以使用
```

### 前端服务：
```
1. 首次启动项目未找到 build 文件
2. 进入 public 目录下执行 `npm install` 安装项目所需依赖包
3. 执行 `npm run build` 编译前端页面相关文件
4. 编译成功后生成 build 文件，位于 public 目录下
5. 打开浏览器访问 `http://localhost:3000`
```

### 其他命令:
```
# 生成 API 接口文档
1. npm run apidoc
2. 打开浏览器访问 `http://localhost:3000/apidoc`

# 跑测试用例
npm test
```

## Docker环境部署
### 安装nginx && ssl support
直接用hyperapp安装（也可自行安装，注意开启VPS的80和445端口）:
* nginx-proxy：一个第三方镜像（jwilder/nginx-proxy），自动化配置nginx安装域名转发.
* Nginx SSL Support：快速支持https（使用letsencrypt证书）

### 查看&&修改配置文件
docker相关的配置文件：
* Dockerfile：生成web镜像，是我们nodejs的项目镜像的构建编译，如果构建成功，一般不用修改。
* docker-compose.yml：项目编排文件，启动了redis，mongo。同时**设置了域名的转发和ssl证书**。按实际情况修改。
* Dockerfile-ubuntu：一个基于ubuntu的版本，生成镜像比较大，仅仅备份一下。

### 运行
* 启动安装好的nginx-proxy && Nginx-SSL-Support
* 在根目录下运行`docker-compose up -d`（如果需要前台运行，去掉-d参数,，关注日志输出）
* 可选：如果需要单独生成nodejs的镜像，运行`docker build -t muzhi1991/m-mall-admin .`（注意最后的点）
* 可选：如果修改代码后运行程序，`docker-compose up --build -d`回强制构建镜像

> 注意：使用docker images可能输出很多none的镜像，这是使用docker build/docker-compose build后可能回保留之前的旧镜像，可以使用命令`docker rmi $(docker images -qa -f 'dangling=true')` 批量删除

##  贡献

有任何意见或建议都欢迎提 issue

##  License

MIT
