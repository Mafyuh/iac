resource "minio_iam_policy" "postgres_s3" {
  name = "postgres-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::postgres",
          "arn:aws:s3:::postgres/*"
        ]
      }
    ]
  })
}

resource "minio_iam_user_policy_attachment" "postgres_s3" {
  user_name      = minio_iam_user.postgres.name
  policy_name    = minio_iam_policy.postgres_s3.name
  depends_on     = [minio_iam_policy.postgres_s3]
}
