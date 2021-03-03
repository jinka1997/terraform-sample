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

![subnet](./images/2_サブネット.png)

### パブリックサブネット
![public1a](./images/2-1-1_サブネットpublic1a.png)
![public1a](./images/2-1-2_サブネットpublic1a_ルートテーブル.png)


### プライベートサブネット
RDSでサブネットグループを指定する必要があるため2つ作成。

![private1a](./images/2-2-1_サブネットprivate1a.png)
![private1a](./images/2-2-2_サブネットprivate1a_ルートテーブル.png)
![private1c](./images/2-3-1_サブネットprivate1c.png)
![private1c](./images/2-3-2_サブネットprivate1c_ルートテーブル.png)

## インターネットゲートウェイ
![igw](./images/3_インターネットゲートウェイ.png)


## NATゲートウェイ
![nat](./images/4-1_NATゲートウェイ_ElasticIP.png)
![nat](./images/4-2_NATゲートウェイ.png)

## ルートテーブルの編集
### カスタムルートテーブル
インターネットゲートウェイへのルートを追加し、パブリックサブネットに関連付け。
![custom_route](./images/5-1-1_カスタムルートテーブル.png)
![custom_route](./images/5-1-2_カスタムルートテーブル_ルート.png)
![custom_route](./images/5-1-3_カスタムルートテーブル_サブネットとの関連付け.png)

### メインルートテーブル
NATゲートウェイへのルートを追加。
![main_route](./images/5-2-1_メインルートテーブル.png)
![main_route](./images/5-2-2_メインルートテーブル_ルート.png)
![main_route](./images/5-2-3_メインルートテーブル_サブネットとの関連付け.png)


## セキュリティグループ
### EC2用 
![sg_ec2](./images/6-1-1_セキュリティグループ_EC2_インバウンド.png)

### RDS用
![sg_rds](./images/6-2-1_セキュリティグループ_RDS_インバウンド.png)


## EC2
![ec2](./images/7-1_EC2.png)
![ec2](./images/7-2_EC2.png)
![ec2](./images/7-3_EC2_セキュリティ.png)
![ec2](./images/7-4_EC2_ネットワーキング.png)
![ec2](./images/7-5_EC2_ストレージ.png)

## RDS
![rds](./images/8-1_RDS.png)
![rds](./images/8-2_RDS_接続とセキュリティ.png)
![rds](./images/8-3_RDS_接続とセキュリティ.png)
![rds](./images/8-4_RDS_インスタンス.png)
![rds](./images/8-5_RDS_インスタンス.png)
![rds](./images/8-6_RDS_サブネットグループ.png)
![rds](./images/8-7_RDS_パラメータグループ.png)
![rds](./images/8-8_RDS_オプショングループ.png)


