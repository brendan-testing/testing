resource "aws_sqs_queue" "test-queue" {
  name                       = "test-queue"
}

resource "aws_sqs_queue" "test-queue-2" {
  name                       = "test-queue-2"
}

