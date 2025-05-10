newstarters.ps1 - Script is creating/activating AD accounts, mailboxes for listed users from csv(datails of user) file and granting permissions to resources from another csv(AD groups)  
  
Azureexchangegettingmembersofdistributiongroup.ps1 - this script: Is getting list of members from Distribution group on 365 emails with details that are not possible to retrive from GUI/WEB console  

adgroupsbuild.ps1 - this script is GUI, can be used to build list of AD groups that listed people belongs to and matching requiments(query), or to find how many people we have in given department, or to find how many people work with this same title  
  
copingadgroups.ps1 - Script is coping AD groups from user and add this groups to listed logins  

exchangegetstatisticemails.ps1 - This script: generating report with volume of send/recivied emails for given date range per user. By default Exchange message tracking logs have retention policy which is 30 days, so that mean you can back up to 30 days. This can be changed on the server by powershell commands, bear in mind that increasing retention time will increase storage use on the server.  

