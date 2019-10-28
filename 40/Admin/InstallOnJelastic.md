# How to install openCRX on Jelastic #
Jelastic (acronym for Java Elastic) is an unlimited PaaS and Container based IaaS within a single 
platform that provides high availability of applications, automatic vertical and horizontal scaling 
via containerization. For more information see [here](http://jelastic.com/). This guide explains 
how to setup openCRX on Jelastic.

## Prerequisites ##
This guide assumes that you are familiar with the basic features of Jelastic.

__IMPORTANT:__ This guide assumes that _openCRX 4.0 Server_ is successfully setup as described in [openCRX 4.0.0 Server Installation Guide](Admin/InstallerServer.md).

## Create and configure environment ##
Launch the Jelastic administration console and create a new _JAVA_ environment with the following topology:

* _Apache 2.2_ as frontend (we did not test _nginx_ but it should work as well)
* _TomEE 1.7_ as application server
* _PostgreSQL_ as database (you can migrate to another supported database later on at any time. For more information see [here](Admin/DatabaseMigration.md)) 

Select _Apache 2.2_ as frontend:

![img](Admin/files/InstallOnJelastic/pic010.png | width=320)

Select _TomEE 1.7_ / _Java 8_ as application server:

![img](Admin/files/InstallOnJelastic/pic020.png | width=320)

Select _PostgreSQL 9.4_ as database:

![img](Admin/files/InstallOnJelastic/pic030.png | width=320)

After building the environment the layout should look as follows:

![img](Admin/files/InstallOnJelastic/pic040.png | width=960)

As a next step we have to create a new database. Login to the _PostgreSQL_ administration console and create a new database instance as shown below:

![img](Admin/files/InstallOnJelastic/pic050.png | width=960)

The following fields are mandatory and must be set as follows:

* __Name:__ CRX (default database name of _openCRX_)
* __Template:__ template0 (this template allows to set the collation to C)
* __Encoding:__ UTF-8 (_openCRX_ supports UTF-8 encoding only)
* __Collation: C__ (allows ordering as required by _openCRX_. For more information see [here](Admin/DatabaseMigration.md))

After the database is created we have to create the bootstrap database schema. This schema contains only a minimal set of tables required to start start _openCRX_ and login as Root administrator. Select the database _CRX_ and click on the _SQL_ button to launch the SQL script window. Get the create schema script from [here](./attachment/createdb-schema-postgresql.sql) and upload it to the SQL script window by clicking on the _Choose File_ button:

![img](Admin/files/InstallOnJelastic/pic060.png | width=960)

The script should run without errors as shown below:

![img](Admin/files/InstallOnJelastic/pic070.png | width=960)

Next we have to prepare _TomEE 1.7_. Click on the _Config_ button of the _TomEE_ node as shown below:

![img](Admin/files/InstallOnJelastic/pic080.png | width=960)

Select the directory _apps_ click on the _Upload_ button and upload the file _opencrx-core-CRX.ear_. You can get the file from an existing _openCRX server_ installation. It is located in the directory _./apache-tomee-webprofile-1.7.4/apps/_. 

![img](Admin/files/InstallOnJelastic/pic090.png | width=960)

Next switch to the directory _lib_ and upload the following files:

* _catalina-openmdx.jar_: You can get the file from an existing _openCRX server_ installation. It is located in the directory _./apache-tomee-webprofile-1.7.4/lib/_.
* _postgresql-9.4-1202.jdbc4.jar_: you should download the latest JDBC driver for PostgreSQL from [here](https://jdbc.postgresql.org/).

![img](Admin/files/InstallOnJelastic/pic100.png | width=960)

Next switch to the directory _server_ and open the file _variables.conf_. Paste the following text:

```
	# BEGIN openCRX
	-Dfile.encoding=UTF-8
	-Dorg.openmdx.kernel.collection.InternalizedKeyMap.TrustInternalization=true
	-Dorg.opencrx.maildir=home/maildir
	-Dorg.opencrx.airsyncdir=home/airsyncdir
	-Dorg.opencrx.mediadir=home/mediadir
	# -Dorg.opencrx.usesendmail.CRX=false
	# -Dorg.openmdx.persistence.jdbc.useLikeForOidMatching=false
	# -Djavax.jdo.option.TransactionIsolationLevel=read-committed
	# END openCRX
```

![img](Admin/files/InstallOnJelastic/pic110.png | width=960)

In a next step we have to configure _TomEE_ so that it can access the database. Open the file _tomee.xml_ and paste the following text:

```
	<?xml version="1.0" encoding="UTF-8"?>
	<tomee>
	  <!-- see http://tomee.apache.org/containers-and-resources.html -->
	
	  <!-- openCRX/PostgreSQL -->
	  <Resource id="jdbc_opencrx_CRX" type="DataSource">
	    JdbcDriver org.postgresql.Driver
	    JdbcUrl jdbc:postgresql://{{pg env and host name}}/CRX
	    UserName {{pg username}}
	    Password {{pg password}}
	    JtaManaged true
	    RemoveAbandoned true
	    RemoveAbandonedTimeout 10
	    LogAbandoned true
	    MaxWait 100
	  </Resource>
	
	  <!-- activate next line to be able to deploy applications in apps -->
	  <Deployments dir="apps" />
	    
	</tomee>
```

Make sure that you replace place holders _{{pg env and host name}}_, _{{pg username}}_, _{{pg password}}_ with the proper settings from your _Jelastic_ environment.

![img](Admin/files/InstallOnJelastic/pic120.png | width=960)

Now open _tomcat-users.xml_ and and paste the text below. This allows us to login as user _admin-Root_. 

```
	<?xml version='1.0' encoding='utf-8'?>
	<tomcat-users>
	  <role rolename="OpenCrxUser"/>
	  <role rolename="OpenCrxRoot"/>
	  <role rolename="OpenCrxAdministrator"/>  
	  <user username="admin-Root" password="manager99" roles="OpenCrxRoot,OpenCrxAdministrator"/>
	</tomcat-users>
```

![img](Admin/files/InstallOnJelastic/pic130.png | width=960)

Last we have to modify _server.xml_ as shown below. We have to add the option _URIEncoding="UTF-8"_ for the connectors _AJP/1.3_ and _HTTP/1.1_. This guarantees proper URL encoding for all UTF-8 characters: 

```
	<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" URIEncoding="UTF-8" />
	<Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="443" URIEncoding="UTF-8" />
```
               
![img](Admin/files/InstallOnJelastic/pic140.png | width=960)

Now restart the _TomEE_ node as shown below:

![img](Admin/files/InstallOnJelastic/pic150.png | width=960)

Switch to the logs by clicking an the _Log_ icon and select the log file _catalina_.  This shows the startup progress of _TomEE_ and _openCRX_:

![img](Admin/files/InstallOnJelastic/pic160.png | width=960)

Now click on the _Open in browser_ icon. 

![img](Admin/files/InstallOnJelastic/pic170.png | width=960)

This connects the _TomEE_ with the root URL. Append _opencrx-core-CRX_ to the URL in the browser address bar. This brings up the login screen of _openCRX_:

![img](Admin/files/InstallOnJelastic/pic180.png | width=960)

Now you have a running (empty) _openCRX_ instance. Follow the instructions of the [upgrade guide](Admin/HowToUpgrade.md) in order to complete the installation of _openCRX_:

* Launch and run the database schema wizard
* Load the code tables
* Create and setup the segment 'Standard'
