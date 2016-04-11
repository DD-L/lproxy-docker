制作 lproxy 镜像

1. Get

	```shell
	$ git clone -b docker-dev https://github.com/DD-L/lproxy-docker.git lproxy-docker
	$ cd lproxy-docker/lproxy
	```

2. 清理本地存在 lproxy 容器

	```shell
	$ sudo docker stop lproxy
	$ sudo docker rm -f lproxy
	```

3. 运行脚本, 获取 lproxy 二进制文件

	```shell
	$ # 注意 workdir
	$ sudo bash ./get_lproxy_binary.sh
	```

4. 提交到 github.com

	```shell
	$ git add ./
	$ git commit -m "update"
	$ git push ..
	```

5. 到 hub.docker.com 和 daocloud.io 执行构建

