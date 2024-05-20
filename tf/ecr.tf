resource "aws_ecr_repository" "quest-challenge" {
  name                 = "quest-challenge"
  image_tag_mutability = "MUTABLE"
}