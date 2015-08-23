## Ubuntu 14 install GitLab

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install curl openssh-server ca-certificates postfix`
* `curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash`
* `sudo apt-get install gitlab-ce=7.11.4~omnibus-1`
此步可能失败，如果失败，需要自行下载安装包

* `sudo dpkg -i gitlab-ce_7.11.4~omnibus-1_amd64.deb `
* `sudo gitlab-ctl reconfigure`

* `sudo -e gitlab.rb`
* `sudo gitlab-ctl start`
* `sudo gitlab-ctl stop`
* `sudo gitlab-ctl restart`

* `sudo gitlab-ctl status`
* `sudo gitlab-ctl tail` 

邮件配置

```

external_url 'http://git-server.com'

#Sending application email via SMTP
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.qq.com"
gitlab_rails['smtp_port'] = 25 
gitlab_rails['smtp_user_name'] = "username@qq.com"
gitlab_rails['smtp_password'] = "password"
gitlab_rails['smtp_domain'] = "smtp.qq.com"
gitlab_rails['smtp_authentication'] = :plain
gitlab_rails['smtp_enable_starttls_auto'] = true

##修改gitlab配置的发信人
gitlab_rails['gitlab_email_from'] = "username@qq.com"
user["git_user_email"] = "username@qq.com"

```