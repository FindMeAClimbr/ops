// API Gateway

// /auth
resource "aws_api_gateway_resource" "Auth" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${var.aws_api_gateway_resource_parent}"
  path_part = "auth"
}

// /signup
resource "aws_api_gateway_resource" "Signup" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${aws_api_gateway_resource.Auth.id}"
  path_part = "signup"
}

// /login
resource "aws_api_gateway_resource" "Login" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${aws_api_gateway_resource.Auth.id}"
  path_part = "login"
}

// /changePassword
resource "aws_api_gateway_resource" "ChangePassword" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${aws_api_gateway_resource.Auth.id}"
  path_part = "changePassword"
}

// /lostPassword
resource "aws_api_gateway_resource" "LostPassword" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${aws_api_gateway_resource.Auth.id}"
  path_part = "lostPassword"
}

// /resetPassword
resource "aws_api_gateway_resource" "ResetPassword" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${aws_api_gateway_resource.Auth.id}"
  path_part = "resetPassword"
}

// /verifyUser
resource "aws_api_gateway_resource" "VerifyUser" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  parent_id = "${aws_api_gateway_resource.Auth.id}"
  path_part = "verifyUser"
}

// /Signup OPTIONS
module "signupOptionsCORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "${aws_api_gateway_resource.Signup.path}"
  resource_id = "${aws_api_gateway_resource.Signup.id}"
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
}

// /signup POST
resource "aws_api_gateway_method" "signup-POST" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Signup.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "Auth-createUser-integration" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Signup.id}"
  http_method = "${aws_api_gateway_method.signup-POST.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.createUser.arn}/invocations"
  integration_http_method = "POST"
//  request_templates = {                  # Not documented
//    "application/json" = "${file("${path.module}/templates/Auth-createUser-integration.template")}"
//  }
}

resource "aws_api_gateway_method_response" "signup-POST-200" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Signup.id}"
  http_method = "${aws_api_gateway_method.signup-POST.http_method}"
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "signup-POST-Integration-Response" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Signup.id}"
  http_method = "${aws_api_gateway_method.signup-POST.http_method}"
  status_code = "${aws_api_gateway_method_response.signup-POST-200.status_code}"
}


// /login OPTIONS
module "loginOptionsCORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "${aws_api_gateway_resource.Login.path}"
  resource_id = "${aws_api_gateway_resource.Login.id}"
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
}

// /login POST
resource "aws_api_gateway_method" "login-POST" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Login.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "Auth-login-integration" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Login.id}"
  http_method = "${aws_api_gateway_method.login-POST.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.login.arn}/invocations"
  integration_http_method = "POST"
//  request_templates = {                  # Not documented
//    "application/json" = "${file("${path.module}/templates/Auth-login-integration.template")}"
//  }
}

resource "aws_api_gateway_method_response" "login-POST-200" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Login.id}"
  http_method = "${aws_api_gateway_method.login-POST.http_method}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "login-POST-Integration-Response" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.Login.id}"
  http_method = "${aws_api_gateway_method.login-POST.http_method}"
  status_code = "${aws_api_gateway_method_response.login-POST-200.status_code}"
}

// /changePassword OPTIONS
module "changePasswordOptionsCORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "${aws_api_gateway_resource.ChangePassword.path}"
  resource_id = "${aws_api_gateway_resource.ChangePassword.id}"
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
}

// /changePassword POST
resource "aws_api_gateway_method" "changePassword-POST" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ChangePassword.id}"
  http_method = "POST"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "Auth-changePassword-integration" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ChangePassword.id}"
  http_method = "${aws_api_gateway_method.changePassword-POST.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.changePassword.arn}/invocations"
  integration_http_method = "POST"
//  request_templates = {                  # Not documented
//    "application/json" = "${file("${path.module}/templates/Auth-changePassword-integration.template")}"
//  }
}

resource "aws_api_gateway_method_response" "changePassword-POST-200" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ChangePassword.id}"
  http_method = "${aws_api_gateway_method.changePassword-POST.http_method}"
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "changePassword-POST-Integration-Response" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ChangePassword.id}"
  http_method = "${aws_api_gateway_method.changePassword-POST.http_method}"
  status_code = "${aws_api_gateway_method_response.changePassword-POST-200.status_code}"
}

// /lostPassword OPTIONS
module "lostPasswordOptionsCORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "${aws_api_gateway_resource.LostPassword.path}"
  resource_id = "${aws_api_gateway_resource.LostPassword.id}"
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
}

// /lostPassword POST
resource "aws_api_gateway_method" "lostPassword-POST" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.LostPassword.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "Auth-lostPassword-integration" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.LostPassword.id}"
  http_method = "${aws_api_gateway_method.lostPassword-POST.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lostPassword.arn}/invocations"
  integration_http_method = "POST"
//  request_templates = {                  # Not documented
//    "application/json" = "${file("${path.module}/templates/Auth-lostPassword-integration.template")}"
//  }
}

resource "aws_api_gateway_method_response" "lostPassword-POST-200" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.LostPassword.id}"
  http_method = "${aws_api_gateway_method.lostPassword-POST.http_method}"
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "lostPassword-POST-Integration-Response" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.LostPassword.id}"
  http_method = "${aws_api_gateway_method.lostPassword-POST.http_method}"
  status_code = "${aws_api_gateway_method_response.lostPassword-POST-200.status_code}"
}

// /resetPassword OPTIONS
module "resetPasswordOptionsCORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "${aws_api_gateway_resource.ResetPassword.path}"
  resource_id = "${aws_api_gateway_resource.ResetPassword.id}"
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
}

// /resetPassword POST
resource "aws_api_gateway_method" "resetPassword-POST" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ResetPassword.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "Auth-resetPassword-integration" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ResetPassword.id}"
  http_method = "${aws_api_gateway_method.resetPassword-POST.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.resetPassword.arn}/invocations"
  integration_http_method = "POST"
//  request_templates = {                  # Not documented
//    "application/json" = "${file("${path.module}/templates/Auth-resetPassword-integration.template")}"
//  }
}

resource "aws_api_gateway_method_response" "resetPassword-POST-200" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ResetPassword.id}"
  http_method = "${aws_api_gateway_method.resetPassword-POST.http_method}"
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "resetPassword-POST-Integration-Response" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.ResetPassword.id}"
  http_method = "${aws_api_gateway_method.resetPassword-POST.http_method}"
  status_code = "${aws_api_gateway_method_response.resetPassword-POST-200.status_code}"
}

// /verifyUser OPTIONS
module "verifyUserOptionsCORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "${aws_api_gateway_resource.VerifyUser.path}"
  resource_id = "${aws_api_gateway_resource.VerifyUser.id}"
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
}

// /verifyUser POST
resource "aws_api_gateway_method" "verifyUser-POST" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.VerifyUser.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "Auth-verifyUser-integration" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.VerifyUser.id}"
  http_method = "${aws_api_gateway_method.verifyUser-POST.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.verifyUser.arn}/invocations"
  integration_http_method = "POST"
//  request_templates = {                  # Not documented
//    "application/json" = "${file("${path.module}/templates/Auth-verifyUser-integration.template")}"
//  }
}

resource "aws_api_gateway_method_response" "verifyUser-POST-200" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.VerifyUser.id}"
  http_method = "${aws_api_gateway_method.verifyUser-POST.http_method}"
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "verifyUser-POST-Integration-Response" {
  rest_api_id = "${var.aws_api_gateway_rest_api_id}"
  resource_id = "${aws_api_gateway_resource.VerifyUser.id}"
  http_method = "${aws_api_gateway_method.verifyUser-POST.http_method}"
  status_code = "${aws_api_gateway_method_response.verifyUser-POST-200.status_code}"
}