# How to upgrade openCRX from a previous version #

## About versioning in openCRX ##
We identify an openCRX version with 3 numbers x, y, and z (i.e. openCRX x.y.z). x.y.z is the 
Implementation Version, x.y is the corresponding Specification Version. The meaning of individual 
numbers is listed in the table below:

<table>
	<thead>
		<tr>
			<th class="feature">&nbsp;</th>
			<th class="feature">Name</th>
			<th class="feature">&nbsp;</th>
			<th>Interfaces/Functions</th>
			<th>Implementation</th>
			<th>Database</th>
			<th>Implications</th>
		</tr>
	</thead>

	<tr>
		<td class="feature">x</td>
		<td class="feature">Major Version</td>
		<td class="feature">if major version number increased</td>
		<td>interfaces will be different (i.e. not upward compatible)</td>
		<td>will be different</td>
		<td>new tables and possibly<br> change of existing tables
		</td>
		<td nowrap><u>Implementation:</u><br> - bugs fixed<br> - new functions <br> - user code requires refactoring<br> <br> <u>Database:</u><br> - modification of existing tables<br>&nbsp;&nbsp; and adding of new tables<br> - no data migration</td>
	</tr>
	<tr>
		<td class="feature">y</td>
		<td class="feature">Minor Version</td>
		<td class="feature">if minor version number increased (but same major version number)</td>
		<td>interfaces have been extended and/or new functions have been added (but upward compatibility is guaranteed)</td>
		<td>will be different</td>
		<td>possibly new tables</td>
		<td nowrap><u>Implementation:</u><br> - bugs fixed<br> - new functions <br> - user code upwards compatible<br> <br> <u>Database:</u><br> - script adding new columns to table<br>&nbsp;&nbsp;and adding new tables<br> - no data migration</td>
	</tr>
	<tr>
		<td class="feature">z</td>
		<td class="feature">Patch Version</td>
		<td class="feature">if patch version number increased (but same specification number)</td>
		<td>unchanged</td>
		<td>will be different</td>
		<td>possibly new columns<br> of existing tables
		</td>
		<td nowrap><u>Implementation:</u><br> - bugs fixed<br> - user code upwards compatible<br> <br> <u>Database:</u><br> - script adding new columns to table<br> - no data migration</td>
	</tr>
	<tr>
</table>

## Upgrading from v4.1.0 to v4.2.0 ##

* Stop the openCRX server (i.e. the servlet container Tomcat/application server, etc. and HSQLDB _if running_)
* Backup your database
* Install openCRX 4.2.0 with the <a href="server.htm">openCRX Server Installer</a> in a new directory
* In case you made changes to the standard configuration of your previous openCRX installation, amend the changes in the new openCRX installation:
    * Verify _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/bin/setenv.sh_ (or setenv.bat on Windows)
    * Verify _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/conf/tomee.xml_ (called openejb.xml in older versions)
    * Verify _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/conf/server.xml_
    * Verify _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/conf/tomcat-users.xml_
    * Copy JARs (e.g. JDBC-drivers, etc.) you added to _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/lib_
* In case you use HSQLDB as a database:
    * Copy _{openCRX_INSTALL_DIR_OLD}/data/crx/crx.script_ to _{openCRX_INSTALL_DIR}/data/crx/crx.script_
* Start openCRX Server (the newly installed instance); you can either use the shortcut created by the installer or open a shell/cmd window and
    * cd to _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/bin_ and
    * execute ./opencrx.sh run (or opencrx.bat run on Windows)
* Once you have openCRX running again, proceed as follows:
    * Login as _admin-Root_
    * Launch the _Database schema wizard_ from _Wizards > Database schema wizard_
    * Click on the button _Validate and Fix_ (the wizard will upgrade your DB schema to the appropriate version of openCRX; the wizard will not delete/drop any tables or columns, i.e. if there are validation messages that you have extra tables/columns in your database, you should drop those manually with your preferred DB admin tool, e.g. pgAdmin for PostgreSQL). __Hint:__ some databases do not support create/update view and you will have to manually delete all views in your openCRX database so that the database schema wizard can create the new views; you have to do this with your preferred database administration tool (e.g. pgAdmin for PostgreSQL).
    * If there are validation messages that you have extra tables/columns in your database, you might want to drop those manually (the wizard does not drop tables/columns ever); please note, however, that __the wizard does not know about tables/columns related to model extensions in custom-projects__, i.e. double-check any table/column before you actually drop it
    * Click on the button _Validate_ to verify the database schema; it is important that the schema validation reports NO errors before you continue - if there are errors reported, try another cycle of _Validate and Fix_ followed by _Validate_; if that doesn't help, try deleting the views manually as explained above and then try another cycle of _Validate and Fix_ followed by _Validate_
    * Delete all codes as follows:
        * Navigate to _Codes_
        * In the grid _Codes_ select View &gt; Show 500 rows
        * In the grid _Codes_ click the checkbox to the left of the header Identity to select all code rows
        * In the gird _Codes_ select Edit &gt; Delete to delete all code entries
    * Import codes and data as follows:
        * Navigate to _Administration_
        * In the grid _Administration_ select View &gt; Reload to import the new codes and data
    * Set the access levels of codes to 4, 3, 2, 1 as follows:
        * Navigate to _Codes_
        * In the grid _Codes_ select Security &gt; Set Access Level
        * Set the drop downs in the dialog Set Access Level to the following values:
            * 4 for Browse access level
            * 3 for Update access level
            * 2 for Delete access level
            * 1 for Mode Recursive
    * Stop openCRX Server; it is important to shut down openCRX properly - you can either use the shortcut created by the installer or open a shell/cmd window and
        * cd to _{openCRX_INSTALL_DIR}/apache-tomee-plus-7.0.5/bin_ and
        * execute _./opencrx.sh stop_ (or _opencrx.bat stop_ on Windows)
* Start openCRX Server
* For each of your segments (e.g. Standard) login as segment administrator (e.g. _admin-Standard_) and run the wizard Segment Setup (_Home > Wizards > Segment Setup_) to bring your configuration up to date
* Optionally: you can now uninstall the new installation of openCRX as it is no longer needed
