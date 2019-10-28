# Miscellaneous Topics #

## Managing Locales ##
The default installation of openCRX activates all locales that are included in the Open Source distribution. The openCRX administrator may wish to deactivate certain locales from the locale list. This chapter shows how you can achieve this.

The locale list is contained in the file _opencrx-core-CRX/opencrx-core-CRX/WEB-INF/web.xml_. Look for the section \<!-- locales --\> to find a list of available locales:

	```
	<!-- locales -->
	<init-param>
	  <param-name>locale[0]</param-name>
	  <param-value>en_US</param-value>
	</init-param>
	<init-param>
	  <param-name>locale[1]</param-name>
	  <param-value>de_CH</param-value>
	</init-param>
	<init-param>
	  <param-name>locale[2]</param-name>
	  <param-value>es_MX</param-value>
	</init-param>
	...
	```

You can deactivate locales by simply commenting them out. The following example shows how to deactivate the locale _de\_CH_.

	```
	<!-- locales -->
	<init-param>
	  <param-name>locale[0]</param-name>
	  <param-value>en_US</param-value>
	</init-param>
	<!--
	<init-param>
	  <param-name>locale[1]</param-name>
	  <param-value>de_CH</param-value>
	</init-param>
	-->
	<init-param>
	...
	```

__WARNING:__Please note that you must not deactivate the base locale (that is the locale with the id 0, typically en_US) as the base locale contains a lot of customizing information not present in other locales.

## Managing Root Objects ##
The default installation of openCRX activates all root objects that are included in the Open Source distribution. The openCRX administrator may wish to deactivate certain root objects if they are not used. This chapter shows how you can achieve this.

Root objects are configured in the file _opencrx-core-CRX/opencrx-core-CRX/WEB-INF/web.xml_. Look for the section \<!-- Admin --\> to find a list of the available root objects:

	```
	<!-- Admin -->
	<init-param>
	 <param-name>rootObject[0]</param-name>
	 <param-value>xri:@openmdx:org.opencrx.kernel.admin1/provider/CRX/segment/${SEGMENT}</param-value>
	</init-param>
	<!-- Home -->
	<init-param>
	 <param-name>rootObject[1]</param-name>
	 <param-value>xri:@openmdx:org.opencrx.kernel.home1/provider/CRX/segment/${SEGMENT}/userHome/${USER}</param-value>
	</init-param>
	<!-- Accounts -->
	<init-param>
	 <param-name>rootObject[2]</param-name>
	 <param-value>xri:@openmdx:org.opencrx.kernel.account1/provider/CRX/segment/${SEGMENT}</param-value>
	</init-param>
	...
	```

You can deactivate root objects by simply commenting them out. The following example shows how to deactivate the root object _depot1_:

	```
	...
	</init-param>
	<!-- Depots -->
	<!--
	<init-param>
	  <param-name>rootObject[6]</param-name>
	  <param-value>xri:@openmdx:org.opencrx.kernel.depot1/provider/CRX/segment/${SEGMENT}</param-value>
	</init-param>
	-->
	<!-- Documents -->
	<init-param>
	  <param-name>rootObject[6]</param-name>
	  <param-value>xri:@openmdx:org.opencrx.kernel.document1/provider/CRX/segment/${SEGMENT}</param-value>
	</init-param>
	<!-- Buildings -->
	...
	```

__WARNING:__ Please note that you must renumber all the root objects listed after the root object you deactivated so that the numbering does not have any gaps (i.e. the numbering starts at 0 and it must be consecutive). It is also possible to change the order of the active root objects by renumbering them. However, you must still ensure both that the numbering starts at 0 and that the numbering is consecutive.

__HINT:__ Disabling root objects disables them for all segments and all users, i.e. disabled root objects are not available in the _UserSettings_ wizard.

## Custom Layout JSPs ##
openCRX is distributed with two default layout JSPs located in the directory _opencrx-core-CRX/opencrx-core-CRX/WEB-INF/config/layout/en_US_:

* __show-Default.jsp__: This layout JSP renders all pages that show information (typically an Inspector containing information about the current object and all the grids containing associated information). This layout JSP is generic (it is provided by openMDX/portal) and it can handle any object.
* __edit-Default.jsp__: Similarly, this layout JSP renders all pages that are used to edit objects.

If you have a need for specialized screens for a particular object in edit and/or show mode, you can write your own layout JSP and deploy it to the above-mentioned directory. The file name of your custom layout JSP determines which objects (or rather: objects of which class) will be handled by your custom layout JSP.

__Example:__
Let's assume you want to replace the default edit screen for openCRX Contacts (i.e. class org.opencrx.kernel.account1.Contact) with a custom layout JSP. Name your file _edit-org.opencrx.kernel.account1.Contact.jsp_ and deploy it to the directory _./WEB-INF/config/layout/en_US_. After restarting openCRX your new layout JSP will be active.

__NOTE:__If you develop localized JSPs you can create new directories for the respective locales and then deploy your localized JSPs there. The fallback algorithms are comparable to those in ui customization.

## Media BLOBs on the File System ##
By default, openCRX keeps all media blobs in the database, in the column “content” of the table “oocke1_media”. While this approach guarantees data consistency and transactional integrity (assuming your database supports this), the drawback is that database backups can get very big and backing up and/or restoring the database can take a long time if you have a lot of (large) media attachments in openCRX.

If you prefer to manage your media blobs on the file system (e.g. to make fast backups with rsync) you can configure openCRX to do just that.

### Migrate Media BLOBs from DB to File System ###
You can migrate from “BLOBs in the DB” to “BLOBs on the file system” with the following steps:

* stop Tomcat
* uncomment and/or configure the Java Option -Dorg.opencrx.mediadir, e.g. -Dorg.opencrx.mediadir.CRX=$CATALINA_BASE/mediadir
* start Tomcat
* login as admin-Root
* start _Wizards > Database schema wizard_
* note the new buttons: _Validate Media_, _Migrate Media to FS_ and _Migrate Media to DB_

![img](31/Admin/files/Miscellaneous/pic010.png)

* click the button _Migrate Media to FS_ and wait for the process to finish (note that the time required to complete the migration can be quite long; it depends on various factors, including the number and size of the media attachments).

### Validate Media ###
After migrating media BLOBs from the DB to the file system you should validate the media as follows:

* login as admin-Root
* start _Wizards > Database schema wizard_
* click the button _Validate Media_ and wait for the process to finish (note that the time required to complete the validation can be quite long; it depends on various factors, including the number and size of the media attachments)

![img](31/Admin/files/Miscellaneous/pic020.png)

You can also validate the media manually. On Linux, for example, you can generate a list of objects with

	```	
	find . -type f | rev | awk -F'/' '{print $1 "_" $3}' | rev
	```	

With PostgreSQL, for example, you can generate a list of objects with

	```	
	select object_id,
	reverse(split_part(reverse(object_id), '/', 2)) || '_' ||
	reverse(split_part(reverse(object_id), '/', 1))
	from oocke1_media
	where not content is null
	```	

__WARNING:__ Please not that you should NOT DELETE MEDIA BLOBs from your database before making a backup of your database and validating the media you migrated from the database to the filesystem.

If the validation of the media completed without errors you can delete the media BLOBs from the DB with the following SQL:

	```	
	update oocke1_media set content = null
	```	

### Migrate Media BLOBs from File System to DB ###
You can migrate from “BLOBs on the file system” to “BLOBs in the DB” with the following steps:

* ensure that during the migration process no new media BLOBs are created/changed as they are written to the file system (and not to the database) but might not get migrated to the database with the migration process (because the respective media object was processed by the wizard before the create/update was executed...)
* login as admin-Root
* start _Wizards > Database schema wizard_
* click the button _Migrate Media to DB_ and wait for the process to finish (note that the time required to complete the migration can be quite long; it depends on various factors, including the number and size of the media attachments)
* stop Tomcat
* remove the Java Option -Dorg.opencrx.mediadir
* start Tomcat

## Java Options ##
The following Java Options are set by default by the openCRX Server Installer:

	```	
	export JAVA_OPTS="$JAVA_OPTS -Xmx800M"
	export JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=256m"
	export JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8"
	export JAVA_OPTS="$JAVA_OPTS -Djava.protocol.handler.pkgs=org.openmdx.kernel.url.protocol"
	export JAVA_OPTS="$JAVA_OPTS -Dorg.opencrx.maildir=$CATALINA_BASE/maildir"
	export JAVA_OPTS="$JAVA_OPTS -Dorg.opencrx.airsyncdir=$CATALINA_BASE/airsyncdir"
	# export JAVA_OPTS="$JAVA_OPTS -Dorg.opencrx.usesendmail.CRX=false"
	# export JAVA_OPTS="$JAVA_OPTS -Dorg.opencrx.mediadir=$CATALINA_BASE/mediadir"
	# export JAVA_OPTS="$JAVA_OPTS -Dorg.openmdx.persistence.jdbc.useLikeForOidMatching=false"
	# export JAVA_OPTS="$JAVA_OPTS -Dorg.opencrx.security.enable=true"
	# export JAVA_OPTS="$JAVA_OPTS -Dorg.opencrx.security.realmRefreshRateMillis=120000"
	# export JAVA_OPTS="$JAVA_OPTS -Djavax.jdo.option.TransactionIsolationLevel=read-committed"
	export CLASSPATH=$CLASSPATH:$CATALINA_BASE/bin/openmdx-system.jar 
	```	

### -Xmx ###
The maximum size, in bytes, of the memory allocation pool – you might have to increase this value if you get out of memory exceptions 800M is fine for testing, but most likely too small for production environments. See also java and Garbage Collector Ergonomics.

### -XX:MaxPermSize ###
The maximum PermGen space in bytes – 256m – should be fine in most cases, but you might have to increase this value if you get OutOfMemoryError: PermGen Space.

### -Dfile.encoding ###
Default value: UTF-8. Do not change unless you have a good reason to do so.

### -Djava.protocol.handler.pkgs ###
Leave this value at org.openmdx.kernel.url.protocol.

### -Dorg.opencrx.maildir ###
Base directory that contains all mail directories managed by the IMAP servlet – the default value is $CATALINA_BASE/maildir.

### -Dorg.opencrx.airsyncdir ###
Base directory that contains all mail directories managed by the airsync servlet – the default value is $CATALINA_BASE/airsyncdir.

### -Dorg.opencrx.usesendmail.{provider} ###
Use sendmail instead of JavaMail.

### -Dorg.opencrx.mediadir ###
Base directory that contains all directories managed by the openCRX persistence layer to store media attachments – the default value is $CATALINA_BASE/mediadir.

### -Dorg.openmdx.persistence.jdbc.useLikeForOidMatching ###
Default value is true

As “object ID matching” (OID matching) is a frequent operation it is absolutely crucial that it can be done in a very efficient way, other­wise openCRX will suffer from a heavy performance hit. The openCRX database plugin does OID matching with SQL statements containing comparisons like

	```	
	(object_id > id_pattern_0) and
	(object_id < id_pattern_1)
	```	

Given the issues that exist with PostgreSQL prior to version 9.3 the default configuration of the openCRX database plugin resorts to a comparison based on LIKE. We are aware of the implications – a severe performance hit – as prepared statements with LIKE comparisons typically don't use indices (see openCRX PostgreSQL guide for more information).

### -Dorg.opencrx.security.enable ###
Leave this value at true unless you want to turn off access control (which is not recommended).

### -Dorg.opencrx.security.realmRefreshRateMillis ###
With the default value of 120000 the security configuration is refreshed every 2 minutes; if you need a higher refresh rate or can live with a lower refresh rate, feel free to adapt the value.

### -Djavax.jdo.option.TransactionIsolationLevel ###
Default value: read-committed. Do not change unless you have a good reason to do so.
