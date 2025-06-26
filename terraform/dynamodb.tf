resource "aws_dynamodb_table" "vote_table" {
  name         = "VoteTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "candidate"

  attribute {
    name = "candidate"
    type = "S"
  }
}