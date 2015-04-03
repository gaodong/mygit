### git 命令 ###
====
#### 基本操作
-------


##### 初始化 #####
* git init 

##### 向缓存区增加文件 #####
* git add `filename`
* git add .
* git add --all 

##### 向本地版本库提交 #####	
* git commit -m '`comment`'

##### 日志 #####
* git log 
* git log --pretty=oneline
* git log --graph --pretty=oneline --abbrev-commit
* git reflog

##### 回退/恢复 #####
* git reset --hard HEAD^  	// 恢复到前一个
* git reset --hard HEAD^^		// 恢复到前前一个
* git reset --hard HEAD~`3`		// 恢复到倒数第三个
* git reset --hard `version no` (版本号)	// 恢复到某个版本号

* git reset HEAD `filename`		// 将缓存区的清空，恢复到和版本库一致
* git checkout -- `filename`	// 恢复到和缓存区一致 两种：1.缓存区无数据，恢复到和版本库一致
						     			            2.缓存区有数据，恢复到和缓存区一致
##### 查询本地状态 #####
* git status

##### 比较文件 #####
* git diff `filename`
* git diff HEAD -- `filename` // 比较最新版本

##### 从版本库中删除文件 #####
* git rm `filename`

#### 分支
-------

##### 创建分支 #####
* git branch `branchname`

##### 切换分支 #####
* git checkout `branchName`

##### 创建&切换（一步到位） #####
* git checkout -b `branchname`

##### 删除分支 #####
* git branch -d `branchName`

##### 推送分支 #####
* git push origin `branchName`

##### 远程删除分支 #####

* git push origin --delete `branchName`

##### 查看分支 #####
* git branch

##### 查看远程分支 #####
* git branch -a

##### 查看分支信息 #####
* git branch -r

##### 同步远程分支 #####
* git checkout -b `localBranchName` `remoteBranchName` 
  <br/> remoteBranchName = branch -r 得到的名称

#### 远程
-----------
##### 查看远程信息 #####
* git remote
* git remote -v

##### 远程删除 #####
* git remote rm origin // 删除远程关联

##### 修改远程地址 #####
* git remote origin set-url `url`

##### 设置远程 #####
* git remote add origin git@github.com:`username`/`gitName`.git

##### 推送到远程 #####
* git push [-u] origin master // 推送到远程 -u 第一次推送

#### Merge
-----------
##### merge #####
* git merge `branchName` // 切换到当前分支执行
* git merge --no-ff -m '`comment`' `branchName` // 非fast forward模式

#### Stash
> 当前分支下工作未完成，需要临时切换到其他分支完成工作，完成工作后返回当前工作区

##### 保存当前工作区 #####
* git stash

##### 查看暂存工作区 #####
* git stash list

##### 提取当前工作区 #####
* git stash pop

##### 提起 stash list 中制定的工作区 #####
* git stash apply `stash@{1}`

##### 使用apply提取的工作区并不会删除 #####
* git stash drop `stash@{1}`


#### Tag
---
##### 创建Tag #####
* git tag `tagName` // 对当前HEAD打tag

##### 对之前的版本打tag #####
* git tag `tagName` `branchVersion` // branchVersion = git reflog 获得的版本号

##### 对tag加注释 #####
* git tag -a `tagName` -m '`comment`' // 创建标签 -a 加标签 -m 加注释
* git tag -s `tagName` -m '`comment`'  // 创建GPG签名的标签


##### 查看Tag #####
* git show `tagName`
* git tag -l v1.4.2.* // 按照匹配模式显示tag

##### 删除标签 #####
* git tag -d `tagName`

##### 推送标签 #####
1. git push origin `tagName` or git push origin --tags


##### 远程删除 #####
1. git tag -d `tagName`
2. git push origin :refs/tags/`tagName`


#### .gitignore
---
##### 在ignore文件中新增忽略文件类型失效解决方法 #####
1. 修改gitignore文件, commit
2. 清除缓存
	* git rm --cached .gitignore
	* git rm --cached `filename or dirName` -r // 在本地版本库的缓存中删除对应的文件
	* git add --all
	* git commit -m '`comment`'
	* git push origin `branchName`


