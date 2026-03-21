[
    {
      "name": "${name}",
      "image": "${image}:latest",
      "cpu": 256,
      "memory":512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${container_port},
          "hostPort": ${container_port},
          "protocol": "tcp"
        }
      ],

      "healthCheck": {
        "command": [
          "CMD-SHELL",
          "curl -f http://localhost:${container_port}/health || exit 1"
        ],
        "interval": 30,
        "timeout": 5,
        "retries": 3,
        "startPeriod": 60
      },
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
            "awslogs-group": "/ecs/${name}",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "ecs"
            }
        }
    }
]
