# convert the local csv to a map by tf function usually csvdecode used "for" expression
# csvdecode convers entire csv data in to a lis(map) as required.
locals{
    users = csvdecode(file("${path.module}/users_data.csv")) # converts csv into [{first_name = , last_name, department =}]
}