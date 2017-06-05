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

cmd "Plan the modifications to do and write them in a file" "terraform plan -out=my.plan"

cmd "Apply the previously planned modifications" "terraform apply my.plan"
