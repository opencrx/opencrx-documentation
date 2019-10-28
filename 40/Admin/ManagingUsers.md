# Managing Users #

## Create Users as Segment Administrator ##
The Segment administrator can create new users with the following steps:

* Login as Segment administrator (e.g. admin-Standard)
* Create a contact for the new user
* Click on the element “User Homepages” of the breadcrum:

![img](40/Admin/files/ManagingUsers/pic010.png)

* Next you select the operation Actions > Create User... which allows you to create and initialize a new user:

![img](40/Admin/files/ManagingUsers/pic020.png)

* Type the new user's principal name (e.g. guest) into the field Principal name, use the Lookup Inspector or the auto-completer to fetch values for Contact and Primary user group (unless you have a good reason to provide a user group, leave Primary User Group empty and openCRX will automatically create a user group with name <principal name>.Group), and then type a password (e.g. opencrx) into the fields Initial password and Password again:

![img](40/Admin/files/ManagingUsers/pic030.png)

* Status 0 indicates that the user guest was created without errors:

![img](40/Admin/files/ManagingUsers/pic040.png)

* Please note that we are still logged in as admin-Standard (as shown in the header of the application), but we are looking at the homepage of the user guest. Execute the operation _Edit > User Settings_:

![img](40/Admin/files/ManagingUsers/pic050.png)

* This will start the wizard User Settings. You can configure various settings with this wizard. At a minimum you should probably set the timezone and enter the new user's e-mail address. Once you're done you can click the button _Save_. The wizard will then create a bunch of objects and finalize the initialization of the user guest:

![img](40/Admin/files/ManagingUsers/pic060.png)

* Click _Close_ to leave the wizard.

__NOTE: __ The wizard User Settings creates a user group <username>.Group, in the above case guest.Group. The primary user group of the user guest was automatically set to this new user group guest.Group. If you want to change the primary user group to anything else or if you ever must reset a user (lost password, etc.), you can re-execute the operation Create User as admin-Standard at any time. If you want to reset a user without changing the user's password, you can simply leave the password fields empty when recreating the user.

* Logoff as admin-Standard and login as the newly created user (guest in our example)

* Execute the operation Edit > User Settings and click _Save_. This time (i.e. when executed by the newly created user) the wizard User Settings creates various user-specific/private objects.

For security and consistency purposes creating new users is a 3-phase process:

Phase   | Description
--------|-----------------------
Phase 1 | The segment administrator (e.g. admin-Standard) executes createUser() and then enters the principal's name)
        | If the new principal name matches the name of an already existing principal, the new principal is not created and an alert (“CreateUserConfirmationRequest”) is created in all segments the already existing principal has access to.
Phase 2 | The user related to the already existing principal must accept in at least one segment the “CreateUserConfirmationRequest”
Phase 3 | once at least one “ CreateUserConfirmationRequest” has been accepted, the segment administrator can execute createUser() again with the respective principal name; this time the new user (i.e. UserHome) is created

### Import Subjects and Application Login Principals ###
Creating large numbers of subjects/principals by hand can be quite a tedious job. If you prepare a text file containing the appropriate information in the file format as outlined below, the Root administrator (admin-Root) can use the operation Actions > Import Login Principals to create Subjects and Application Login Principals automatically.

![img](40/Admin/files/ManagingUsers/pic070.png)

__File Format Subjects and Application Login Principals:__

	```
	Subject;<subject name>;<subject description>
	
	Principal;<principal name>;<principal description>;<subject name>;<groups>
	```

__Example File Subjects and Application Login Principals:__

	```
	Subject;joe;Doe, Joe
	Subject;mark;Ferguson, Mark
	Subject;peter;Lagerfeld, Peter
	Principal;joe;Doe, Joe;joe;Users,Administrators
	Principal;mark;Ferguson, Mark;mark;Users
	Principal;peter;Lagerfeld, Peter;peter;Users
	```

## Import Users ##
Similarly to importing Subjects and Application Login Principals from a file you can also import Users from a file. If you prepare a text file containing the appropriate information in the file format as outlined below, the Segment administrator (admin-<SegmentName>) can use the operation Actions > Import Users to create Users automatically.

![img](40/Admin/files/ManagingUsers/pic080.png)

__File Format Users:__

	```
	User;<principal>;<account alias>;<account full name>;<primary group>;<password>[;<groups>[;<email>[;<timezone>]]]
	```

Parameter         | Description
------------------|-----------------------
principal         | required, name of principal
account alias     | at least one value per user must be provided, i.e. either the alias name of the contact, or then the full name
account full name | at least one value per user must be provided, i.e. either the alias name of the contact, or then the full name
primary group     | optional, default is <principal>.Group
password          | required, clear text value
groups            | optional, comma separated list of memberOf principal groups, the user is made a member of each provided principal group
email             | optional e-mail address, e.g. joe@opencrx.org
timezone          | optional time zone, e.g. Europe/Zurich

__NOTE:__ Please note that a “-” value (a dash without the quotes) means empty in the context of a user file. Example: if you don't want to explicitly define a primary group, put a dash – the importer will then create the default primary group <principal>.Group.

__Example File Users:__

	```
	User;joe;JD;Doe, Joe;Users;2%jOd.IT;MGMT,SALES
	User;mark;Fergi;Ferguson, Mark;Users;maFe&.3-;MGMT
	User;peter;-;Lagerfeld, Peter;-;PlF*;ReGaL;SALES
	```

__IMPORTANT:__ Contacts are not created automatically; existing Contacts are first searched by <account alias>. If no matching account alias is found, Contacts are search by <account full name>. If still no matching account is found, the UserHome is not created. Users are only imported/created if the referenced Principals exist.

## Disable/Deactivate Users ##
There are various ways of disabling/deactivating users. To fully understand your options it is helpful if you are familiar with the openCRX Login Procedure.

### Disable Users at the level Tomcat /Application Server ###
Depending on the configuration of your application server you can disable users at that level. For example, if you rely on file-based realms, you can simply remove users from the file tomcat-users.xml (with Apache Tomcat) or users.properties (with JBoss) to prevent access to openCRX. If you block access at the level Tomcat / application server such users are locked out from accessing any application and any openCRX segment. However, as the servlet container's login procedure is not entirely controlled by openCRX you might have to consult the documentation of your respective servlet container (e.g. Tomcat or JBoss) or ask your administrator for details.

### Disable Users at the level openCRX ###
The segment administrator (e.g. admin-Standard) can prevent a user from accessing a particular openCRX segment by either disabling the respective Segment Login Principal or by deleting it altogether. Disabling is the preferred option to prevent access temporarily. If a user has multiple Segment Login Principals you must disable all of them to prevent access to the openCRX application.

![img](40/Admin/files/ManagingUsers/pic090.png)

__IMPORTANT:__ You should not delete a particular Subject as long as it is referenced by any Principal. Otherwise you'll end up with “dangling” Subject references.
