function cmd() {
  comment=$1
  cmd=$2
  echo -e "\e[36m# $comment\e[39m"
  echo -n -e "\e[93m\$ \e[95m$cmd \e[39m"
  read -p ""
  eval "$cmd"
  read -p ""
}

cmd "export VAULT_ADDR" "export VAULT_ADDR=http://localhost:8200"

cmd "export Vault Root Token for admin" "export VAULT_TOKEN=dz57J7Qz6RZbyxP68an6TD636H6tnRxxg5N6kXmdjp"

cmd "Initialize terraform" "terraform init"

echo -e "\e[36m# Time to get a random secret from the audience!\e[39m"
echo -n "Secret: "
read SECRET
export SECRET

cmd "Write secret to Vault" "vault write secret/terraform secret=$SECRET"

cmd "Plan the modifications to do and write them in a file" "terraform plan -out=my.plan"

cmd "Apply the previously planned modifications" "terraform apply my.plan"
