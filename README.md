## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.47 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acm\_certificate\_arn | Existing ACM Certificate ARN | `string` | `""` | no |
| aliases | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront. | `list(string)` | `[]` | no |
| comment | Any comment about the CloudFront Distribution | `string` | `"Built by Terraform"` | no |
| dynamic\_custom\_origin\_config | Configuration for the custom origin config to be used in dynamic block | `any` | `[]` | no |
| dynamic\_default\_cache\_behavior | Default Cache Behviors to be used in dynamic block | `any` | n/a | yes |
| dynamic\_ordered\_cache\_behavior | Ordered Cache Behaviors to be used in dynamic block | `any` | `[]` | no |
| dynamic\_s3\_origin\_config | Configuration for the s3 origin config to be used in dynamic block | `list(map(string))` | `[]` | no |
| env\_name | The name of the env | `string` | n/a | yes |
| geo\_restriction\_locations | List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | `list(string)` | `[]` | no |
| geo\_restriction\_type | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | `string` | `"none"` | no |
| ipv6\_enabled | Set to true to enable an AAAA DNS record to be set as well as the A record | `bool` | `true` | no |
| log\_expiration\_days | Number of days after which to expunge the objects | `number` | `90` | no |
| log\_include\_cookies | Include cookies in access logs | `bool` | `false` | no |
| log\_prefix | Path of logs in S3 bucket | `string` | `""` | no |
| logging\_enabled | When true, access logs will be sent to a newly created s3 bucket | `bool` | `true` | no |
| minimum\_protocol\_version | Cloudfront TLS minimum protocol version | `string` | `"TLSv1.1"` | no |
| name | Name of the deploy(e.g. main or app) | `string` | n/a | yes |
| price\_class | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | `string` | `"PriceClass_100"` | no |
| retain\_on\_delete | (Optional) - Disables the distribution instead of deleting it when destroying the resource through Terraform | `bool` | `false` | no |
| s3\_logs\_acl | The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| s3\_logs\_policy | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy | `string` | `""` | no |
| s3\_logs\_region | If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee | `string` | `""` | no |
| wait\_for\_deployment | If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_arn | ARN of AWS CloudFront distribution |
| cloudfront\_domain\_name | Domain name corresponding to the distribution |
| cloudfront\_etag | Current version of the distribution's information |
| cloudfront\_hosted\_zone\_id | CloudFront Route 53 zone ID |
| cloudfront\_id | ID of AWS CloudFront distribution |
| cloudfront\_status | Current status of the distribution |
| cloudfront\_viewer\_certificate | CloudFront viewer certificate of the distribution |
