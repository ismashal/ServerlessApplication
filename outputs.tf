output "bucket_endpoint" {
  value = aws_s3_bucket.bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.func
}