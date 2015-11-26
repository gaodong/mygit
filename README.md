### Git 操作


##### 初始化

`git init`

##### 添加文件

`git add fileName`

##### 提交文件

`git commit -m "message"`


##### 比较文件
`git diff filename` *比较本地文件和缓存区*

`git diff HEAD filename` *比较本地文件和版本库的文件*

`git diff --staged` *比较暂存区与版本库之间的差别*
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

**切换分支**

`git checkout branchName`

##### 创建本地分支，并关联到远程分支

`git checkout -b <branchName> origin/dev`

##### 合并

`git merge branchName` # 当前在master，合并test分支内容

> merge 存在fast forward模式，这种模式下，如果其中一个分支无任何变化，那么合并之后会丢失另一分支信息，无另一分支修改节点
> 采用 --no-ff 参数，禁止faset forward模式

`git merge --no-ff -m "message" branchName`

##### 删除分支

`git branch -d branchName`

> 删除一个还未合并的分支使用

`git branch -D branchName`

### Stash 缓存

> 当前工作区内容还未完成，需要临时切换到其它分支工作，可以使用git stash 储存当前工作区

`git stash`

#####  查看储存的工作区

`git stash list`

##### 恢复工作区

`git stash apply stash@{0}` # 采用此方法恢复工作区，储存的工作区不会删除

`git stash drop stash@{0}`＃ 删除存储的工作区

**or**

`git stash pop` # 等同以上2句

##### 如果远程推送有冲突

`git pull` 取回到本地工作区，解决冲突，提交，推送

> 如果 git pull 提示no tracking information失败，说明本地分支和远程分支没有建立链接

`git branch --set-upstream dev origin/dev`

`git pull`


###### 标签 tag

`git tag v0.01`

`git tag v0.01 <commit_id>`

`git show v0.01`

`git tag` # 查看打的tag

##### 未标签增加说明

`git tag -a v0.01 -m "" <commit_id>`

##### 删除标签

`git tag -d v0.01`

##### 推送标签

`git push origin v0.01`

`git push origin --tags` # 本地标签全部推上去

##### 删除远程标签

1. 先删除本地标签

	`git tag -d v0.01`

2. 删除远程标签
	
	`git push origin :refs/tags/v0.01`


