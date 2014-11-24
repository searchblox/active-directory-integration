active-directory-integration
============================

SearchBlox file system collection search results can be integrated with Active Directory for secure search results based on user groups. 

In order to setup Active Directory authentication & authorization in SearchBlox, one simply needs to edit shiro.ini file inside the project before launching SearchBlox. Please refer to the following list of properties to edit in **shiro.ini**: 

1. One should specify **contextFactory.url** property value which is URL of **Active Directory** Server for accessing using LDAP e.g.  
*contextFactory.url = ldap://192.168.1.12:389*

2. Username & password of **Active Directory** Server **user** should be specified (this can be either administrator user or regular user who has access to other directories in **AD Server**), e.g.  
*contextFactory.systemUsername = john.doe@company.com*  
*contextFactory.systemPassword = johnspass*

3. LDAP query for searching & authenticating users should be specified as **realm.searchBase** parameter. For example, if domain name is **company.com** and users are stored in directory with common name **Computers**, then this parameter should be set like:  
*realm.searchBase = "CN=Computers,DC=company,DC=com"*

4. In order to filter search results by logged in AD user’s folder permissions, one should specify **realm.groupRolesMap** parameter using following format:  
*realm.groupRolesMap = <group1­ldap­query>:<group1­role>,<group2­ldap­query>:<group2­role>, ...*  
So for instance there are 2 Active Directory groups of users located in directory **Computers** and named **SearchBloxGroup1** and **SearchBloxGroup2**. In this case property should have following setting (should be single­line):  
*realm.groupRolesMap = "CN=SearchBloxGroup1,CN=Computers,DC=company,DC=com":"companySearchBloxGroup1_Group", "CN=SearchBloxGroup2,CN=Computers,DC=company,DC=com":"companySearchBloxGroup2_Group"*  
While LDAP queries are quite self­explaining, role names may need more explanation. In order to determine valid group role name, one should:  
  1. Choose folder on local filesystem which AD group has access to (any permissions would do)
  2. Execute **icacls** command against that folder in command line e.g. **icacls SomeFolder** -­ one should get output similar to following: 
>> SomeFolder     company\SearchBloxGroup1:(RX) 
>>                someuser­pc\someuser:(OI)(CI)(RX) 
  3. First line basically says that *company\SearchBloxGroup1* has read and execute permissions on this folder. After removing backslash “\” from group name, one gets **companySearchBloxGroup1** string and after adding *_Group* suffix to it, one will receive desired group role name: **companySearchBloxGroup1_Group**

In order to login using AD login and password, user must use login with domain name i.e. **john@company.com** and not just **john**. After logging in and making a search on **/search/secure/securesearch.jsp** page, AD user will see only files which he/she has read permissions to via his/her AD group.
