# Using Data Import / Export #

There are many ways of importing data (from other systems into openCRX) and exporting data (from openCRX to other systems). Generally speaking, there is no best way of doing imports/exports because depending on how much weight you put on the pros and cons of the various methods you may come to a different conclusion. Some issues to consider are:

* one-time import/export vs. multiple imports/exports
* file-based/batched vs. connection-based/real-time
* allow manual process steps vs. fully automated
* etc.

In this chapter we will cover some of the basic options you can choose from, but there are obviously other (and sometimes better) options to consider.

__NOTE:__ While it may be tempting to connect to the openCRX database for “quick and dirty” imports/exports, you should really consider using the openCRX API. On the one hand, importers/exporters accessing the database directly are bypassing openCRX security (this is actually more of a warning than a tip...). On the other hand, the openCRX database schema is subject to change (whereas the API is stable).

## Importing Data into openCRX ##
The task of importing data is handled by importers. In principle, you can import almost anything into openCRX, it’s really only a matter of writing an appropriate importer.

__WARNING:__ You must ensure that (legal) values are assigned to all mandatory (i.e. non-optional) attributes of openCRX objects created/updated during the import; in particular, all code attributes are mandatory!

The Open Source distribution of openCRX includes importers for vCard (see Importing vCard Files)and iCalendar files (see Error: Reference source not found) in addition to the XML importer.

## Importing XML Files ##
You can import virtually any data into openCRX as long as you provide it in the form of schema-compliant XML files. The openCRX schema files can be found in the file opencrx-kernel.jar (unzip and look for xmi1 subdirectories). Alternatively, you can export example objects as XML files and look at the produced XML files (although the generated XML file also contains all the derived and optional attributes; hence, you will have to prune the generated XML file before you can use it as a template).

Some of the configuration information and data provided with openCRX are also provided in the form of XML files and imported during system setup (e.g. units of measurement are loaded from _opencrx-core-CRX/opencrx-core-CRX/WEB-INF/config/data/Root/101_uoms.xml_).

An XML import from a third party system might typically involve the following steps:

![img](files/DataImportExport/pic010.png)

You can import schema-compliant XML files with the following methods:

* Interactive / on-demand. Navigate to your user home and execute the operation _File > Import_:

![img](files/DataImportExport/pic020.png)

Click on the button and navigate to XML file to be imported. Next you click [OK] to to start the import. Please note that this method is very suitable for small XML files and on-the-fly imports. If you are dealing with larger XML files, however, you should consider the bulk import described below.

* Bulk Import. Use the bulk import for large XML files or if you need to import multiple XML files in an automated fashion. Put your XML file(s) into the following directory (you might have to expand the EAR file to do so): _opencrx-core-CRX/opencrx-core-CRX/WEB-INF/config/data/<SegmentName>_ where <SegmentName> can be Root, Standard, or whatever your Segment is named. Next you login as openCRX Root administrator (admin-Root) and execute the operation View > Reload. Click Yes to start the operation.

![img](files/DataImportExport/pic030.png)

__NOTE:__ Once the import is started you can close the browser, i.e. there is no need to keep the session alive until the import is completed. Some information regarding the progress of the import is written to the console.

__NOTE:__ In case you have data dependencies between/among your XML files (e.g. some files contain Contact data while others contain address data which is composite to Contact data) you should make sure that parent data are imported before child data gets imported. This should be relatively easy to achieve as XML files are imported in alphabetical order.

### Importing Excel Files (openCRX Accounts) ###
You can directly import Excel Sheets that contain field names in the first row and then data in the rows 2, 3, .... An example sheet is shown below:

![img](files/DataImportExport/pic040.png)

The following field attributes are supported by the importer wizard:

__XRI:__
	
(optionally) provide XRI of openCRX account to be updated; if there is no match with an existing account, a new one will be created

__DTYPE:__
(optionally) provide the type of openCRX account; values are: CONTACT, LEGALENTITY, GROUP, and UNSPECIFIEDACCOUNT

__TITLE:__
mapped to Contact.salutationCode (if the text can be located as a code value), otherwise mapped to Contact.salutation

__SALUTATION:__
mapped to Contact.salutation (a text field)

__FIRSTNAME:__
Contact.firstName

__MIDDLENAME:__
Contact.middleName

__LASTNAME:__
Contact.lastName

__ALIASNAME:__
Contact.aliasName (multi-locale support)

__NICKNAME:__
Contact.nickName

__SUFFIX:__
Contact.suffix

__COMPANY:__
__or COMPANY.en_US:__
__or COMPANY.de_CH:__
__etc.:__
based on the type of imported Account, the value is mapped to one of the following attributes (multi-locale support):

* Contact.organization
* LegalEntity.name
* Group.name
* UnspecifiedAccount.name

if the imported account is of type Contact and a matching account with name equal to COMPANY is found, then the imported Contact is made a member of the matching account; furthermore, COMPANYROLE is mapped to Member.member­Role and JOBTITLE is mapped to Member.description

__JOBTITLE:__
Contact.jobTitle

__DEPARTMENT:__
Contact.department

__BIRTHDAY:__
Contact.birthdate

the following formats are recognized:
dd-MM-yyyy, dd-MM-yy, MM/dd/yyyy, MM/dd/yy

__HOMEPHONE:__
Account.PhoneNumber.fullNumber (with usage = home)

__HOMEPHONE2:__
Account.PhoneNumber.fullNumber (with usage = other)

__HOMEFAX:__
Account.PhoneNumber.fullNumber (with usage = fax home)

__HOMEADDRESSLINE:__
Account.PostalAddress.postalAddressLine (usage = home)

by default, this is the main address; change the column header to HomeAddressLine?isMain=(boolean)false if this is not the main address

__HOMESTREET:__
Account.PostalAddress.postalStreet (usage = home)

__HOMECITY:__
Account.PostalAddress.postalCity (usage = home)

__HOMEPOSTALCODE:__
Account.PostalAddress.postalCode (usage = home)

__HOMESTATE:__
Account.PostalAddress.postalState (usage = home)

__HOMECOUNTRY or HOMECOUNTRYREGION:__
Account.PostalAddress.postalCountry (usage = home)

__BUSINESSPHONE:__
Account.PhoneNumber.fullNumber (with usage = business)

__BUSINESSPHONE2:__
Account.PhoneNumber.fullNumber (with usage = other)

__BUSINESSFAX:__
Account.PhoneNumber.fullNumber (with usage = fax business)

__BUSINESSADDRESSLINE:__
Account.PostalAddress.postalAddressLine (usage = business)

by default, this is the main address; change the column header to BusinessAddressLine?isMain=(boolean)false if this is not the main address

__BUSINESSSTREET:__
Account.PostalAddress.postalStreet (usage = business)

__BUSINESSCITY:__
Account.PostalAddress.postalCity (usage = business)

__BUSINESSPOSTALCODE:__
Account.PostalAddress.postalCode (usage = business)

__BUSINESSSTATE:__
Account.PostalAddress.postalState (usage = business)

__BUSINESSCOUNTRY:__ 
__BUSINESSCOUNTRYREGION:__
Account.PostalAddress.postalCountry (usage = business)

__MOBILEPHONE:__
Account.PhoneNumber.fullNumber (usage = mobile)

__EMAILADDRESS:__
Account.EMailAddress.emailAddress (usage = business)

__EMAIL2ADDRESS:__
Account.EMailAddress.emailAddress (usage = home)

__EMAIL3ADDRESS:__
Account.EMailAddress.emailAddress (usage = other)

__X500ADDRESS:__
Account.EMailAddress.emailAddress (usage = N/A, type X.500)

__WEBPAGE:__
Account.WebAddress.webUrl (usage = business)

__ASSISTANTSNAME:__
if a matching account with full name equal to ASSISTANTSNAME is found, then the matching account is made a member of the imported account; furthermore, ASSISTANTSNAMEROLE is mapped to Member.memberRole

__MANAGERSNAME:__
if a matching account with full name equal to MANAGERSNAME is found, then the imported account is made a member of the matching account; furthermore, MANAGERSROLE is mapped to Member.memberRole

__BUSINESSTYPE:__
Account.businessType

you can provide a list of business types (each business type on a separate line) – see drop down / code table for valid values

__NOTES:__
Account.description

__address\_AUTHORITY:__
the authority attribute allows you to define an “owner” of an address; this can be useful – for example – to designate the employer as the “owner” of an employee's addresses (e.g. while joe.doe@greatcompany.com is Joe's business e-mail address, the true “owner” is Joe's employer “great company” which also “owns” the domain greatcompany.com)

the following column headers are supported:

* HOMEPHONE_AUTHORITY
* HOMEPHONE2_AUTHORITY
* HOMEFAX_AUTHORITY
* BUSINESSPHONE_AUTHORITY
* BUSINESSPHONE2_AUTHORITY
* BUSINESSFAX_AUTHORITY
* MOBILEPHONE_AUTHORITY
* EMAILADDRESS_AUTHORITY
* EMAIL2ADDRESS_AUTHORITY
* EMAIL3ADDRESS_AUTHORITY
* X500ADDRESS_AUTHORITY
* WEBPAGE_AUTHORITY
* HOMEPOSTAL_AUTHORITY
* BUSINESSPOSTAL_AUTHORTY

__MEMBEROF:__
if a matching account with full name equal to MEMBEROF is found, then the imported account is made a member of the matching account; furthermore, MEMBERROLE is mapped to Member.memberRole (you can provide a semicolon-separated list of member roles (e.g. founder;owner;Board of Directors)

note: with this powerful feature you can establish relationships between accounts right at the time of importing accounts

it is possible to identify the parent account by specifying that account's extString0 content – simply prepend reference with the string “@#”, for example @#443

__MEMBERROLE:__
Member.memberRole (see MEMBEROF for more details)

__MEMBER:userString0:__
Member.userString0

__MEMBER:userString1:__
Member.userString1

__MEMBER:userString2:__
Member.userString2

__MEMBER:userString3:__
Member.userString3

__MEMBER:userCode0:__
Member.userCode0

__MEMBER:userCode1:__
Member.userCode1

__MEMBER:userCode2:__
Member.userCode2

__MEMBER:userCode3:__
Member.userCode3

__MEMBER:userNumber0:__
MEMBER.userNumber0

__MEMBER:userNumber1:__
MEMBER.userNumber1

__MEMBER:userNumber2:__
MEMBER.userNumber2

__MEMBER:userNumber3:__
MEMBER.userNumber3

__CATEGORIES:__
Account.category

you can provide a semicolon-separated list of categories (e.g. Business;Birthday;Xmas) and the importer will add all missing items to the list of categories contained in Account.category

__NOTECREATEDAT:__
date when note was created (format YYYYMMDD)

__NOTETITLE:__
creates or updates (if a note with the given title already exists) a note attached to the imported account; furthermore, NOTETEXT is mapped to the text attribute of the note

__NOTETEXT:__
see NOTETITLE

__generic / model-driven:__
the importer can also handle single-valued attributes of the types listed in the left-hand column in a generic / model-driven fashion; examples are:

* userString0, userString1, … , userString3
* userBoolean0, userBoolean1, …, userBoolean3
* userCode0, userCode1, …, userCode3
* userNumber0, userNumber1, …, userNumber3
* extString0, extString1, …
* extBoolean0, extBoolean1, …
* extCode0, extCode1, …
* extNumber0, extNumber1, ...

the importer also handles multi-valued code attributes:

* extCode20, extCode21, …

individual values for multi-valued attributes can be separated by a semicolon (“;”), e.g. 2;29;113;468

__Properties:__
the importer can also handle properties; the syntax for column headers is as follows:

	```
	<PropertyType>:<Name of PropertySet>!<Name of Property>
	```
	
where PropertyType is one of the following: BooleanProperty, IntegerProperty, DecimalProperty, StringProperty, UriProperty, DateProperty, DateTimeProperty or ReferenceProperty and both Name of PropertySet and Name of Property are strings

Example: StringProperty:DOCSYS!FileNumber

Field names supported by MS Outlook match the names produced if you export Contacts from MS Outlook to an Excel Sheet:

![img](files/DataImportExport/pic050.png)

The Importer produces a detailed on-screen report with clickable links and a summary report stating the total number of created/updated accounts:

![img](files/DataImportExport/pic060.png)

__NOTE:__  Before you launch an import of thousands of accounts, verify the structure of your Excel sheet with a few lines/accounts only.

### Importing vCard Files ( openCRX Contacts) ###
vCard is file format standard for personal data interchange, specifically electronic business cards (additional information is for example available from http://en.wikipedia.org/wiki/VCard).

These are the steps to import a vCard file:

* click on the provider Accounts and navigate to an existing Contact (or create a new one)
* select the operation File > Import vCard to unhide the import dialog:

![img](files/DataImportExport/pic070.png)

* select the appropriate language
* click the Browse button and navigate to the vCard file you want to import
* click the OK button to start the import operation

### Other Options ###
There are various other options to consider. You could for example develop a custom-tailored JSP Wizard to import data on demand or on a regular basis (e.g. controlled by the openCRX WorkflowController).

Sometimes it is more appropriate to develop a specific openCRX client to handle imports, and in a typical enterprise class environment you will probably consider developing adapters to connect/integrate openCRX with 3rd party systems on a real-time basis.

## Exporting Data from openCRX ##
The task of exporting data is handled by exporters. The Open Source distribution of openCRX includes exporters for vCard and iCalendar files in addition to the XML exporter.

This allows you to export contacts and meetings/sales visits or any other object from openCRX. vCard and iCalendar files can be imported by a large variety of other applications, including Microsoft Outlook. This chapter shows how to export data.

### Exporting XML Files ###
Navigate to the object to be exported as XML file and execute the operation File > Export Advanced as shown below:

![img](files/DataImportExport/pic080.png)

In order to better control which additional objects (composites, referenced objects, ...) the XLM exporter should export together with the object loaded in the Inspector, you can (optionally) provide a reference filter (optionally with a navigation level). By default, only the current object will be exported. If you provide – for example when export­ing a sales order – customer;address as a reference filter, the customer and all referenced addresses will be exported together with the main object. If you export a contact and provide the reference filter member[1] you will get direct members of this contact.

If the export is successful the exporter will terminate with status OK and you will be provided with a link to the file Export.zip containing the raw data:

![img](files/DataImportExport/pic090.png)

The openCRX ICS Adapter can also export iCalendars in XML format:

ICS URL (to get XML file with authentication):

	```
	http://<crxServer>:<Port>/opencrx-ical-<Provider>/activities?id=<Provider>/<Segment>/<Calendar Selector>&type=xml
	```	

__Example:__

	```
	http://localhost:8080/opencrx-ical-CRX/activities?id=CRX/Standard/tracker/main&type=xml
	```

You can also export the data contained in an openCRX grid to an XML file by executing _Actions > Export --> XML_ on any grid.

### Exporting Data to MS Excel / Open Office Calc Files ###
Navigate to the object to be exported as spreadsheet file and execute the operation File > Export Advanced as shown below:

![img](files/DataImportExport/pic100.png)

In order to better control which additional objects (composites, referenced objects, ...) the XLM exporter should export together with the object loaded in the Inspector, you can (optionally) provide a reference filter. By default, only the current object will be exported. If you provide – for example – :*/:* as a reference filter, all composites up to 2 levels deep will be exported together with the main object (this should be sufficient for most use cases). You can also provide a reference filter to dereference and export referenced objects like the customer or the salesRep of a sales order.

If the export is successful the exporter will terminate with status OK and you will be provided with a link to the file Export.xls containing the raw data:

![img](files/DataImportExport/pic110.png)

Based on such spreadsheet files end-users can easily create reports or do some ad-hoc data analysis without the need to know anything about Java or writing JSPs. The standard distribution of openCRX includes various example reports based on this technology.

You can also export the data contained in an openCRX grid to an Excel file by executing _Actions > Export --> XLS_ on any grid.

### Exporting openCRX Contacts (MS Excel Files) ###
These are the steps to manually export group of contacts to an Excel file:

* navigate to the account group you want to export
* start the wizard _Wizards > Manage Members_
* click the button _Export_

![img](files/DataImportExport/pic120.png)

* click on the spreadsheet icon to download the Excel file containing the exported accounts

__NOTE:__ The exported MS Excel file can be imported again. Hence, if you want to make bulk changes (e.g. change to domain of an e-mail address, etc.) you can first export the relevant accounts to an Excel file, make the desired changes in Excel and then reimport the Excel file with the Importer wizard).

### Exporting openCRX Contacts (vCard Files) ###
These are the steps to manually export a contact to a vCard file:

* navigate to the contact you want to export
* click on the tab Account
* select the contents of the field vCard and copy it to an empty text file
* save the text file with any name and extension “vcf”, e.g. contact.vcf:

![img](files/DataImportExport/pic130.png)

There is also a wizard vCard.jsp available which allows you to export individual accounts or batches of accounts as vCards.

Navigate to an Account and select _File > Save as vCard_ to start the export:

![img](files/DataImportExport/pic140.png)

In order to export multiple accounts as vCards, create a Saved Search that selects the desired accounts and then navigate to this Saved Search. Select _File > Save Filtered Accounts as vCard_:

![img](files/DataImportExport/pic150.png)

### Exporting openCRX Meetings (iCalendar Files) ###
These are the steps to export an individual activity (e.g. a meeting or a sales visit) to an iCalendar file:

* navigate to the meeting (or sales visit) you want to export
* click on the tab Details
* select the contents of the field iCal and copy it to an empty text file
* save the text file with any name and extension “ics”, e.g. meeting.ics:

![img](files/DataImportExport/pic160.png)

There is also a wizard iCal.jsp available which allows you to export individual activities or batches of activities as iCals.

Navigate to an Activity and select File > Save as iCal to start the export:

![img](files/DataImportExport/pic170.png)

In order to export multiple activities as iCals, navigate to an Activity Group (Activity Tracker, Category, Milestone), to a Saved Search (or to any other object that features a list of assigned activities like Userhome) and then select _File > Save Filtered Activities as iCal_ (Save Assigned Activities as iCal).

### Exporting openCRX Grids ###
Any openCRX Grid can be exported to an XML or an XLS file. The exporters are accessible through _Actions > Export → xxx_:

![img](files/DataImportExport/pic180.png)

Export Target  | Description
---------------|------------
XLS            | produces Excel Sheet that contains all the attributes of the exported objects
XLS (wysiwyg)  | produces Excel Sheet that contains visible attributes (see chapter “Selection of Visible Attributes – showMaxMember” in the openCRX Customizing guide) of the exported objects
XLS (wysiwyg+) | produces Excel Sheet that contains filterable attributes (see chapter “Selection of Filterable Attributes – maxMember” in the openCRX Customizing guide) of the exported objects 
XML            | produces XML file that contains all the attributes of the exported objects
XML+           | produces xml file that contains all the attributes of the exported objects and their composite objects

### Other Options ###
There are various other options to consider. You could for example develop a custom-tailored JSP Wizard to export data on demand or on a regular basis (e.g. controlled by the openCRX WorkflowController).

Sometimes it is more appropriate to develop a specific openCRX client to handle exports, and in a typical enterprise class environment you will probably consider developing adapters to connect/integrate openCRX with 3rd party systems on a real-time basis.

If you have a REST client available, then exporting via REST is also a very viable option.
