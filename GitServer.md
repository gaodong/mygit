### git服务器搭建

---

转至:[http://blog.csdn.net/ice520301/article/details/6142503](http://blog.csdn.net/ice520301/article/details/6142503)

##### 软件需求
1. **git**
2. **gitosis**
3. **openssh-server**
4. **openssh-client**
5. **Apache2(Gitweb)**

##### 安装配置Git服务器

1.	安装git和openssh:

	* 	gordon@ubuntu:~$ `sudo apt-get install git openssh-server openssh-client`

2.	新加用户git， 该用户将作为所有代码仓库和用户权限的管理者：

	* 	gordon@ubuntu:~$ `sudo useradd -m git`
	* 	gordon@ubuntu:~$ `sudo passwd git`

3.	建立一个git仓库的存储点：

	* 	gordon@ubuntu:~$ `sudo mkdir /home/repo`

4.	让除了git以外的用户对此目录无任何权限：

	* 	gordon@ubuntu:~$ `sudo chown git:git /home/repo`
	* 	gordon@ubuntu:~$ `sudo chmod 700 /home/repo`


##### 安装配置gitosis

1.	初始化一下服务器的git用户，这一步其实是为了安装gitosis做准备。在任何一 台机器上使用git，第一次必须要初始化一下：

	* 	gordon@ubuntu:~$ `git config –global user.name "git"`
	* 	gordon@ubuntu:~$ `git config –global user.email "git@server.com"`

2.	安装一下python的setup tool， 这个也是为了gitosis做准备：

	* 	gordon@ubuntu:~$ `sudo apt-get install python-setuptools`

3.	获得gitosis包：

	* 	gordon@ubuntu:~$ `cd /tmp`
	* 	gordon@ubuntu:/tmp$ `git clone https://github.com/tv42/gitosis.git`
	* 	gordon@ubuntu:/tmp$ `cd gitosis`
	* 	gordon@ubuntu:/tmp/gitosis$ `sudo python setup.py install`

4.	切换到git用户下：

	* 	gordon@ubuntu:/tmp/gitosis$ `su git`

5.	默认状态下，gitosis会将git仓库放在 git用户的home下，所以我们做一个链接到/home/repo

	* 	git@ubuntu:~$ `ln -s /home/repo /home/git/repositories`

6.	再次返回到默认用户

	* 	git@ubuntu:~$ `exit`

7.	生成公钥

	* 	gordon@ubuntu:~$ `ssh-keygen -t rsa -C "git@server.com"`

8.	将公钥拷贝到服务器的/tmp下：

	* 	gordon@ubuntu:~/.ssh$ 'sudo cp id_rsa.pub /tmp/id_rsa.pub'

9.	回到git服务器上

	* 	gordon@ubuntu:/tmp/gitosis$ `sudo chmod a+r /tmp/id_rsa.pub`

10.	让gitosis运行起来：

	* 	gordon@ubuntu:/tmp/gitosis$ `sudo -H -u git gitosis-init < /tmp/id_rsa.pub`

> 	gitosis的有趣之处在于，它通过一个git仓库来管理配置文件，仓库就放在了/home/repo/gitosis- admin.git。我们需要为一个文件加上可执行权限：

11. root权限

	* 	gordon@ubuntu:/tmp/gitosis$ `su`

12. 执行

	* 	root@ubuntu:/home/git# `cd repositories`
	* 	root@ubuntu:/home/git/repositories# `cd gitosis-admin.git/`
	* 	root@ubuntu:/home/git/repositories/gitosis-admin.git# `sudo chmod 755 /home/repo/gitosis-admin.git/hooks/post-update`
	*	root@ubuntu:/home/git/repositories/gitosis-admin.git# `exit`


##### 在服务器上新建一个测试项目仓库

>	建立一个叫“teamwork”的仓库。
1.	切换到git用户：

	*	gordon@ubuntu:/home/gordon$ `su - git`
	*	gordon@ubuntu:/home/git$ `cd /home/prj_git`
	*	gordon@ubuntu:/home/git$ `mkdir teamwork.git`
	*	gordon@ubuntu:/home/git$ `cd teamwork.git`
	*	gordon@ubuntu:/home/git$ `git init --bare`
	*	gordon@ubuntu:/home/git$ `exit`

>	但是，到目前为止，这只是一个空仓库，空仓库是不能clone下来的。为了能做clone，我们必须先让某个有权限的人放一个初始化的版本到仓库中。

* 所以，我们必须先修改一下gitosis-admin.

##### 管理gitosis的配置文件

> 	刚刚提到，gitosis本身的配置也是通过git来实现的。在你自己的开发机里，把gitosis-admin.git这个仓库clone下来，就可以以管理员的身份修改配置了。

1.	在你的电脑里：

	*	$ `git clone git@<server>:gitosis-admin.git`

	如果出现：
	__fatal: '~/gitosis-admin.git' does not appear to be a git repository__
	__fatal: The remote end hung up unexpectedly__
	改成:

	*	$ `sudo git clone git@<server>:/home/prj_git/gitosis-admin.git`


2.	进入gitosis-admin目录

	* 	$ cd gitosis-admin/

	>	该目录下的keydir目录是用来存放所有需要访问git服务器的用户的ssh公钥：
各个用户按照前面提到的办法生成各自的ssh公钥文件后，把所有人的 ssh公钥文件都拿来，按名字命名一下，比如b.pub, lz.pub等，统统拷贝到keydir下：

	*	gordon@gordon-pc:~/work/gitosis-admin$ `su root`
	*	root@gordon-pc:/home/work/gitosis-admin # `cp /path/to/.ssh/id_rsa.pub ./keydir/b.pub`
	*	root@gordon-pc:/home/work/gitosis-admin # `exit`

3.	修改gitosis.conf文件，我的配置大致如下：
	
	[gitosis]
	[group gitosis-admin]
	writable = gitosis-admin
	members = a@server usr@pc1
	[group hello]
	writable = teamwork
	members = a@server b
	[group hello_ro]
	readonly = teamwork
	members = lz

>	这个配置文件表达了如下含义：gitosis-admin组成员有a, usr，该组对gitosis-admin仓库有读写权限；
team组有a，b两个成员，该组对teamwork仓库有读写权限；
team_ro组有lz一个成员，对teamwork仓库有只读权限。

>	当然目前这些配置文件的修改只是在你的本地，你必须推送到远程的gitserver上才能真正生效。

4.	加入新文件、提交并push到git服务器：

	*	gordon@gordon-pc:~/work/gitosis-admin$ `git add .`
	*	gordon@gordon-pc:~/work/gitosis-admin$ `git commit -am "add teamweok prj and users"`
	*	gordon@gordon-pc:~/work/gitosis-admin$ `git push origin master`

##### 初始化测试项目

>	好了，现在服务器就搭建完了，并且有一个空的项目teamwork在服务器上。接下来呢？当然是测试一下，空仓库是不能clone的，所以需要某一个有写权限的人初始 化一个版本。就我来做吧，以下是在客户端完成。

	*	gordon@gordon-pc:~/work$ `mkdir teamwork-ori`
	*	gordon@gordon-pc:~/work$ `cd teamwork-ori/`
	*	gordon@gordon-pc:~/work/teamwork-ori$ `git init`
	*	gordon@gordon-pc:~/work/teamwork-ori$ `echo "/*add something*/" > hello`
	*	gordon@gordon-pc:~/work/teamwork-ori$ `git add .`
	*	gordon@gordon-pc:~/work/teamwork-ori$ `git commit -am "initial version"`
	*	gordon@gordon-pc:~/work/teamwork-ori$ `git remote add origin git@<server>:teamwork.git`
	*	gordon@gordon-pc:~/work/teamwork-ori$ `git push origin master`

>	到此为止teamwork已经有了一个版本了，team的其他成员只要先clone一下 teamwork仓库，就可以任意玩了。

	*	gordon@gordon-pc:~$ `su caven'
	*	caven@gordon-pc:~$ `cd /home/caven'
	*	caven@gordon-pc:~/home/caven$ `git clone git@<server>:teamwork.git`
	*	caven@gordon-pc:~/home/caven$ `cd teamwork`
	*	caven@gordon-pc:~/home/caven/teamwork$ `vim hello`
	*	caven@gordon-pc:~/work/caven/teamwork$ `git add .`
	*	caven@gordon-pc:~/work/caven/teamwork$ `git commit -am "b add"`
	*	caven@gordon-pc:~/work/caven/teamwork$ `git push origin master`
	*	caven@gordon-pc:~/work/caven/teamwork$ `exit`

##### 添加已有git项目
	
>	另外：如果你有一个现成的git仓库，想放到 gitserver上供team使用（比如你clone了一个官方的kernel仓库，想在内部使用它作为基础仓库），怎么办呢。

1.	首先需要从你的工作仓库中得到一个纯仓库, 比如你的工作目录为~/kernel, 你想导出纯仓库到你的优盘里，然后拷贝到gitserver上去。
	*	$ `git clone –bare ~/kernel /media/udisk`

2.	然后就拿着优盘，交给gitserver的管理员，让他拷贝到/home/repo/下，同时需要配置 gitosis相关配置文件哦，这个就不用再说了吧。比如：下载ALSA库：
	*	$ `git clone git://android.git.kernel.org/platform/external/alsa-lib.git`
	*	$ `git clone git://android.git.kernel.org/platform/external/alsa-utils.git`

3.	生成bare库
	*	$ `git clone –bare alsa-lib alsa-lib.git`
	*	$ `git clone –bare alsa-utils alsa-utils.git`

4.	将bare 库移动到git服务器目录
	*	$ `cp alsa-lib.git /home/repo`

5.	注意变更所有者，以获取提交权限。
	*	$ `chown -R git alsa-lib.git`


#####	配置gitweb

1.	安装gitweb  

   	*	$ `sudo apt-get install gitweb`

2. 	安装apache2

   	*	$ `sudo apt-get install apache2`

3. 	配置gitweb 
	
	1.	默认没有 css 加载，把 gitweb 要用的静态文件连接到 DocumentRoot 下：
   	*	`cd /var/www/`
   	*	`sudo ln -s /usr/share/gitweb/* .`	(注意后面的点)

	2.	修改配置：

   	*	`sudo vi /etc/ gitweb.conf`

   	将 $projectroot 改为gitosis-admin.git所在目录： /home/git/repositories

 	3.	修改 /home/git/repositories权限，默认情况下，gitosis将 repositories权限设置为不可读的

    *	`sudo chmod 777 -R /home/git/repositories`

## 未完待续