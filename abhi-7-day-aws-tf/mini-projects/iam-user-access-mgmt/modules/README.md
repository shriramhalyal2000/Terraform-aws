This mini project create iam users in bulk, cerates csv files for secrete key and secret access key for iam login.
thi sterraform stores statefile in s3 bucket in remote backend, and created iam users are ssigned perms accoring to placed group persm attached to them, and users are assigned to group dynamicaaly

Next steps:
     add iam policies
     enable mfa

    setup sso
    add mkore attributes
    alternate onboardings integrate wiht hr services

    This whole iam users are created from csv files



Use the locals and tf fucntion and meta arguments to break apart the csv file values into rows of iteratable data 
then break them further apart by "," ";" to extract data from csv to tf readable format of map

extract the user account(root/admin) and create user group and users , by for_each iterate by locals to create iam users and groups


there exists a csv file of first name, last name, department, job title of 20+ entries.

decoding that file with variable in local using csvdecode() in tf built in fucntion to map(strings)
so we can iterate it if we want users to be populated with those data and respective fields.

resource- aws_iam_user created with local.users refernce those 20+ data entries populated with resource attributes of user name.

then create login profile for those users

for_each and for experssion used heavily

create user group and assign those group users by resource user_group_membership