# All Resources Were Able to Deploy to the Azure Infrastructure using the terraform code configured.

Have working mysql server along with a working bastion host that has the capability to ssh into the sql database. Works well with current network configurations. Did not test load balancer but made a small change to the code in order to remove an error. I am unable to directly connect to the Wordpress Vm as of yet, so I cannot confirm whether or not the wordpress image succcessfully installed. I also cannot determine whether or not the Wordpress VM is able to successfully connect to the MySQL Database or to the Storage account. 

# Connect to Bastion Host:

1) ssh -i ssh-keys/terraform-azure.pem azureuser@Bastion-Public-IP

 <b>  Connection to SQL Server: </b> </br>
 
2) mysql -h [DATABASE-HOST-SERVER.COM] -u [dbadmin@MY-SQL-PUBLICIP] -p 

3) mysql_db_password = "H@Sh1CoR3!"




<b> DATABASE INFO </b> </br>

mysql_db_name = "mysql" </br>
mysql_db_username = "dbadmin" </br>
mysql_db_schema = "wordpressdb" </br>
mysql_db_password = "H@Sh1CoR3!"


# Deliverables

URL for the Wordpress website

http://app1-vm.centralus.cloudapp.azure.com/wordpress/

Github repository with all the code and manifest files.

https://github.com/PeterZE3/cognixia-sprint-2022

A screenshot of JIRA roadmap.

![image](https://user-images.githubusercontent.com/103215360/172719244-b9681d24-4cde-4736-b280-995b84be2fce.png)

Recording of the Sprint demo where each developer will demo what he/she worked on during the Sprint.

https://youtu.be/l3ktv9Uc7vU

Recording of the retrospective meeting at the end of the sprint.

https://youtu.be/qpe1IMTeaT0
