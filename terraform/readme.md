## Requirements
![asdf](../images/image.png)
No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ./eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |
| <a name="module_vpc_cni_irsa"></a> [vpc\_cni\_irsa](#module\_vpc\_cni\_irsa) | ./iam-sa | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | n/a | `any` | n/a | yes |
| <a name="input_attach_vpc_cni_policy"></a> [attach\_vpc\_cni\_policy](#input\_attach\_vpc\_cni\_policy) | Determines whether to attach the VPC CNI IAM policy to the role | `bool` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | n/a | yes |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | n/a | yes |
| <a name="input_cluster_name_primary"></a> [cluster\_name\_primary](#input\_cluster\_name\_primary) | Primary EKS cluster name | `string` | n/a | yes |
| <a name="input_cluster_security_group_additional_rules"></a> [cluster\_security\_group\_additional\_rules](#input\_cluster\_security\_group\_additional\_rules) | List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source | `any` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.27`) | `string` | n/a | yes |
| <a name="input_coredns_version"></a> [coredns\_version](#input\_coredns\_version) | Kubernetes addons version to use for the EKS cluster (i.e.: `v1.10.1-eksbuild.4`) | `string` | n/a | yes |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled | `bool` | n/a | yes |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Determines whether to create an OpenID Connect Provider for EKS to enable IRSA | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_kube-proxy_version"></a> [kube-proxy\_version](#input\_kube-proxy\_version) | Kubernetes addons version to use for the EKS cluster (i.e.: `v1.27.4-minimal-eksbuild.2`) | `string` | n/a | yes |
| <a name="input_namespace_service_accounts"></a> [namespace\_service\_accounts](#input\_namespace\_service\_accounts) | A list of service accounts associated with namespaces | `any` | n/a | yes |
| <a name="input_node_groups_capacity_type"></a> [node\_groups\_capacity\_type](#input\_node\_groups\_capacity\_type) | eks\_managed\_node\_groups capacity\_type | `string` | n/a | yes |
| <a name="input_node_groups_desired_size"></a> [node\_groups\_desired\_size](#input\_node\_groups\_desired\_size) | eks\_managed\_node\_groups desired\_size | `number` | n/a | yes |
| <a name="input_node_groups_disk_size"></a> [node\_groups\_disk\_size](#input\_node\_groups\_disk\_size) | eks\_managed\_node\_groups disk\_size | `number` | n/a | yes |
| <a name="input_node_groups_instance_types"></a> [node\_groups\_instance\_types](#input\_node\_groups\_instance\_types) | eks\_managed\_node\_groups instance type | `string` | n/a | yes |
| <a name="input_node_groups_max_size"></a> [node\_groups\_max\_size](#input\_node\_groups\_max\_size) | eks\_managed\_node\_groups max\_size | `number` | n/a | yes |
| <a name="input_node_groups_min_size"></a> [node\_groups\_min\_size](#input\_node\_groups\_min\_size) | eks\_managed\_node\_groups min\_size | `number` | n/a | yes |
| <a name="input_node_security_group_additional_rules"></a> [node\_security\_group\_additional\_rules](#input\_node\_security\_group\_additional\_rules) | List of additional security group rules to add to the node security group created. Set `source_cluster_security_group = true` inside rules to set the `cluster_security_group` as source | `any` | n/a | yes |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts` | `any` | `{}` | no |
| <a name="input_resource_availability_zones"></a> [resource\_availability\_zones](#input\_resource\_availability\_zones) | n/a | `list(string)` | n/a | yes |
| <a name="input_role_name_prefix_primary"></a> [role\_name\_prefix\_primary](#input\_role\_name\_prefix\_primary) | IAM role name prefix | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "Environment": ""<br>}</pre> | no |
| <a name="input_vpc_cni_enable_ipv6"></a> [vpc\_cni\_enable\_ipv6](#input\_vpc\_cni\_enable\_ipv6) | Determines whether to enable IPv6 permissions for VPC CNI policy | `bool` | n/a | yes |
| <a name="input_vpc_cni_version"></a> [vpc\_cni\_version](#input\_vpc\_cni\_version) | Kubernetes addons version to use for the EKS cluster (i.e.: `v1.15.0-eksbuild.2`) | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `any` | n/a | yes |
| <a name="input_vpc_network_cidr"></a> [vpc\_network\_cidr](#input\_vpc\_network\_cidr) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
