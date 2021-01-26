#################
# Identity Pool #
#################

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${var.app_name}-${var.environment}"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.web.id
    provider_name           = "cognito-idp.${data.aws_region.current.id}.amazonaws.com/${aws_cognito_user_pool.main.id}"
    server_side_token_check = false
  }

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.main.id

  roles = {
    "authenticated"   = aws_iam_role.cognito_authenticated.arn
    "unauthenticated" = aws_iam_role.cognito_unauthenticated.arn
  }
}

resource "aws_cognito_identity_provider" "google" {
  count         = contains(var.enabled_providers, "Google") ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.main.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "profile email openid"
    client_id        = var.google_client_id
    client_secret    = var.google_client_secret

    token_url                     = "https://www.googleapis.com/oauth2/v4/token"
    token_request_method          = "POST"
    oidc_issuer                   = "https://accounts.google.com"
    authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
    attributes_url_add_attributes = "true"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

resource "aws_cognito_identity_provider" "facebook" {
  count         = contains(var.enabled_providers, "Facebook") ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.main.id
  provider_name = "Facebook"
  provider_type = "Facebook"

  provider_details = {
    authorize_scopes = "public_profile, email"
    client_id        = var.facebook_client_id
    client_secret    = var.facebook_client_secret

    token_url                     = "https://graph.facebook.com/v6.0/oauth/access_token"
    token_request_method          = "GET"
    authorize_url                 = "https://www.facebook.com/v6.0/dialog/oauth"
    attributes_url                = "https://graph.facebook.com/v6.0/me?fields="
    attributes_url_add_attributes = "true"
  }

  attribute_mapping = {
    email    = "email"
    username = "id"
  }
}

#############
# User Pool #
#############

resource "aws_cognito_user_pool" "main" {
  name = "${var.app_name}-${var.environment}"

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "${var.app_name}: Your verification code is {####}"
    email_subject        = "${var.app_name} Verification Code"
    sms_message          = "${var.app_name}: Your verification code is {####}"
  }
  mfa_configuration        = var.enable_mfa ? "ON" : "OFF"
  auto_verified_attributes = var.username_attributes

  dynamic "lambda_config" {
    for_each = var.post_confirmation_lambda_arn == "" ? [] : [1]
    content {
      post_confirmation = var.post_confirmation_lambda_arn
    }
  }

  schema {
    attribute_data_type = "String"
    name                = "id"
    required            = false
    mutable             = true

    string_attribute_constraints {
      min_length = 36
      max_length = 36
    }
  }

  password_policy {
    minimum_length                   = 10
    require_uppercase                = true
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = false
    temporary_password_validity_days = 7
  }

  sms_configuration {
    external_id    = var.cognito_role_external_id
    sns_caller_arn = aws_iam_role.cognito_sns_role.arn
  }

  admin_create_user_config {
    allow_admin_create_user_only = false

    invite_message_template {
      sms_message   = "${var.app_name} Invitation. USR: {username} Temp. PWD: {####} "
      email_subject = "${var.app_name} Invitation"

      email_message = <<EOF
You have been added to ${var.app_name}
Username: {username}
Temporary Password: {####}
You will be asked to change your password after first logging in.
EOF
    }
  }

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

###############
# User Groups #
###############

resource "aws_cognito_user_group" "manager" {
  for_each = var.user_groups

  name         = each.key
  user_pool_id = aws_cognito_user_pool.main.id
  description  = "${each.key} group"
}

###########
# Clients #
###########

resource "aws_cognito_user_pool_client" "web" {
  name         = "${var.app_name}-${var.environment}-client-web"
  user_pool_id = aws_cognito_user_pool.main.id

  read_attributes = ["custom:id"]

  supported_identity_providers         = var.enabled_providers
  allowed_oauth_flows_user_pool_client = length(var.enabled_providers) > 0
  allowed_oauth_flows                  = length(var.enabled_providers) > 0 ? ["code"] : null
  allowed_oauth_scopes                 = length(var.enabled_providers) > 0 ? ["email", "openid", "profile"] : null
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls

  depends_on = [aws_cognito_identity_provider.google, aws_cognito_identity_provider.facebook]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${replace(var.app_name, "_", "-")}-${var.environment}"
  user_pool_id = aws_cognito_user_pool.main.id
}

# This client allow us to enable machine-to-machine authentication (client_credentials OAuth workflow)
# https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-app-idp-settings.html
# https://aws-blog.de/2020/01/machine-to-machine-authentication-with-cognito-and-serverless.html
# https://docs.aws.amazon.com/cognito/latest/developerguide/token-endpoint.html

//Uncomment to enable machine-to-machine authentication
//resource "aws_cognito_user_pool_client" "api" {
//  name         = "${var.app_name}-${var.environment}-client-api"
//  user_pool_id = aws_cognito_user_pool.main.id
//
//  generate_secret                      = true
//  allowed_oauth_flows_user_pool_client = true
//  allowed_oauth_flows                  = ["client_credentials"]
//  allowed_oauth_scopes                 = ["${var.app_name}-${var.environment}/API_ACCESS"]
//}
//
//
//Uncomment to enable machine-to-machine authentication
//resource "aws_cognito_resource_server" "resource" {
//  identifier = "${var.app_name}-${var.environment}"
//  name       = "${var.app_name}-${var.environment}"
//
//  scope {
//    scope_name        = "API_ACCESS"
//    scope_description = "API access"
//  }
//
//  user_pool_id = aws_cognito_user_pool.main.id
//}

#######
# IAM #
#######

resource "aws_iam_role" "cognito_authenticated" {
  name = "${var.app_name}-${var.environment}-cognito-authenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF

  tags = {
    Application = var.app_name
    Environment = var.environment
    Service     = "cognito"
  }
}

resource "aws_iam_role" "cognito_unauthenticated" {
  name = "${var.app_name}-${var.environment}-cognito-unauthenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF

  tags = {
    Application = var.app_name
    Environment = var.environment
    Service     = "cognito"
  }
}

resource "aws_iam_role" "cognito_sns_role" {
  name = "${var.app_name}-${var.environment}-cognito-sns-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cognito-idp.amazonaws.com"
      },
      "Condition": {
        "StringEquals": {"sts:ExternalId": "${var.cognito_role_external_id}"}
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Application = var.app_name
    Environment = var.environment
    Service     = "cognito"
  }
}

resource "aws_iam_policy" "cognito_sns_role" {
  name        = "${var.app_name}-${var.environment}-cognito-sns-policy"
  description = "${var.app_name}-${var.environment} Cognito allow SNS publish"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "cognito_sns_role" {
  name       = "${var.app_name}-${var.environment}-cognito-sns-role-policy"
  roles      = [aws_iam_role.cognito_sns_role.name]
  policy_arn = aws_iam_policy.cognito_sns_role.arn
}