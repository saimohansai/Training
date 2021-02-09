resource "aws_ebs_volume" "testing" {
  availability_zone = "us-east-1a"
  size = 5

  #this optional we can declader IOPS
/*
  //type = "Optional" //
  General Purpose SSD (gp2) :- only size (like 5 GB 10 GB)
  General Purpose SSD (gp3) :-  we can menction IOPS with size of volume

example:-
  type = General Purpose SSD (gp2)
  iops= 3000
 #*/

  tags = {
    Name= "testing public"
  }

}
resource "aws_volume_attachment" "my-volume" {
  device_name =  "/dev/sdh"
  instance_id = aws_instance.public.id
  volume_id = aws_ebs_volume.testing.id

}