resource "aws_ecs_cluster" "main_cluster" {
  name = "main-cluster"
}

resource "aws_ecs_task_definition" "main_task_definition" {
  family                   = "main-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "main-container"
      image     = "${aws_ecr_repository.quest_challenge.repository_url}:${var.commit_sha}"
      essential = true
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "main" {
  name            = "main-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.main_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.ecs_security_group.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main_lb_target_group.arn
    container_name   = "main-container"
    container_port   = var.port
  }
}
