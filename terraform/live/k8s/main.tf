module "k8s" {
  source = "../../modules/k8s"

  region       = "us-east-1"
  cluster_name = "eks-cluster"
}
