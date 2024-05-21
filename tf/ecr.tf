resource "aws_ecr_repository" "quest_challenge" {
  name                 = "quest-challenge"
  image_tag_mutability = "MUTABLE"
}