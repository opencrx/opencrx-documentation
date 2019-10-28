# How to setup and migrate an existing openCRX database #

This guide explains how to setup and migrate from an existing openCRX database to another database.

__IMPORTANT:__ This guide assumes that _openCRX 3.1 Server_ is successfully setup as described in [openCRX 3.1.0 Server Installation Guide](Admin/InstallerServer.md).

openCRX provides the following tools to migrate from an existing database to an other database

* __DbSchemaWizard__: The schema wizard allows to create or upgrade an openCRX schema for
  a given target database. The target database is specified with the JDBC connection URL, 
  username and password.
* __DbCopy__: The database copy wizard allows to copy the openCRX data from a source database
  to a given target database. All rows of all tables are copied, so the DbCopy in fact performs
  creates a clone. Source and target database are specified by their JDBC connection URLs,
  usernames and passwords.
   
__IMPORTANT:__ The wizards assume that the required JDBC database driver JARs are installed in the
Apache TomEE directory _apache-tomee-webprofile-1.7.1/lib/_. The driver for HSQLDB is installed by
default. However, the drivers for other databases must be installed manually. After installing the
drivers restart _openCRX_.

## Prepare the target database ##

_openCRX_ supports the following databases: HSQLDB, PostgreSQL, MySQL, DB/2, Oracle, and MS SQL Server.

This guide assumes that you have

* a running database instance
* an (empty) database schema / database where the _openCRX_ schema will be installed
* user names and password
* the _JDBC_ connection URL

In most cases, setting up a new _openCRX_ database schema is straight forward and requires no specific administration tasks. 
However, some databases require specific settings which are listed below. 

### PostgreSQL ###

#### Prerequisites ####
* Download PostgreSQL Database Server from [here](http://www.postgresql.org/download/)
* Download pgAdmin III from [here](http://www.postgresql.org/download/)
* Download the matching PostgreSQL JDBC driver from [here](http://jdbc.postgresql.org/download.html)

As a next step you must install PostgreSQL and pgAdmin III (please refer to the PostgreSQL documentation for installation details).

#### Issues specific to PostgreSQL ####
Based on our analysis, it seems PostgreSQL is not behaving consistently across platforms. The replies to the following (trivial) select statements are irritating:

| Select Statement   | expected reply | PG on Windows | PG on Linux |
|--------------------|----------------|---------------|-------------|
| select '0' > '/'   | true           | true          | true        |
| select '0' > '/a'  | true           | true          | false       |
| select '0' > '/aa' | true           | true          | false       |

The replies of PostgreSQL on Windows are correct, some of the replies of PostgreSQL on Linux are (in our opinion) not correct.

A note to the PostgreSQL community:
We are aware of locale-specific sorting, but the results of the above 3 select statements should be true for any locale as
'0' > '/' implies '0' > '/(.)+' (unless '/' is treated as some kind of special escape character in a particular locale so 
that '/a < '0' is true for such a locale; to our best knowledge, such a locale does not exist).

As “object ID matching” (OID matching) is a frequent operation it is absolutely crucial that it can be done in a very 
efficient way, otherwise openCRX will suffer from a performance hit. The openCRX database plug-in does OID matching with 
SQL statements containing comparisons like (object_id > id_pattern_0) and (object_id < id_pattern_1). Given the issues that 
exist with PostgreSQL the default configuration of the openCRX database plug-in resorts to a comparison based on LIKE. We are 
aware of the implications - a severe performance hit with PostgreSQL earlier than 9.x - as prepared statements with LIKE 
comparisons typically don't use indices.

If any of the following conditions is true you can override the default setting of the openCRX database plug-in:

* the locale of the openCRX database is equal to C
* the locale of the openCRX database is equal to POSIX
* lc_collate and lc_ctype of your PostgreSQL cluster are equal to C; open a query window in pgAdmin and execute 
  “show all” to see the settings of your database cluster.
  
With PostgreSQL, the system property 

	```
	-Dorg.openmdx.persistence.jdbc.useLikeForOidMatching
	```

is by default set to true; this ensures that OID matching works as expected, but the price is a performance hit. 
If any of the above conditions is satisfied you can safely set this system property to false resulting in much 
improved performance. You can override the default setting by providing the following startup option to openCRX:

	```
	-Dorg.openmdx.persistence.jdbc.useLikeForOidMatching=false
	```

####  Support for SOUNDS LIKE and SOUNDS NOT LIKE ####
Out of the box PostgreSQL does not support the operators SOUNDS LIKE and SOUNDS NOT LIKE. However, you can run the 
script fuzzystrmatch.sql, which is contained in the directory <pg installation directory>/share/contrib. Executing 
the script will add support for SOUNDS LIKE and SOUNDS NOT LIKE.

#### UTF-8 support ####
Assuming you want full UTF-8 support for the openCRX database, we recommend you set the locale behavior of the server to C as follows.

On Linux,

* install the latest version of PostgreSQL (and the required libraries)
* install pgadmin
* please note that the package installer runs initdb automatically, but probably not with the desired locale settings (by default, initdb is run with the same locale as your OS default locale, i.e. typically UTF-8; this leads to problems as indicated in chapter 3.1 Puzzling behavior of PostgreSQL), hence we need to redo the initialization:
* stop pg daemon
* rename /var/lib/pgsql/data to /var/lib/pgsql/data.ori
* su - postgres
* initdb --pgdata=data --encoding=UTF8 --locale=C --username=postgres --pwprompt

Alternatively, you can set "LC_ALL=C" in the environment of the relevant pg processes; if LC_ALL is set to "C", the PostgreSQL sort order is also correct.

On Windows, use the pgInstaller which allows you to set initdb parameters.

## Create the database schema ##
Start _openCRX Server_ dad login as _admin-Root_. Launch the Database schema wizard as shown below.

![img](Admin/files/DatabaseMigration/pic010.png)

Specify the JDBC connection URL, username and password for the target database.

![img](Admin/files/DatabaseMigration/pic020.png)

Now click on _Validate_. The wizard checks the schema of the target database and reports any
missing tables and views. It also checks the table columns and reports missing and extra columns.

![img](Admin/files/DatabaseMigration/pic030.png)

For every reported problem the wizard also offers a fix in form a a database statement 
(_CREATE TABLE ..._, _CREATE VIEW ..._, _ALTER TABLE ..._, etc.). You can copy/paste the statement
and run it in your favorite SQL Editor in order to update the database. To make things easier,
the wizard offers the _Validate & Fix_ function which runs the statements on the target
database. In case of a database with an empty schema you have to run the _Validate & Fix_
two or three times: In a first step it creates all tables, in a second step all dependent 
views and indexes. Finally, if everything goes well no errors should be reported.

![img](Admin/files/DatabaseMigration/pic040.png)

## Copy the database ##
If you want to migrate the data from an existing database to the new target database you
can do it with the DbCopy wizard. Start _openCRX Server_ and login as _admin-Root_.

![img](Admin/files/DatabaseMigration/pic050.png)

Specify the JDBC connection URL, username and password of the source database and target database.

![img](Admin/files/DatabaseMigration/pic060.png)

Then click _Copy_. The wizard shows to progress of the copy procedure. Clicking _Refresh_ updates
the progress output.

![img](Admin/files/DatabaseMigration/pic070.png)

### Troubleshooting ###

```
Insert failed. Reason: Data truncation: Data too long for column 'CONTENT' at row 1
statement=INSERT INTO OOCKE1_MEDIA  (OBJECT_ID, ACCESS_LEVEL_BROWSE, ACCESS_LEVEL_DELETE, ACCESS_LEVEL_UPDATE, CONTENT, CONTENT_MIME_TYPE, CONTENT_NAME, CREATED_AT, CREATED_BY_, P$$PARENT, MODIFIED_BY_, NAME, OWNER_, MODIFIED_AT, DTYPE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
```

This error occurs if the target column is too small to store the data of the source column. In this case
increase the size of the target column using a native SQL Browser / Editor. In the case shown above the
column _CONTENT_ in the table _OOCKE1_MEDIA_ must be redefined from _BLOB_ to _LONGBLOB_ using 
the _MySQL Query Browser_.  

__IMPORTANT:__ Only use the target database if the copy runs without errors.

__IMPORTANT:__ The current value of the database sequences (_oocke1\_activity\_number_seq_, 
_oocke1\_position\_number\_seq_) are not migrated by _DbCopy_. Set the values manually to proper 
values before using the database.

## Setup a database connector ##
Next configure the database connector which allows _Apache TomEE_ to connect to your newly created database. For this purpose open the file _{opencrxServer_installdir}/apache-tomee-webprofile-1.7.1/conf/tomee.xml_ and adapt the following section:

```
<Resource id="jdbc_opencrx_CRX" type="DataSource">
 JdbcDriver org.hsqldb.jdbcDriver
 JdbcUrl jdbc:hsqldb:hsql://127.0.0.1:9001/CRX
 UserName sa
 Password manager99
 JtaManaged true
</Resource>
```
according to your database settings.

__PostgreSQL:__

```
	JdbcDriver org.postgresql.Driver
	JdbcUrl jdbc:postgresql://localhost/CRX
```

__MySQL:__

```
	JdbcDriver com.mysql.jdbc.Driver
	JdbcUrl jdbc:mysql://localhost:3306/CRX
```

__DB/2:__

```
	JdbcDriver com.ibm.db2.jcc.DB2Driver
	JdbcUrl jdbc:db2://localhost:50000/CRX
```

__Oracle:__

```
	JdbcDriver oracle.jdbc.driver.OracleDriver
	JdbcUrl jdbc:oracle:thin:@localhost:1521:XE
	UserName CRX
```

__SQL Server:__

```
	JdbcDriver com.microsoft.sqlserver.jdbc.SQLServerDriver
	JdbcUrl jdbc:sqlserver://localhost:1433;databaseName=CRX;selectMethod=cursor
```

Also adapt correspondingly the _openCRX_ launch script _{opencrxServer_installdir}/apache-tomee-webprofile-1.7.1/bin/opencrx.sh_ and _{opencrxServer_installdir}/apache-tomee-webprofile-1.7.1/bin/opencrx.bat_. If required, disable the START and STOP commands for the _HSQLDB_ database.

## Start TomEE ##
Now you are ready to start _TomEE_. _openCRX_ now connects to the newly created and populated database.
