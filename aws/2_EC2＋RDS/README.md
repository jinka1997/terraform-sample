# やること
- 最低限のスペックのWindowsServerを立てる
- 作業場所からEC2にインターネット経由でリモート接続できること
- RDSにEC2経由で接続できること

## 参考
[チュートリアル: DB インスタンス用の Amazon VPC を作成する](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/CHAP_Tutorials.WebServerDB.CreateVPC.html)


# 手順
## VPC作成
![vpc](./images/1_vpc.png)

## サブネット作成

![subnet](./images/2_subnet.png)

### パブリックサブネット
![public1a](./images/2-1-1_subnet_public1a.png)
![public1a](./images/2-1-2_subnet_public1a_routetable.png)


### プライベートサブネット
RDSでサブネットグループを指定する必要があるため2つ作成。

![private1a](./images/2-2-1_subnet_private1a.png)
![private1a](./images/2-2-2_subnet_private1a_routetable.png)
![private1c](./images/2-3-1_subnet_private1c.png)
![private1c](./images/2-3-2_subnet_private1c_routetable.png)

## インターネットゲートウェイ
![igw](./images/3_internet_gateway.png)


## NATゲートウェイ
![nat](./images/4-1_nat_gateway_elasticIP.png)
![nat](./images/4-2_nat_gateway.png)

## ルートテーブルの編集
### カスタムルートテーブル
インターネットゲートウェイへのルートを追加し、パブリックサブネットに関連付け。
![custom_route](./images/5-1-1_custom_routetable.png)
![custom_route](./images/5-1-2_custom_routetable_route.png)
![custom_route](./images/5-1-3_custom_routetable_subnet.png)

### メインルートテーブル
NATゲートウェイへのルートを追加。
![main_route](./images/5-2-1_main_routetable.png)
![main_route](./images/5-2-2_main_routetable_route.png)
![main_route](./images/5-2-3_main_routetable_subnet.png)


## セキュリティグループ
### EC2用 
![sg_ec2](./images/6-1-1_security_group_ec2.png)

### RDS用
![sg_rds](./images/6-2-1_security_group_rds.png)


## EC2
![ec2](./images/7-1_ec2.png)
![ec2](./images/7-2_ec2.png)
![ec2](./images/7-3_ec2_security.png)
![ec2](./images/7-4_ec2_network.png)
![ec2](./images/7-5_ec2_storage.png)

## RDS
![rds](./images/8-1_rds.png)
![rds](./images/8-2_rds_connection.png)
![rds](./images/8-3_rds_connection.png)
![rds](./images/8-4_rds_instance.png)
![rds](./images/8-5_rds_instance.png)
![rds](./images/8-6_rds_subnet_group.png)
![rds](./images/8-7_rds_parameter_group.png)
![rds](./images/8-8_rds_option_group.png)


