# How to rename a provider and/or segment #

This guide explains how to rename a provider and/or segment in an existing openCRX database.

__IMPORTANT:__ This guide assumes that the _openCRX SDK_ is installed (also see [here](31/Sdk/StepByStepEclipse/README.md)).

openCRX provides the generic _org.opencrx.kernel.tools.DbSearchReplace_ tool which allows to search / replace 
any string patterns in an existing openCRX database. This tool can also be used to rename provider
and segment names.

_DbSearchReplace_ does not offer a command-line option so you must write a _Java_ program which invokes
the _DbSearchReplace.dbSearchReplace()_ method with your custom parameters.

## Rename the provider ##

Below you find a template for a _RenameProvider_ class. It renames all occurences in all tables 
(except table OOCKE1_MEDIA.*) of /CRX/ to /MYCOMPANY/. The table OOCKE1_MEDIA.* is excluded because the 
JVM may not be able to load large BLOBs into memory. It is recommended to perform the rename with 
dedicated DB tools. 

Of course, you have to adapt the options as required to your needs.

__IMPORTANT:__ for testing purposes always run _DbSearchReplace.dbSearchReplace()_ with the option _validateOnly=true_.
This prints the UPDATE statements to the console but does not perform any updates on the database. Perform a
backup of your database and validate the statements carefully before you run with validateOnly=false.

```
public static class RenameProvider {

	public static void main(String[] args) {
	) throws ServiceException, ClassNotFoundException, SQLException {
		try {
			Class.forName(DbSchemaUtils.getJdbcDriverName(JDBC_URL));
			Properties props = new Properties();
			props.put("user", USERNAME);
			props.put("password", PASSWORD);
			Connection conn = DriverManager.getConnection(JDBC_URL, props);
			conn.setAutoCommit(true);
			// Rename OBJECT_IDs
			DbSearchReplace.dbSearchReplace(
				conn, 
				"(.*)", // table name includes
				"(OOCKE1_MEDIA.*)", // table name excludes
				"(.*)", // column name includes
				"(TEXT)|(DESCRIPTION)|(DETAILED_DESCRIPTION)|(MESSAGE_BODY)|(STRING_VALUE)|(BEFORE_IMAGE)", // column name excludes 
				"(/CRX/)",
				"/MYCOMPANY/", 
				true, // validateOnly 
				System.out
			);
		} finally {
		}
	}

	protected final static String JDBC_URL = "jdbc:hsqldb:hsql://127.0.0.1:9001/CRX";
	protected final static String USERNAME = "sa";
	protected final static String PASSWORD = "manager99";

}

```


## Rename a segment ##

Below you find a template for a _RenameSegment_ class. It renames all occurences in all tables 
(except table OOCKE1_MEDIA.*) of /OldSegment to /NewSegment. The table OOCKE1_MEDIA.* is excluded because 
the JVM may not be able to load large BLOBs into memory. It is recommended to perform the rename with 
dedicated DB tools. 

Of course, you have to adapt the options as required to your needs.

__IMPORTANT:__ for testing purposes always run _DbSearchReplace.dbSearchReplace()_ with the option _validateOnly=true_.
This prints the UPDATE statements to the console but does not perform any updates on the database. Perform a
backup of your database and validate the statements carefully before you run with validateOnly=false.

```
public static class RenameSegment {

	public static void main(String[] args) {
	) throws ServiceException, ClassNotFoundException, SQLException {
		try {
			Class.forName(DbSchemaUtils.getJdbcDriverName(JDBC_URL));
			Properties props = new Properties();
			props.put("user", USERNAME);
			props.put("password", PASSWORD);
			Connection conn = DriverManager.getConnection(JDBC_URL, props);
			conn.setAutoCommit(true);
			// Rename OBJECT_IDs
			DbSearchReplace.dbSearchReplace(
				conn, 
				"(.*)", // table name includes
				"(OOCKE1_MEDIA.*)", // table name excludes
				"(.*)", // column name includes
				"(TEXT)|(DESCRIPTION)|(DETAILED_DESCRIPTION)|(MESSAGE_BODY)|(STRING_VALUE)|(BEFORE_IMAGE)", // column name excludes 
				"(/OldSegment)",
				"/NewSegment", 
				true, // validateOnly 
				System.out
			);
			// Rename OWNER
			DbSearchReplace.dbSearchReplace(
				conn, 
				"(.*)", // table name includes
				"(OOCKE1_MEDIA.*)", // table name excludes
				"(.*)", // column name includes
				"(TEXT)|(DESCRIPTION)|(DETAILED_DESCRIPTION)|(MESSAGE_BODY)|(STRING_VALUE)|(BEFORE_IMAGE)", // column name excludes 
				"(OldSegment:)",
				"NewSegment:", 
				true, // validateOnly 
				System.out
			);
			// Rename segment admin
			DbSearchReplace.dbSearchReplace(
				conn, 
				"(.*)", // table name includes
				"(OOCKE1_MEDIA.*)", // table name excludes
				"(.*)", // column name includes
				"(TEXT)|(DESCRIPTION)|(DETAILED_DESCRIPTION)|(MESSAGE_BODY)|(STRING_VALUE)|(BEFORE_IMAGE)", // column name excludes 
				"(admin-OldSegment)",
				"admin-NewSegment", 
				true, // validateOnly 
				System.out
			);
		} finally {
		}
	}

	protected final static String JDBC_URL = "jdbc:hsqldb:hsql://127.0.0.1:9001/CRX";
	protected final static String USERNAME = "sa";
	protected final static String PASSWORD = "manager99";

}

```

In addition, you have to perform the following steps manually as _admin-Root_ using the standard GUI:

* In _Security Realm_ rename the realm _OldSegment_ to _NewSegment_
* In _Security Subjects_ rename the subject _admin-OldSegment_ to _admin-NewSegment_
