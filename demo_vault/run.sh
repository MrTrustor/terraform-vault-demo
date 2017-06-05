function cmd() {
  comment=$1
  cmd=$2
  echo -e "\e[36m# $comment\e[39m"
  echo -n -e "\e[93m\$ \e[95m$cmd \e[39m"
  read -p ""
  eval "$cmd"
  read -p ""
}

cmd "Launch Vault in dev mod" "docker-compose up -d"

cmd "export VAULT_ADDR" "export VAULT_ADDR=http://localhost:8200"

cmd "export Vault Root Token for admin" "export VAULT_TOKEN=dz57J7Qz6RZbyxP68an6TD636H6tnRxxg5N6kXmdjp"

cmd "Verify if everything is OK" "vault status; vault token-lookup"

cmd "Create new admin policy" "cat admin.hcl; vault policy-write admin admin.hcl"

cmd "Create new user policy" "cat acl.hcl; vault policy-write hug acl.hcl"

cmd "Enable user/password authentication" "vault auth-enable userpass; vault auth -methods"

cmd "Create new admin user" "vault write auth/userpass/users/mrtrustor password=hellohug policies=admin"

cmd "Remove Root token from environement" "unset VAULT_TOKEN"

cmd "Authenticate as newly created user" "vault auth -method=userpass username=mrtrustor"

cmd "Verify if everything is OK" "vault status; vault token-lookup"

cmd "Write some stuff in vault" "vault write secret/toto test=toto; vault write secret/foo test=foo; vault write secret/bar test=bar"

cmd "Create new user associated with new policy" "vault write auth/userpass/users/testuser password=hellohug policies=hug"

cmd "Login as new user" "vault auth -method=userpass username=testuser"

cmd "Test policy 1" "vault read secret/toto; vault write secret/toto test=nottoto; vault read secret/toto"

cmd "Test policy 2" "vault read secret/foo; vault write secret/foo test=notfoo; vault read secret/foo"

cmd "Test policy 3" "vault read secret/bar"
