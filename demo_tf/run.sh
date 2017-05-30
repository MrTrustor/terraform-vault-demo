function cmd() {
  comment=$1
  cmd=$2
  echo -e "\e[36m# $comment\e[39m"
  echo -n -e "\e[93m\$ \e[95m$cmd \e[39m"
  read -p ""
  eval "$cmd"
  read -p ""
}


cmd "Initialize terraform" "terraform init"

cmd "Terraform plan" "terraform plan -out=my.plan"

cmd "Terraform apply" "terraform apply my.plan"
