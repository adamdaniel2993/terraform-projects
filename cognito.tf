resource "aws_cognito_user_pool" "hygear-cognito" {
  name = "${local.prefix}-pool"
  auto_verified_attributes = ["email"]
  username_attributes = ["email"]

  schema {
    name = "family_name"
    attribute_data_type = "String"
    developer_only_attribute = false
    mutable = false
    required = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
}
 resource "aws_cognito_user_pool_client" "client" {
     name = "nextjs-web"
     user_pool_id = "${aws_cognito_user_pool.hygear-cognito.id}"
     generate_secret = true
     explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
 }