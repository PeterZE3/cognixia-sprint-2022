# Connect to Bastion Host:

Have working mysql server along with a working bastion host that has the capability to ssh into the sql database. Works well with current network configurations. Did not test load balancer but made a small change to the code in order to remove an error.


1) ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Public-IP>

Connection to SQL Server:
 
2) mysql -h hr-dev-mysql.mysql.database.azure.com -u dbadmin@hr-dev-mysql -p 

3) mysql_db_password = "H@Sh1CoR3!"
