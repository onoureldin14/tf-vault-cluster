data "aws_arn" "peer" {
  arn = aws_vpc.peer.arn
}
