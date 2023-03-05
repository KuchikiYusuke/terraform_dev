# terraform配下
- env
  - dev
  - stg
  - prod
- modules

<br>

# 環境構築
1\. terraform, tfenv, tflintをインストール  
  - 参考
    - [tfenv](https://github.com/tfutils/tfenv)
    - [tflint](https://github.com/terraform-linters/tflint)  

2\. `make env`
  - [参考](https://zoo200.net/terraform-tfenv/)

<br>

# デプロイ
1\. `make dev-init`  
2\. `make dev-plan`

<br>

# フォーマッター
- `make dev-format`
- 別案として、[vscodeプラグイン](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)による自動整形も可能（評価が低いため、入れるのに躊躇。。）

<br>

# terraform管理外のリソース
- パラメータストア
  - https://ap-northeast-1.console.aws.amazon.com/systems-manager/parameters/?region=ap-northeast-1&tab=Table
    - /bgm/dev/database/url のみ、terraform管理
- Route53ドメイン、証明書
  - https://us-east-1.console.aws.amazon.com/route53/home#DomainDetail:sample-kuchiki-openid.com
  - https://ap-northeast-1.console.aws.amazon.com/acm/home?region=ap-northeast-1#/certificates/list
- キーペア
  - https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#KeyPairs:
- ecr
  - https://ap-northeast-1.console.aws.amazon.com/ecr/repositories/private/660721424454/sample-kuchiki?region=ap-northeast-1

# 残タスク
- tfstate管理方法変更
  - 現在は、暫定でS3に保存
    - https://s3.console.aws.amazon.com/s3/buckets/dev-bgm-terraform-state?region=ap-northeast-1&tab=objects
- tflint
- github アクションズによる自動デプロイ
- ecs exec対応
- API Gateway, RDSのcloudwatchログ出力