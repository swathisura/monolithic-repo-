resource "aws_launch_template" "web_server_as" {
    name = "myproject"
    image_id           = "ami-050fd9796aa387c0d"
    vpc_security_group_ids = [aws_security_group.web_server.id]
    instance_type = "t2.micro"
    key_name = "NEW-SG"
    tags = {
        Name = "DevOps"
    }
    
}
   


  resource "aws_elb" "web_server_lb"{
     name = "web-server-lb"
     security_groups = [aws_security_group.web_server.id]
     subnets = ["subnet-05073940de8a837c6", "subnet-0f4e6a41735ba81c1"]
     listener {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
    tags = {
      Name = "terraform-elb"
    }
  }
resource "aws_autoscaling_group" "web_server_asg" {
    name                 = "web-server-asg"
    min_size             = 1
    max_size             = 3
    desired_capacity     = 2
    health_check_type    = "EC2"
    load_balancers       = [aws_elb.web_server_lb.name]
    availability_zones    = ["us-east-1d", "us-east-1a"] 
    launch_template {
        id      = aws_launch_template.web_server_as.id
        version = "$Latest"
      }
    
    
  }

