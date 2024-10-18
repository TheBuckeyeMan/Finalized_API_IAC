data "aws_ecr_image" "latest_image" {
  repository_name = "youtube-containers"
  image_tag       = "deleteapi"
}

data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role_for_s3_access" #Name of the iam role that gives your lambda permissions
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "deleteapi-lambda"
  role          = data.aws_iam_role.existing_lambda_role.arn

  package_type = "Image"
  image_uri    = "${data.aws_ecr_image.latest_image.image_uri}"

  environment {
    variables = {
      Api_Key = var.Api_Key 
    }
  }

  timeout = 30 #Adjust the timeout of the function IN SECONDS
  memory_size = 512 #Adjust the Memory of the function
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name #Gives the AWS Lambda function a URL for us to trigger
  authorization_type = "NONE"
}

##Add in additional code for AWS Event bridge, or API Gateway here for Lambda Deployment

//GPT SAID TO TRIGGER 1 time per day
# resource "aws_cloudwatch_event_rule" "daily_trigger" {
#   name                = "daily-lambda-trigger"
#   schedule_expression = "rate(1 day)"  # Runs once per day
# }

# resource "aws_cloudwatch_event_target" "lambda_target" {
#   rule      = aws_cloudwatch_event_rule.daily_trigger.name
#   target_id = "deleteapi-lambda"
#   arn       = aws_lambda_function.api_lambda.arn
# }

# resource "aws_lambda_permission" "allow_eventbridge_to_invoke_lambda" {
#   statement_id  = "AllowExecutionFromEventBridge"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.api_lambda.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn
# }