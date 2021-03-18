  resource "aws_sfn_state_machine" "sample_sfn" {
    definition    = jsonencode(
        {
          Comment = "A Hello World example of the Amazon States Language using Pass states"
          StartAt = "Hello"
          States  = {
            Hello = {
              Next   = "World"
              Result = "Hello"
              Type   = "Pass"
            }
            World = {
              End    = true
              Result = "World"
              Type   = "Pass"
            }
          }
        }
    ) 
    name          = "MyStateMachine" 
    role_arn      = aws_iam_role.sample_sfn_role.arn
    tags          = {

    } 
    type          = "STANDARD" 

    logging_configuration {
      include_execution_data = true 
      level                  = "ALL" 
      log_destination        = format("%s:*", aws_cloudwatch_log_group.sample_log_group.arn)
      #log_destination        = "arn:aws:logs:ap-northeast-1:581057229408:log-group:/aws/vendedlogs/states/MyStateMachine-Logs:*" 
    }
}

resource "aws_cloudwatch_event_rule" "sample_rule" {
  description         = "aa" 
  event_bus_name      = "default"
  is_enabled          = true
  name                = "exec_stepfunctions" 
  schedule_expression = "cron(55 1 * * ? *)" 
  tags                = {} 
}


resource "aws_cloudwatch_event_target" "sample-event-target" {
  arn            = aws_sfn_state_machine.sample_sfn.arn
  event_bus_name = "default" 
  role_arn       = aws_iam_role.sample_event_invoke_role.arn
  rule           = "exec_stepfunctions" 
  depends_on = [
    aws_cloudwatch_event_rule.sample_rule
  ]
}


resource "aws_iam_role" "sample_sfn_role" {
  assume_role_policy    = jsonencode(
      {
        Statement = [
          {
            Action    = "sts:AssumeRole"
            Effect    = "Allow"
            Principal = {
              Service = "states.amazonaws.com"
            }
          },
        ]
        Version   = "2012-10-17"
      }
  )
  force_detach_policies = false 
  managed_policy_arns   = [
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
  ]
  max_session_duration  = 3600 
  name                  = "Sample-Exec-StepFunctions-MyStateMachine-role"
  path                  = "/service-role/"
  tags                  = {

  } 
  inline_policy {

  }
}

resource "aws_iam_role" "sample_event_invoke_role" {
  assume_role_policy    = jsonencode(
      {
        Statement = [
          {
            Action    = "sts:AssumeRole"
            Effect    = "Allow"
            Principal = {
              Service = "events.amazonaws.com"
            }
          },
        ]
        Version   = "2012-10-17"
      }
  ) 
  force_detach_policies = false 
  managed_policy_arns   = [
    "arn:aws:iam::aws:policy/AWSStepFunctionsConsoleFullAccess"
  ] 
  max_session_duration  = 3600 
  name                  = "Sample_Amazon_EventBridge_Invoke_Step_Functions_MyStateMachine" 
  path                  = "/service-role/" 
  tags                  = {

  } 
  inline_policy {

  }
}

resource "aws_cloudwatch_log_group" "sample_log_group" {
  #arn               = "arn:aws:logs:ap-northeast-1:581057229408:log-group:/aws/vendedlogs/states/MyStateMachine-Logs" -> null
  #id                = "/aws/vendedlogs/states/MyStateMachine-Logs" -> null
  name              = "/aws/vendedlogs/states/MyStateMachine-Logs" 
  retention_in_days = 0 
  tags              = {

  } 
}
