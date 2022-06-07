# Connect to Bastion Host:

Have working mysql server along with a working bastion host that has the capability to ssh into the sql database. Works well with current network configurations. Did not test load balancer but made a small change to the code in order to remove an error.


1) ssh -i ssh-keys/terraform-azure.pem azureuser@Bastion-Public-IP

 <b>  Connection to SQL Server: </br>
 
2) mysql -h [DATABASE-HOST-SERVER.COM] -u [dbadmin@MY-SQL-PUBLICIP] -p 

3) mysql_db_password = "H@Sh1CoR3!"




DATABASE INFO</br>

mysql_db_name = "mysql"
mysql_db_username = "dbadmin"
mysql_db_schema = "wordpressdb"
mysql_db_password = "H@Sh1CoR3!"
