## Ubuntu Shadowsocks 代理配置 ##

1. Update

	```
	sudo apt-get update	
	sudo apt-get upgrade
	```
2. 安装shadowsocks

	```
	sudo apt-get install shadowsocks
	```
3. 修改shadowsocks配置
	
	```
	sudo view /etc/shadowsocks/config.json
	
	{
    	"server":"SERVER_HOST/SERVER_IP",
    	"server_port":PORT,
    	"local_address": "127.0.0.1",
    	"local_port":1080,
    	"password":"SERVER_PWD",
    	"timeout":300,
    	"method":"aes-256-cfb",
    	"fast_open": false,
    	"workers": 1
	} 
	```

4. 启动ss客户端

	```
	sslocal -c /etc/shadowsocks/config.json 
	```

> ss的代理对于curl、wget、apt-get命令无效，需要进行一下配置

* 安装polipo
	
	```
	apt-get install polipo
	``` 

* 启动以及停止

	```
	sudo /etc/init.d/polipo start
	sudo /etc/init.d/polipo stop
	sudo /etc/init.d/polipo restart
	```

* polipo 配置

	```
	proxyAddress = "0.0.0.0"

	socksParentProxy = "127.0.0.1:1080" # shadowsocks配置的1080
	socksProxyType = socks5
	
	chunkHighMark = 50331648
	objectHighMark = 16384
	
	serverMaxSlots = 64
	serverSlots = 16
	serverSlots1 = 32
	```

*  启动polipo
	
	```
	sudo /etc/init.d/polipo start
	```

*  开始代理使用， 这里的8123是polipo的默认端口

	```
	http_proxy=http://localhost:8123 sudo apt-get update
	http_proxy=http://localhost:8123 curl www.google.com
	http_proxy=http://localhost:8123 wget http://aws.amazon.com/files/...
	```
