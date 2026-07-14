output "account_id"{
    value = data.aws_caller_identity.name.account_id
}
output "uses"{
    value = [for users in local.users : "${users.first_name} ${users.last_name}"]
}
output "user_passwords"{
    value ={
        for user, profile in aws_iam_user_login_profile.users : user => "password created - user must reset passwrod on first login"
    }
}