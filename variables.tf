variable "s3_name" {
    type = string
    default = "terraform-backend-iti"
}

variable "dynamodb_table_name" {
    type = string
    default = "terraform_state"
}