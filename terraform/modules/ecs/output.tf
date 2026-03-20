# Export Cluster name
output "cluster_name" {
  value = aws_ecs_cluster.todo_app_cluster.name
}



# Export Service name
output "service_name" {
  value = aws_ecs_service.todo_app_service.name
}