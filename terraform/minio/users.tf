resource "minio_iam_user" "terraform" {
  name = "terraform"
}

resource "minio_iam_user" "postgres" {
  name = "postgres"
}
