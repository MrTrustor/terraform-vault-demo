export AWS_DEFAULT_PROFILE=oxalide
export AWS_PROFILE=oxalide

echo -n "AWS_ACCESS_KEY_ID: "
read ACCESS_KEY

aws iam delete-access-key --access-key-id ${ACCESS_KEY} --user-name hug-meetup
aws iam detach-user-policy --user-name hug-meetup --policy-arn 'arn:aws:iam::%ROOT_ACCOUNT_ID%:policy/hug-meetup-policy'
aws iam delete-user --user-name hug-meetup
aws iam delete-policy --policy-arn "arn:aws:iam::%ROOT_ACCOUNT_ID%:policy/hug-meetup-policy"

export AWS_DEFAULT_PROFILE=perso
export AWS_PROFILE=perso

aws iam detach-role-policy --role-name hug-meetup-target-role --policy-arn 'arn:aws:iam::aws:policy/AmazonEC2FullAccess'
aws iam delete-role --role-name hug-meetup-target-role


docker-compose stop
docker-compose rm
