function cmd() {
  comment=$1
  cmd=$2
  echo -e "\e[36m# $comment\e[39m"
  echo -n -e "\e[93m\$ \e[95m$cmd \e[39m"
  read -p ""
  eval "$cmd"
  read -p ""
}

echo "=> Check that Docker VM has the right date! <="

cmd "Launch Vault in dev mod" "docker-compose up -d"

cmd "export VAULT_ADDR" "export VAULT_ADDR=http://localhost:8200"

cmd "export Vault Root Token for admin" "export VAULT_TOKEN=dz57J7Qz6RZbyxP68an6TD636H6tnRxxg5N6kXmdjp"

cmd "Create IAM user for Vault" "aws iam create-user --user-name hug-meetup"

cmd "Create IAM credentials for Vault" "aws iam create-access-key --user-name hug-meetup; sleep 7"

cmd "Create role in target AWS account" "cat ./target_account_role.json; AWS_DEFAULT_PROFILE=perso aws iam create-role --role-name hug-meetup-target-role --assume-role-policy-document file://target_account_role.json"

cmd "Give permissions to the target role" "AWS_DEFAULT_PROFILE=perso aws iam attach-role-policy --role-name hug-meetup-target-role --policy-arn 'arn:aws:iam::aws:policy/AmazonEC2FullAccess'"

cmd "Allow Vault IAM user to assume target role" "cat ./root_account_policy.json; aws iam create-policy --policy-name hug-meetup-policy --policy-document file://root_account_policy.json; aws iam attach-user-policy --user-name hug-meetup --policy-arn 'arn:aws:iam::%ROOT_ACCOUNT_ID%:policy/hug-meetup-policy'"

cmd "Activate AWS Secret Backend in Vault" "vault mount aws"

echo -n "Vault access key id: "
read ACCESS_KEY
echo -n "Vault secret key: "
read SECRET_KEY

cmd "Give credentials to vault" "vault write aws/config/root access_key=$ACCESS_KEY secret_key=$SECRET_KEY region=eu-west-2"

cmd "Create Vault role" "vault write aws/roles/hug arn=arn:aws:iam::%TARGET_ACCOUNT_ID%:role/hug-meetup-target-role"

cmd "Test - 1" "vault read aws/sts/hug"

cmd "Test - 2" "vault read aws/sts/hug"

echo -n "Test access key id: "
read AWS_ACCESS_KEY_ID
echo -n "Test secret key: "
read AWS_SECRET_ACCESS_KEY
echo -n "Test session token: "
read AWS_SESSION_TOKEN

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN

cmd "Test auth" "aws sts get-caller-identity"
