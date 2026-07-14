# creates an iam group
resource "aws_iam_group" "engineers"{
    name = "Engineers"
    path = "/groups/"
}

resource "aws_iam_group" "education"{
    name = "education"
    path = "/groups/"
}

resource "aws_iam_group" "manager"{
    name = "Manager"
    path = "/groups/"
}

resource "aws_iam_group" "accopunting"{
    name = "accountant"
    path = "/groups/"
}
resource "aws_iam_group_membership" "acounting_members"{
    name = "accounting-group-members"
    group = aws_iam_group.accopunting.name
    users = [
        for users in aws_iam_user.user : users.name if users.tags.Department == "Accounting"
    ]
}
# assigns members to that group
resource "aws_iam_group_membership" "education_members"{
    name = "education-groups-memebers"
    group = aws_iam_group.education.name
    users = [
        for users in aws_iam_user.user : users.name if users.tags.Department == "Education"   
    ]
}
resource "aws_iam_group_membership" "engineers_memebers"{
    name = "manager-group-members"
    group = aws_iam_group.manager.name
    users=[
        for users in aws_iam_user.user : users.name if contains(keys(users.tags), "JobTitle") && can(regex("Manager|CEO", users.tags.JobTitle))
    ]
}
resource "aws_iam_group_membership" "engineers"{
    name = "engineer-group-memebrs"
    group = aws_iam_group.engineers.name
    users = [
        for users in aws_iam_user.user : users.name if users.tags.Department == "Engineering"
    ]
}