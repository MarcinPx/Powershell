#Script is coping AD groups from user and add this groups to listed logins

$tempgroup = (get-aduser -Identity msmith -Properties memberof).memberof #in the field identity write login of user from who we should to copy ad groups

$users = ("jsmith", "jmurphy" ) # in brackets write logins of users that you want to be members of the groups that previous login have
foreach($temp in $tempgroup){

((Get-ADGroup $temp).name)


    foreach($user in $users){
    
    Add-ADGroupMember -Identity $temp -Member $user
    
    
    }


}
