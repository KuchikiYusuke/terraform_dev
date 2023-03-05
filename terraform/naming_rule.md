# AWS 命名規則

## 命名規則を統一する理由

以下の状態を避けるためである。

- 各リソースの役割がわかりにくい
  - オペレーションミスが発生しやすい
  - ソース削除などの判断が難しくなる
- 見栄えが悪い
  - 設定ミスに気づきにくくなる
  - リソースを見つけるのに無駄な時間が生じる
  - チームで管理する際にミスが生じる

## リソース名から知りたいこと

対象のリソースによっても異なるが、共通で知りたいものは以下の２つ。

1. 対象システム
2. 環境 (本番、検証、開発)

また、これら以外に知りたい情報は、リソースによって異なる。
たとえば、以下のようなことが考えられる。

- Subnet, RouteTable
  - ネットワークレイヤー (パブリック、プロテクト、プライベートなど)
- EC2、IAMRole、ECS
  - 種別 (アプリケーションサーバー、踏み台サーバー、メールサーバー、バッチサーバーなど)
- S3
  - 目的 (ログ保管用、静的コンテンツ配信用、データ保管用など)

これらの情報をわかりやすく表現するために、ケバブケースによりAWSリソースの名前を決める。

## 命名規則と命名規則表

- 対象システムの名前 (sysname)
  - システムで一意となる識別子
- 環境 (env)
  - 本番、検証、開発など (prod/stg/dev)
- ネットワークレイヤー (nlayer)
  - パブリック、プロテクト、プライベートなど (public/protected/private)
- 種別 (type)
  - アプリケーションサーバー、踏み台サーバー、メールサーバ、バッチサーバーなど(app/bastion/mail/batch)
- 目的 (use)
  - ログ保管用、静的コンテンツ配信用、データ保管用など (log/contents/data)

| AWSリソース     | 命名規則                           | 備考                                               |
| :-------------- | :--------------------------------- | :------------------------------------------------- |
| VPC             | {env}-{system}-vpc                |                                                    |
| Subnet          | {env}-{system}-{nlayer}-subnetXX  | XXは連番、AZ毎に分ける                             |
| RouteTable      | {env}-{system}-{nlayer}-rtb       |                                                    |
| InternetGateway | {env}-{system}-igw                |                                                    |
| ELB             | {env}-{system}-alb/clb            |                                                    |
| TargetGroup     | {env}-{system}-tg                 |                                                    |
| EC2             | {env}-{system}-{type}XX           | XXは連番、AZ毎に分ける                             |
| IAMRole         | {env}-{system}-{type}-role        |                                                    |
| SecurityGroup   | {env}-{system}-{resource}-sg          |                                                    |
| RDS             | {env}-{system}-rds                |                                                    |
| S3              | {env}-{system}-{use}-{AccountID}  | 名前を一意にする必要があるためアカウント番号を付与 |
| ECS Cluster     | {env}-{system}-{type}-ecs-cluster |                                                    |
| ECS Task        | {env}-{system}-{type}-ecs-task    |                                                    |
| ECR             | {env}-{system}-{type}-ecr         |                                                    |
