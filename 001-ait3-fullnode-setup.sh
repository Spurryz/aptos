#抖音号  jiamixiaoxiongdi  关注web3  aptos  sui  aleo  等近期上线项目的撸空奖励 更多资讯关注抖音进群； 
# 三级粉丝团进DY粉丝群  抖音刷保时捷 可以进抖音粉丝群 可以 1V1 提供指导 谈合作 ；   
#欢迎打赏  bsc 0xb9b8F82Cf21F86538D94456F9990cBf5bAe9A8B7
# APTOS 三测 
#1.切换root权限 sudo su 输入root密码 回车
#2 export USERNAME=jiamixiongdi     这里jiamixiongdi   修改成你的用户名
#2. 拷贝 001-ait3-fullnode-setup.sh  docker-compose.yaml 到云服务器root目录下  ；或者直接直接在根目录下 用vi 编辑拷贝这两个文件   001-ait3-fullnode-setup.sh  docker-compose.yaml 键盘按ESE  输入 :wq    保存退出      
#3. chmod +x 001-ait3-fullnode-setup.sh
#4. 执行一键安装  sh   001-ait3-fullnode-setup.sh
sudo -s
apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update -y&&apt-get install ca-certificates curl gnupg lsb-release -y
apt install unzip
wget -O get-docker.sh https://get.docker.com
sudo sh get-docker.sh
rm -f get-docker.sh
#sudo curl -L "https://github.com/docker/compose/releases/download/2.2.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
curl -L "https://github.com/docker/compose/releases/download/$(curl https://github.com/docker/compose/releases | grep -m1 '<a href="/docker/compose/releases/download/' | grep -o 'v[0-9:].[0-9].[0-9]')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
wget -qO aptos-cli.zip https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-v0.3.1/aptos-cli-0.3.1-Ubuntu-x86_64.zip
unzip -o aptos-cli.zip -d /usr/local/bin
chmod +x /usr/local/bin/aptos
rm aptos-cli.zip
export WORKSPACE=aptos-ait3
#export USERNAME=jiamixiongdi
mkdir ~/$WORKSPACE
cd ~/$WORKSPACE
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml
cp ~/docker-compose.yaml ~/$WORKSPACE/docker-compose.yaml
aptos genesis generate-keys --output-dir ~/$WORKSPACE/keys
aptos genesis set-validator-configuration \
 --local-repository-dir ~/$WORKSPACE \
 --username $USERNAME \
 --owner-public-identity-file ~/$WORKSPACE/keys/public-keys.yaml \
 --validator-host 167.86.78.247:6180 \
 --full-node-host 167.86.78.247:6182 \
 --stake-amount 100000000000000
aptos genesis generate-layout-template --output-file ~/$WORKSPACE/layout.yaml
sudo bash -c "cat > layout.yaml" <<EOF
root_key: "D04470F43AB6AEAA4EB616B72128881EEF77346F2075FFE68E14BA7DEBD8095E"
users:
  - "$USERNAME"
chain_id: 43
allow_new_validators: false
epoch_duration_secs: 7200
is_test: true
min_stake: 100000000000000
min_voting_threshold: 100000000000000
max_stake: 100000000000000000
recurring_lockup_duration_secs: 86400
required_proposer_stake: 100000000000000
rewards_apy_percentage: 10
voting_duration_secs: 43200
voting_power_increase_limit: 20
EOF
wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.3.0/framework.mrb
aptos genesis generate-genesis --local-repository-dir ~/$WORKSPACE --output-dir ~/$WORKSPACE
sudo ufw allow 8080
sudo ufw allow 6180
sudo ufw allow 9101
docker compose  pull
docker compose up -d 
ps -ef|grep  aptos
eoch "如果显示 如下 ：    00:00:00 /tini -- /usr/local/bin/aptos-node -f /opt/aptos/etc/validator.yaml"
eoch "install aptos-ait3 end 成功"

