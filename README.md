### Git 操作
branch edit
##### 初始化

`git init`

##### 添加文件

`git add fileName`

##### 提交文件

`git commit -m "message"`


##### 比较文件
`git diff filename` *比较本地文件和缓存区*

`git diff HEAD -- filename` *比较本地文件和版本库的文件*

##### 版本退回

`git reset --hard HEAD`

`git reset --hard HEAD^`

`git reset --hard HEAD~10`

`git reset --hard 123456`

`git reset HEAD fileName `  # 将暂存区恢复到和版本库一致

##### 撤销修改

`git checkout -- fileName `

`git checkout HEAD fileName`

> 1. 当文件未`add`到缓存区时，使用`checkout`命令将返回和版本库一致
> 
> 2. 当文件`add`到缓存区后，并且再次在工作区修改，使用`checkout`命令，则恢复到缓存区状态

##### 删除文件

`git rm filename`


##### 操作案例

1. 本地修改，未提交到缓存区，恢复

	`git checkout -- fileName`

2. 本地修改，提交到缓存区, 再次修改，恢复到缓存区

	`git checkout -- fileName`

3. 本地修改，提交到缓存区，想恢复到版本库

	`git reset HEAD fileName`

	`git checkout -- fileName`


### git远程

`git add remote origin git@github.com:gaodong/mygit.git` # 添加远程库

`git push -u origin master` # 第一次推送全部采用 -u 推送所有分支

`git push origin master` # 向服务器推送

##### 克隆

`git clone git@github.com:gaodong/mygit.git`

##### 分支

`git branch dev` 创建分支

`git checkout dev` 切换到分支

**or**

`git checkout -b dev` 创建并切换至分支

**查看当前分支**

`git branch`







