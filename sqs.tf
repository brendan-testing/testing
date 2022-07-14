resource "aws_sqs_queue" "test-queue" {
  name                       = "test-queue"
}

resource "aws_sqs_queue" "test-queue2" {
  name                       = "test-queue2"
}
