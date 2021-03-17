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
    role_arn      = "arn:aws:iam::581057229408:role/service-role/StepFunctions-MyStateMachine-role-a7396e26" 
    tags          = {} 
    type          = "STANDARD" 

    logging_configuration {
      include_execution_data = true 
      level                  = "ALL" 
      log_destination        = "arn:aws:logs:ap-northeast-1:581057229408:log-group:/aws/vendedlogs/states/MyStateMachine-Logs:*" 
    }
}

resource "aws_cloudwatch_event_rule" "sample_rule" {
  description         = "aa" 
  event_bus_name      = "default"
  is_enabled          = true 
  name                = "exec_stepfunctions" 
  schedule_expression = "cron(13 16 * * ? *)" 
  tags                = {} 
}


resource "aws_cloudwatch_event_target" "sample-event-target" {
  arn            = aws_sfn_state_machine.sample_sfn.arn
  event_bus_name = "default" 
  role_arn       = "arn:aws:iam::581057229408:role/service-role/Amazon_EventBridge_Invoke_Step_Functions_780854943"
  rule           = "exec_stepfunctions" 
  #target_id      = "Id2b6017c2-9109-4832-b977-d0f23f6b4204" 
  depends_on = [
    aws_cloudwatch_event_rule.sample_rule
  ]
}

