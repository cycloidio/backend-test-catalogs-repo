variable "chamber_name" {
   description = "Chamber Name"
}

variable "datadog_api_key_arn" {
    description = "Datadog API key secret ARN"
}

variable "datadog_app_key_arn" {
    description = "Datadog APP key secret ARN"
}

variable "vpc_id" {
  type = string
}

variable "private_dns_name" {
  type = string
}

