resource "aws_sqs_queue" "mfa-security-alerts" {
  name                       = "mfa-security-alerts"
  visibility_timeout_seconds = 60
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.mfa-security-alerts-deadletter.arn}\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "mfa-security-alerts-deadletter" {
  name = "mfa-security-alerts-deadletter"
}

# Queue receives messages if a MFA device has been deleted or 
data "aws_iam_policy_document" "mfa-security-alerts" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.mfa-security-alerts.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.mfa-device-deactivated.arn, aws_cloudwatch_event_rule.login-without-mfa.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "mfa-security-alerts" {
  queue_url = aws_sqs_queue.mfa-security-alerts.id
  policy    = data.aws_iam_policy_document.mfa-security-alerts.json
}
