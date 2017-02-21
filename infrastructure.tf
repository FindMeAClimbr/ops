resource "aws_dynamodb_table" "user" {
  name = "user"
  read_capacity = 1
  write_capacity = 1
  hash_key = "email"
  attribute {
    name = "email"
    type = "S"
  }
}

resource "aws_dynamodb_table" "matches" {
  name = "matches"
  read_capacity = 1
  write_capacity = 1
  hash_key = "requester"
  range_key = "date"
  attribute {
    name = "requester"
    type = "S"
  }
  attribute {
    name = "requestee"
    type = "S"
  }
  attribute {
    name = "date"
    type = "N"
  }
  global_secondary_index {
    name = "RequesteeIndex"
    hash_key = "requestee"
    range_key = "date"
    write_capacity = 1
    read_capacity = 1
    projection_type = "ALL"
  }
}

# Now, we need an API to expose those functions publicly
resource "aws_api_gateway_rest_api" "climbr_api" {
  name = "Climbr API"
}

