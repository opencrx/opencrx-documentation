# Configuring the Groupware Services #

openCRX features groupware services for Contacts, Calendars, E-Mail and Documents. The data is 
accessible by various protocols such as _WebDAV_, _CalDAV_, _CardDAV_, _AirSync_, _LDAP_ and _IMAP_.

## Directory Service / LDAP ##
openCRX provides LDAP Server functionality (get more information about LDAP or read what Wikipedia has to say about LDAP). In a nutshell this means that you can use any LDAP client to connect to openCRX and view openCRX accounts. openCRX LDAP supports SSL. Here is how to connect:

* __Host:__ IP address or host name of openCRX Server Examples: localhost, 127.0.0.1, myCrxServer.myCompany.com, etc.
* __Port:__ 1389 (note that the LDAP standard port is 389); if your LDAP client supports SSL (Thunderbird does, MS Outlook does not), you can enable SSL for increased privacy/protection. With SSL enabled you might want to change the port from 1389 to 1689
* __BaseDN:__ _ou=filter/\[filter name\],ou=Persons_. Example: _ou=filter/All Accounts,ou=Persons_
* __BindDN:__ _<principal>@<segment name>_. Example: _guest@Standard_

### Configuring the openCRX LDAP Port ###
The openCRX LDAP port is by default set to 1389 (to avoid conflicts with other LDAP daemons listening on the LDAP 
standard port 389). You can change this configuration in the file web.xml located in _opencrx-groupware-CRX.ear/opencrx-ldap-CRX.war/WEB-INF/_. Look for the param-name port. If you build your own EARs you can change the openCRX LDAP port in your project's file _build.properties_ (_ldap.listenPort_) or directly in your _build.xml_.

### Enabling SSL Support for LDAP ###
With the following steps you can enable SSL support for LDAP:

* Create cert and key with OpenSSL (e.g. server.key, server.crt)
* Convert cert and key to PEM format using OpenSSL:
	* Key: openssl rsa -in server.key -out server-key.pem -outform PEM
    * Cert: openssl x509 -in server.crt -out server-cert.pem -outform PEM
* Use a Java Keytool which allows you to a) create a keystore, b) import a certificate, c) import a private key. The following tools allow you to easily manage Java keystores:
	* Portecle: http://sourceforge.net/projects/portecle/
    * KeyTool IUI: http://yellowcat1.free.fr/keytool_iui.html
* Add the following init-param tags to the web.xml of the LDAPServlet (but don't forget to adapt the values according to your environment):

	```
	...
	  <init-param>
	    <param-name>sslKeystoreFile</param-name>
	    <param-value>/var/ssl/keystore.jks</param-value>
	  </init-param>
	  <init-param>
	    <param-name>sslKeystoreType</param-name>
	    <param-value>JKS</param-value>
	  </init-param>
	  <init-param>
	    <param-name>sslKeystorePass</param-name>
	    <param-value>changeit</param-value>
	  </init-param>
	  <init-param>
	    <param-name>sslKeyPass</param-name>
	    <param-value>changeit</param-value>
	  </init-param>
	...
	```

To avoid confusion, you might also want to change the port from 1389 (LDAP for openCRX) to 1689 (LDAPS for openCRX).

### Connecting Thunderbird ###
The following steps are required to configure Thunderbird 31 for LDAP:

* start Thunderbird and select the menu Tools > Options (on Windows) or Edit > Preferences (on Linux)
* select Composition and select the tab Addressing
* check Directory Server and click on the button _Edit Directories_

![img](31/Admin/files/GroupwareServices/pic010.png)

* in the dialog window LDAP Directory Servers click on the button _Add_
* populate the Directory Server Properties dialog as follows (the example entries are assuming the openCRX Server is at localhost, the provider is CRX and the Segment is Standard, connecting with Username guest):

Field                | Entry                              | Example
---------------------|------------------------------------|-----------------------
Name                 | any name you like                  | local-CRX.Standard _All Accounts_
Hostname             | host name or IP address            | localhost
Base DN              | ou=filter/\[filter name\],ou=Persons | ou=filter/All Accounts,ou=Persons
Port number          | 1389                               | 1389
Bind DN              | <principal>@<segment name>         | guest@Standard

* click _OK_ to accept

### Connecting MS Outlook ###
The following steps are required to configure MS Outlook 2007 for LDAP:

* start Outlook and select the menu Tools > Account Settings
* click on the tab Address Books
* populate the Add/Change E-mail Account dialog as follows (assuming the openCRX Server is at localhost, connecting with Username guest):
	* __Server Name:__ localhost
	* __This server...:__ check _This server requires me to log on_
	* __User Name:__ <principal>@<segment name>, e.g. guest@Standard
	* __Password:__ <enter your openCRX password for user guest>
* click on the button More Settings and select the tab Connection
* enter a display name (of your choice) and verify that port is set to 1389
* select the tab Search
* in the field group Search Base click on Custom and populate as follows: _ou=filter/All Accounts,ou=Persons_

![img](31/Admin/files/GroupwareServices/pic020.png)

* click OK, Next, Finish, and Close to conclude the configuration

## VCF Adapter ##
The openCRX VCF adapter makes contacts available to third-party clients.

### Account Selectors ###
openCRX can map sets of accounts to a VCARD file (a sequence of VCARDs). The resulting VCARD file can be imported and/or processed by vcard-enabled clients like Outlook, Thunderbird, etc. At this time, account filters are the only supported account selectors. Account filters support reading and updating, but not creating of accounts (R=read, U=update):

Use the openCRX Wizard _Connection Helper_ to generate valid VCF Selectors. You can start the wizard from a user's homepage:

![img](31/Admin/files/GroupwareServices/pic030.png)

### Connecting MS Outlook ###
Detailed instructions on how to connect MS Outlook are available from [here](http://www.opencrx.org/opencrx/2.4/Outlook_ICS_VCF_adapter.htm).

__IMPORTANT:__ Please note that this connector is no longer supported / maintained.

### Connecting Thunderbird ###
An add-on (supporting TB3 and newer) is available that enables you to connect Thunderbird. For more instructions see [here](http://www.opencrx.org/opencrx/2.10/Thunderbird_Contacts_Add-on.htm).

![img](31/Admin/files/GroupwareServices/pic040.png)

__IMPORTANT:__ Please note that this add-on is no longer supported / maintained. We recommend to use the CardDAV SOGo Connector.

## CardDAV Adapter ##
openCRX provides CardDAV Server functionality (get more information about CardDAV from Wikipedia or check out the RFC). Once a user has created a Card Profile he / she can connect to openCRX with any CardDAV client to retrieve / manage contacts. 
See [here](http://www.opencrx.org/faq.htm#CardDAVClients) for a list of clients tested with openCRX.

### Card Profiles ###
openCRX can map any account group to a CardDAV collection. Such a mapping is defined by an openCRX Card Profile. Each openCRX user has a default card profile called _Contacts_ which maps the user's private account group _<user>~Private_ (e.g. _guest~Private_) to a CardDAV collection. You can easily define additional CardDAV collections with the following steps:

* login
* expand the grid tab row _Alerts Times >>_ and then click on the tab _Sync Profiles_
* click on _New_ and select the entry Card Profile:

![img](31/Admin/files/GroupwareServices/pic050.png)

* enter a name (e.g. MyCardProfile) and click _New_
* in the grid _Sync Feeds_, select _New > Contacts Feed_
* check the box _Active_, enter a name for your new feed and select the account group that should be mapped to a CardDAV collection:

![img](31/Admin/files/GroupwareServices/pic060.png)

* with the wizard Connection Helper you can verify that your new feed is available:

![img](31/Admin/files/GroupwareServices/pic070.png)

Use the openCRX Wizard _Connection Helper_ to generate valid Contact Feed Selectors. You can start the wizard from any Card Profile or from your homepage:

![img](31/Admin/files/GroupwareServices/pic080.png)

### Connecting Thunderbird ###
Thunderbird itself does not support CardDAV, but you can use the Inverse SOGo Connector . It is available directly from Inverse's web site [here](http://www.sogo.nu/downloads/frontends.html). Once this add-on is installed, you can configure the connector as follows:

* start your browser and connect/login to openCRX
* on your user home, expand the grid tab _Alerts Timers [>>_ and then click on the tab _Sync Profiles_
* start the Connection Helper Wizard (from the menu Wizards)
* Choose the resource role _Profile_ and the selector type _Card Profile_ and then select the desired card profile, e.g. _Contacts_:

![img](31/Admin/files/GroupwareServices/pic090.png)

* start Thunderbird
* open Address Book and create a new Remote Address Book

![img](31/Admin/files/GroupwareServices/pic100.png)

* enter a name of your choice and then copy the CardDAV Collection URL from openCRX into the field URL (note that the Connection Helper Wizard shows the name of the card feed as a tooltip):

![img](31/Admin/files/GroupwareServices/pic110.png)

* click _OK_
* back in the list of address books, select any other address book than the new one just created
* next, select the newly created address book
* right-click the newly created address book and select _Synchronize_ from the context menu:

![img](31/Admin/files/GroupwareServices/pic120.png)

* the first time you connect a pop-up window requests authentication credentials; enter your openCRX username and password:

![img](31/Admin/files/GroupwareServices/pic130.png)

That's it. From now on your address book will be synchronized automatically every time you start Thunderbird.

__NOTE:__ The default formatting of contacts in the Thunderbird Address Book can be improved if you create a a file _userChrome.css_ in the folder _chrome_ (you might have to create this folder as well) in your Thunderbird profile (on Windows you should find your profile(s) in the folder _%AppData%/Thunderbird/Profiles_). Add the following to the file _userChrome.css_:

	```
	/*
	* Do not remove the @namespace line -- it's required for correct functioning
	*/
	@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
	/* set default namespace to XUL */
	
	.CardViewLink {
	max-width:300px;
	overflow:hidden;
	}
	```

Depending on your screen resolution you might change the value _300px_ to something more suitable.

## Calendaring ##

### Calendar as a Set of Activities ###
openCRX supports a wide range of types of activities, including E-Mails, Tasks, Meetings, Phone Calls, etc. Even though all activities are kept in a flat structure (think of a box containing all activities, regardless of type), openCRX offers a multitude of ways to structure, filter, and group activities:

* every activity can be assigned to activity groups, which enables you to group activities by Tracker, Category, and Milestone
* activities can be filtered with predefined filters (e.g. activities filtered to a user's homepage, activities filtered by resource) and user-defined ActivityFilters (either at a global level or at the level of an activity group)

To fully understand the power of this approach, consider a large project X (e.g. building a power plant) with millions and millions of activities. With openCRX, a project is typically mapped to an activity tracker (e.g. all activities of project X are assigned to the activity tracker Project X). As a large project is often times structured, i.e. broken down into subprojects, milestones, etc., let us assume that the respective subset of activities related to a milestone of Project X is assigned to an activity group Milestone 2. With openCRX, it's a single click and you can browse all the activities assigned to Milestone 2, or you can view all these activities in a calendar application like Sunbird or MS Outlook:

![img](31/Admin/files/GroupwareServices/pic140.png)

It goes without saying that different users have different needs. It is also quite natural that the needs change over time. With openCRX, it is easy to deliver as there are virtually unlimited possibilities to slice and dice the universe of activities. For example, instead of pulling a set of activities based on their assignment to activity groups, there are many use cases where one would like to define a filter to define a subset of activities. On the one hand, openCRX features lots of default filters, on the other hand, there are powerful tools to define custom filters virtually any way you like. For example: an auditor might be interested in all activities involving a particular subcontractor, another user could be interested in browsing through all the meetings related to Project X. Hence, in the context of calendaring it helps if you think of a calendar as a set of activities, nothing more and nothing less.

### Calendar Selectors (ICS and CalDAV) ###
openCRX can map each of the above-mentioned set of activities to a calendar. Depending on the mapping, the resulting calendar can be presented in various formats, e.g. ICS calendar, Free Busy calendar, XML file, Timeline, etc. Some typical ICS calendar selectors are listed below (R=read, U=update, C=create):

Set of Activities    | CRUD | ICS Calendar Selector
---------------------|------|-----------------------------------------------------
Tracker              | CRUD | _activities?id=<provider>/<segment>/tracker/<name>&type=ics_
Tracker (filtered)   | CRUD | _activities?id=<provider>/<segment>/tracker/<name>/filter/<filter name>&type=ics_
Category             | CRUD | _activities?id=<provider>/<segment>/category/<name>&type=ics_
Category (filtered)  | CRUD | _activities?id=<provider>/<segment>/category/<name>/filter/<filter name>&type=ics_
Milestone            | CRUD | _activities?id=<provider>/<segment>/milestone/<name>&type=ics_
Milestone (filtered) | CRUD | _activities?id=<provider>/<segment>/milestone/<name>/filter/<filter name>&type=ics_
Global Filter        | RU   | _activities?id=<provider>/<segment>/globalfilter/<activity filter name>&type=ics_
Homepage             | RU   | _activities?id=<provider>/<segment>/userhome/<home qualifier>&type=ics_
Resource             | RU   | _activities?id=<provider>/<segment>/resource/<resource name>&type=ics_
Birthdays            | RU   | _bdays?id=<provider>/<segment>/filter/<account filter name>&type=ics_
Anniversaries        | RU   | _anniversaries?id=<provider>/<segment>/filter/<account filter name>&type=ics_
Dates of Death       | RU   | _datesofdeath?id=<provider>/<segment>/filter/<account filter name>&type=ics_

Use the openCRX Wizard _Connection Helper_ from your Homepage to generate valid Calendar Selectors:

![img](31/Admin/files/GroupwareServices/pic150.png)

Choose the option _Events / Tasks_ and then make your selections:

![img](31/Admin/files/GroupwareServices/pic160.png)

By default, at most 500 activities (VEVENT or VTODO) are returned per request by the ical servlet. You can increase that limit by creating component configurations with name and qualifier ICalServlet (as admin-Root) and then adding a String property named maxActivities with the desired value, e.g. 5000 as shown below:

![img](31/Admin/files/GroupwareServices/pic170.png)

The CalDAV-Servlet does not have any such restriction.

CalDAV calendar selectors look as follows (R=read, U=update, C=create):

Set of Activities    | CRUD | ICS Calendar Selector
---------------------|------|-----------------------------------------------------
Tracker              | CRUD | _<provider>/<segment>/tracker/<name>_
Tracker (filtered)   | CRUD | _<provider>/<segment>/tracker/<name>/filter/<filter name>_
Category             | CRUD | _<provider>/<segment>/category/<name>_
Category (filtered)  | CRUD | _<provider>/<segment>/category/<name>/filter/<filter name>_
Milestone            | CRUD | _<provider>/<segment>/milestone/<name>_
Milestone (filtered) | CRUD | _<provider>/<segment>/milestone/<name>/filter/<filter name>_
Global Filter        | RU   | _<provider>/<segment>/globalfilter/<activity filter name>_
Homepage             | RU   | _<provider>/<segment>/userhome/<home qualifier>_
Resource             | RU   | _<provider>/<segment>/resource/<resource name>_

CalDAV calendar selectors return either only VEVENT items or only VTODO items - it is not possible for a CalDAV collection (by design) to contain both types at the same time. By default, openCRX returns VEVENT items, if you want to get VTODO items, you can append the suffix “/VTODO” to the above CalDAV calendar selectors. Example:

* VEVENT only: _<provider>/<segment>/tracker/<name>_
* VTODO only: _<provider>/<segment>/tracker/<name>/VTODO_

Also note that this behavior of CalDAV calendar selectors is different from the behavior of ICS calendar selectors. The latter can return both types of items, i.e. VEVENT and VTODO, as a reply to the same request, whereas the CalDAV calendar selector can only return either VEVENT or VTODO (by design of the CalDAV protocol, i.e. this is not a choice made by the openCRX developers).

One of the consequences is that if you work with CalDAV you need to define 2 calendars per selector with clients like Lightning (1 calendar for VEVENT and 1 for VTODO), whereas you get away with defining 1 calendar if you work with ICS (because it contains both VEVENT and VTODO items).

Use the openCRX Wizard “Connection Helper” from your Homepage to generate valid Calendar Selectors:

![img](31/Admin/files/GroupwareServices/pic180.png)

The wizard can also build URLs for CalDAV Event / Task collections that you can use to easily connect CalDAV clients capable of dealing with collections (e.g. iOS-devices, Android, etc.).

###  ActivityTracker/-Creators <username>~Private ###
Each openCRX user has a private Activity Tracker <username>~Private (e.g. guest~Private for the user named guest) and several private Activity Creators:

* _<username>~Private_ to create Incidents
* _<username>~Private~E-Mails_ to create E-Mail Activities
* _<username>~Private~Meetings_ to create Meetings
* _<username>~Private~Tasks_ to create Tasks

Activities created with one of the above Activity Creators are automatically assigned to the respective user's Activity Tracker _<username>~Private_ and security is set such that only the respective user can browse/update such activities.

### Mapping of Activities to Calendar Events and Tasks ###
Both the openCRX VCF adaptor and the openCRX CalDAV adaptor map openCRX activities to calendar events (VEVENT) and tasks (VTODO) as follows based on the openCRX activity class and the iCal type at hand:

Activity Class    | iCal Type | Mapped to
------------------|-----------|---------------------------------------------------
* (any)           | VEVENT    | VEVENT
* (any)           | VTODO     | VTODO
Incident          | Automatic | VEVENT
Meeting           | Automatic | VEVENT
Sales Visit       | Automatic | VEVENT
Task              | Automatic | VTODO
Phone Call        | Automatic | VEVENT
E-Mail            | Automatic | VEVENT
Mailing           | Automatic | VEVENT
Absence           | Automatic | VEVENT
External Activity | Automatic | VEVENT

The openCRX AirSync Adapter uses a different mapping (see chapter 10.2 Mapping of openCRX Objects to AirSync Objects for details).

Hence, all openCRX activities correspond to either calendar events (VEVENT) or tasks (VTODO). An openCRX activitiy's iCal representation is stored in the iCal attribute:

![img](31/Admin/files/GroupwareServices/pic190.png)

In the openCRX standard GUI the same activity is presented as follows:

![img](31/Admin/files/GroupwareServices/pic200.png)

#### Conversions between VEVENT and VTODO ####
Many calendar applications differentiate between events (entries in a calendar with well-defined start and end date) and tasks or to-dos (entries in a task list with a well-defined due date). openCRX also supports this distinction and can even convert activities from VEVENT to VTODO and vice versa without loss of information. To convert an openCRX activity from one type to the other, edit the activity and change the value of the iCal type dropdown:

![img](31/Admin/files/GroupwareServices/pic210.png)

### Calendaring / Free Busy ###
Free Busy is part of the iCalendar standard (RFC 2445) for calendar data exchange (see also Wikipedia). Many calendar clients rely on this information for group scheduling. openCRX can derive free busy information on-the-fly from the respective activities; as most clients do not support authentication the default configuration of the openCRX ical servlet does not require authentication to retrieve Free Busy information. However, the principal guest must exist (but you can disable the login):

Free Busy URL (without authentication, requires openCRX principal guest):

	```
	http://<host>:<port>/opencrx-ical-<Provider>/freebusy?id=<Provider>/<Segment>/<Calendar Selector>
	```

Please note that free busy information is provided by the openCRX server in a read-only fashion (i.e. free busy clients cannot update such information).

Instead of the user name you can also provide the e-mail of the respective user, for example

	```
	http://localhost:8080/opencrx-ical-CRX/freebusy?id=CRX/Standard/userhome/guest@opencrx.org
	```

If you prefer authentication for Free Busy clients you can add the url-pattern / freebusy to the web-resource-collection (in the file web.xml of the ical servlet).

openCRX calculates/derives the free busy information for each activity on the fly based on the following algorithm:

If the requesting user has at least one resource assignment with workingUnitPercentage > 0 then TRANSP=OPAQUE, otherwise TRANSP=TRANSPARENT.

TRANSP is managed by the CalDAV, ICS and FREEBUSY servlets. The attribute TRANSP TRANSP is mapped to the activity's assigned resources.

See [here](http://www.opencrx.org/faq.htm#FreeBusyClients) for a list of clients tested with openCRX.

#### Connecting Thunderbird/Lightning ####
Thunderbird supports free busy if the following add-ons are installed:

* Lightning (at least v1.0)
* Free/Busy (at least v2.0)

For detailed information on how to configure Thunderbird's Free / Busy add-on, please refer to the information provided by the respective developer. With version 2.0 of this add-on one can specify a pattern for both e-mail addresses and URLs to retrieve the free busy data from, e.g.:

* e-mail address pattern: _*@opencrx.org_
* URL pattern: _http://demo.opencrx.org/opencrx-ical-CRX/freebusy?id=CRX/Standard/userhome/*_

![img](31/Admin/files/GroupwareServices/pic220.png)

Once the Free/Busy add-on is configured, it will retrieve free busy information directly from your openCRX server whenever you invite attendees:

![img](31/Admin/files/GroupwareServices/pic230.png)

#### Connecting MS Outlook ####
See [here](http://support.microsoft.com/kb/291621). Please note that Outlook does not support SSL with free busy.

#### Free Busy Information as an ICS calendar ####
It is also possible to view the free busy information in the form of an ICS calendar. This may be useful for users who frequently plan events on behalf of another user without access to the full calendar of that person. Given a free busy URL you simply add &type=ics to retrieve the respective ICS calendar:

Free Busy URL as an ICS calendar:

	```
	http://<crxServer>:<Port>/opencrx-ical-<Provider>/freebusy?id=<Provider>/<Segment>/<Calendar Selector>&type=ics
	```

__Example:__

	```
	http://localhost:8080/opencrx-ical-CRX/freebusy?id=CRX/Standard/userhome/guest&type=ics
	```

The free busy ICS calendar is read-only and the title of events is set to ***, description and location are not available for privacy reasons.

### Calendaring / iCalendar (ICS) ###
iCalendar is implemented/supported by a large number of products (see RFC 2445 or Wikipedia for information about the iCalendar standard, sometimes referred to as “iCal”). openCRX can derive iCalendar information on-the-fly from the respective activities. iCal clients must authenticate to read and/or write iCalendar data.

ICS URL (with authentication):

	```
	http://<crxServer>:<Port>/opencrx-ical-<Provider>/activities?id=<Provider>/<Segment>/<Calendar Selector>&type=ics
	```

__Example:__

	```
	http://localhost:8080/opencrx-ical-CRX/activities?id=CRX/Standard/tracker/main&type=ics
	```

Please note that read-only calendars do not support creation of new events / tasks with external ICS clients. The reason being that without a well-defined ActivityCreator associated with the respective calendar selector it is not possible to create an activity and assign it to the appropriate activity groups.

While the mapping of most of openCRX's activity attributes to iCal attributes is obvious, the following hints might still be helpful:

__VEVENT:__

* Activity.disabled==true → STATUS:CANCELLED
* Activity.percentComplete==0 → STATUS:TENTATIVE
* percentComplete>0 → STATUS:CONFIRMED

__VTODO:__

* Activity.disabled==true → STATUS:CANCELLED
* Activity.percentComplete==0 → STATUS:NEEDS-ACTION
* Activity.percentComplete>0 → STATUS:IN-PROCESS
* Activity.percentComplete==100 → STATUS:COMPLETED

Please note that Activity.percentComplete cannot be changed upon import of a vCard as openCRX activities are managed by activity processes. Hence, changing the status of an activity outside of openCRX does not change the status of this activity in openCRX (even if it is reimported).

### Connecting Thunderbird / Lightning and Sunbird ###
Thunderbird with the Lightning add-on (or Sunbird, the stand-alone client) is a fully-fledged calendar client. Creating a remote calendar (hosted on your openCRX server) is rather straightforward:

* start Thunderbird/Lightning or Sunbird
* select the menu File > New Calendar
* in the dialog window Create New Calendar you select On the Network
* then you select iCalendar (ICS)
* enter an ICS URL into the field Location

__Example:__
The user guest would connect to this openCRX homepage with the URL 

	```
	http://127.0.0.1:8080/opencrx-ical-CRX/activities?id=CRX/Standard/userhome/guest&type=ics
	```

* give your calendar a name and pick a color of your choice
* That's it. You are connected to openCRX.

![img](31/Admin/files/GroupwareServices/pic240.png)

Thunderbird / Lightning and Sunbird require a life connection to openCRX (i.e. no support for offline viewing/editing) unless you enable the experimental Cache of Ligthning / Sunbird.

#### Connecting MS Outlook ####
Out of the box MS Outlook does not offer you much choice with ICS calendars. You are stuck with one of the following 2 options:

* Published Calendars: are local calendars published to a remote location, but there is no sync with that remote calendar (i.e. changes to the remote calendar will never automatically make it back into your Outlook)
* Internet Calendar Subscription: These calendars are striclty read-only in Outlook, i.e. not very useful.

Not to leave you out in the rain, we put together a bunch of VBA scripts that teach your Outlook a few new tricks. The scripts and detailed instructions for both MS Outlook 2003 and MS Outlook 2007 are available from [here](http://www.opencrx.org/opencrx/2.4/Outlook_ICS_VCF_adapter.htm).

![img](31/Admin/files/GroupwareServices/pic250.png)

#### Connecting iPhone ####
on your iPhone home screen, tap the icon Settings

* tap on Mail, Contacts, Calendars
* tap on Add Account...
* tap on Other
* tap on Add Subscribed Calendar
* enter or paste the ICS URL into the field Server
* tap _Next_ to verify the account information

If you get a message _Cannot Connect Using SSL_ tap _No_ to move on to the next screen where you can enter the connection details.

* verify/complete your subscription information as follows:
	* Server: verify the ICS URL
	* Description: any text you like (default is the ICS URL)
	* Username: your openCRX user name
	* Password: your openCRX password
	* Use SSL: if you use SSL, set to _ON_, otherwise _OFF_
	* Remove Alarms: as you prefer

![img](31/Admin/files/GroupwareServices/pic260.png)

* tap _Next_
* if you use SSL in combination with a self-signed certificate, you will get a message Unable to Verify Certificate --> tap Accept
* if everything works out, you can tap Save to store the settings and your calendar will be available in the Calendar App from the iPhone's home screen

This ICS calendar feature is particularly useful to connect your iPhone to a birthday calendar generated by openCRX (use the wizard “Connection Helper” to calculate the URL (server name respectively) for any desired Account Filter:

![img](31/Admin/files/GroupwareServices/pic270.png)

####  Deleting Events ####
The openCRX ICS Adapter does not support deleting events (because deleting objects is typically not an acceptable operation in an enterprise environment). openCRX does support disabling of objects, however. If there is a need to disable events directly from your ICS Client, here is how to do it:

* Assuming you have a remote calendar CAL with the URL <U> defined in your ICS client, define a new remote calendar CAL-trash with the URL <U>&disabled=true (i.e. append the string “&disabled=true” to the URL); the name of the calendar is not important, we just call it “CAL-trash” to indicate that it contains disabled activities.

__Example:__
Existing calendar CAL (showing only events that are not disabled) with the URL

	```
	http://127.0.0.1:8080/opencrx-ical-CRX/activities?id=CRX/Standard/userhome/guest&type=ics
	```
	
The URL of the calendar CAL-trash showing events that are disabled is

	```
	http://127.0.0.1:8080/opencrx-ical-CRX/activities?id=CRX/Standard/userhome/guest&type=ics&disabled=true
	```	

* To delete an event of your calendar CAL, move the event from the calendar CAL to the calendar CAL-trash

#### iCalender Guard Event ####
If you retrieve an iCalender from the openCRX ICS Adapter, the very first event is a so-called Guard Event:

* the Guard Event is always the first event delivered by the ICS Adapter
* the attribute SUMMARY corresponds to the Calendar-ID (UID of the Guard Event)
* the attribute DTSTART is set to 19000101T000000Z

The openCRX ICS Adapter supports the creation of new events/tasks as long as a calendar's Guard Event is posted to the adapter together with the new event/task. The openCRX ICS Adapter also verifies the UID of the Guard Event.

### Calendaring / CalDAV ###
CalDAV is implemented/supported by a growing number of products (see http://caldav.calconnect.org/ or Wikipedia for information about the CalDAV standard). openCRX is a fully-fledged CalDAV server; the functionality is implemented by a native CalDAV servlet. CalDAV clients must authenticate to read and/or write CalDAV data.

CalDAV URL for individual calendar:

	```
	http://<host>:<port>/opencrx-caldav-<Provider>/<Provider>/<Segment>/<Calendar Selector>
	```

__Example:__

	```
	http://localhost:8080/opencrx-caldav-CRX/CRX/Standard/tracker/main
	```

CalDAV URL for CalDAV calendar collection:

	```
	http://<host>:<port>/opencrx-caldav-<Provider>/<Provider>/ <Segment>/user/<principal name>/profile/<Calendar Profile>
	```

__Example:__

	```
	http://localhost:8080/opencrx-caldav-CRX/CRX/Standard/user/guest/profile/MyCals
	```

Please note that read-only calendars do not support creation of new events / tasks with external CalDAV clients. The reason being that without a well-defined ActivityCreator associated with the respective calendar selector it is not possible to create an activity and assign it to the appropriate activity groups.

In the case of calendar collections / profiles, it depends on the feed whether the respective calendar supports activity creation or not. If openCRX can determine a well-defined ActivityCreator, activity creation is supported, otherwise not.

Beware of CalDAV clients that do not provide feedback if a write operation did not succeed (the iPhone is unfortunately not very user-friendly in that respect). If you create a new event (or change an existing one) with your CalDAV client and the write operation does not succeed, you might still see your new event (or the changes to the existing event respectively) in your CalDAV client but such data is not available on the server!

#### CalDAV Collections ####
Some CalDAV clients (e.g. Apple's iPhone, CalDAV-Sync for Android) support CalDAV collections. With openCRX you can define CalDAV collections as follows:

* navigate to a user's homepage
* click on the tab _Sync Profiles_ and select _New > Calendar_ Profile:

![img](31/Admin/files/GroupwareServices/pic280.png)

* enter at least a name for your new collection, e.g. MyCals, and then click _New_
* navigate to this new calendar profile and then add the desired feed(s), e.g. an Activity Tracker or an Activity Filter, as follows:
* select New > Activity Group Calendar Feed as shown below:

![img](31/Admin/files/GroupwareServices/pic290.png)

select an activity group and enter at least a name for this feed and mark it as active (some CalDAV clients support coloring, i.e. you can optionally also enter color information):

![img](31/Admin/files/GroupwareServices/pic300.png)

* click _New_
* optionally, add more feeds (you can also add additional feeds later)

#### Connectingh Thunderbird / Lightning and Sunbird ####
Thunderbirdwith the Lightning add-on is a fully-fledged calendar client. Creating a remote calendar (hosted on your openCRX server) is rather straightforward:

* start Thunderbird/Lightning
* select the menu _File > New Calendar_
* in the dialog window Create New Calendar you select On the Network
* then you select CalDAV
* enter a CalDAV URL into the field Location

__Example:__
The user guest would connect to this openCRX homepage with the URL 

	```
	http://127.0.0.1:8080/opencrx-caldav-CRX/CRX/Standard/userhome/guest
	```
		
__NOTE:__ Lightning does not support CalDAV Collections, i.e. you must create a new Lightning calendar for each openCRX calendar.


* give your calendar a name and pick a color of your choice
* that's it – you are connected to openCRX

#### Connecting MS Outlook ####
MS Outlook is a client for MS Exchange and as such does not support CalDAV. There are third-party extensions you might want to try. Some of them are listed [here](http://wiki.davical.org/w/CalDAV_Clients/Outlook).

See also [here](http://www.opencrx.org/opencrx/2.4/Outlook_ICS_VCF_adapter.htm), although this adapter is not supported anymore.

#### Connecting iPhone ####
Connect to any openCRX calendar collection as follows with your iPhone:

* start the wizard Connection Helper: AirSync / Calendar / vCard from your openCRX homepage
* select _Profiles_ and _Calendar Profiles_ and then your CalDAV collection, e.g. _Calendars_ - the wizard automatically _calculates_ the CalDAV URL required to connect:    

![img](31/Admin/files/GroupwareServices/pic310.png)

* copy the above URL (you'll need to paste it later)
* on your iPhone home screen, tap the icon Settings
* tap on Mail, Contacts, Calendars
* tap on Add Account...
* tap on Other
* tap on Add CalDAV Account
* and then enter or paste the CalDAV URL into the field Server and populate the fields User Name and Password as shown below:
* tap _Next_ to verify the account information

![img](31/Admin/files/GroupwareServices/pic320.png)

If you get a message _Cannot Connect Using SSL_ tap _No_ to get to the next screen and then enter the connection details.

* verify/complete your subscription information as follows:
	* Server: verify the ICS URL
	* Description: any text you like (default is the ICS URL)
	* Username: your openCRX user name
	* Password: your openCRX password
	* Use SSL: if you use SSL, set to _ON_, otherwise _OFF_
	* Port: port number (Tomcat)
	* Account URL: the CalDAV URL

![img](31/Admin/files/GroupwareServices/pic330.png)

![img](31/Admin/files/GroupwareServices/pic340.png)
	
* if you use SSL in combination with a self-signed certificate, you will get a message Unable to Verify Certificate --> tap Accept
* if everything works out, you can tap Save to store the settings and your calendar will be available in the Calendar App from the iPhone's home screen

#### Connecting Android ####
Android does not support CalDAV out of the box, but there are applications available from the Android Market (search for _CalDAV_ in the Android Market to locate them). We have tested “CalDAV-Sync” and it works like a charm. It even supports CalDAV collections, so it's fairly easy to configure.

#### Deleting Events ####
The CalDAV protocol supports deletion of events/tasks. openCRX honors such requests, although the respective activity is disabled and not deleted. If you absolutely want to delete an activity you can do so with the openCRX standard GUI.

## Mailstore / IMAP ##
Instead of offering platform specific plugins for a multitude of mail clients like MS Outlook, MS Outlook Express, Thunderbird, Evolution, Eudora, Elm, etc. openCRX features a platform neutral IMAP adapter (get more information about IMAP or read what Wikipedia is saying about IMAP). The advantages of such a standardized IMAP adapter are:

* works with any IMAP client (including your favorite one)
* no clumsy installation of plugins, i.e. you can get this to work on your company's laptop regardless of how “hardened” and locked down the system is
* supports single message import and bulk import
* imports headers, body, and attachments
* automatically creates references to sender and recipient(s) if the respective e‑mail addresses are present in openCRX

In a nutshell this means that you can use any IMAP client to connect to openCRX and view openCRX EMailActivities. openCRX activity groups are mapped to IMAP folders. The folders contain openCRX EMailActivities.

Viewing/exporting of EmailActivities is always possible, creating/updating of EmailActivities requires that an E-Mail Activity Creator is defined for the respective Activity Group, and deleting of EmailActivities is not supported.

__NOTE:__ If you move an e-mail message from a non-openCRX IMAP folder to an openCRX IMAP folder and the target folder does not have a valid E-Mail Activity Creator defined, openCRX will not be able to create an EMailActivitiy in that folder. Due to the move operation the message is deleted from the source folder and your e‑mail message is lost. Hence, it is good practice to copy (and not move) e-mails to openCRX IMAP folders. Only after verifying that the EMailActivitiy was actually created by openCRX in the target folder is it safe to delete the message from the source folder.

__IMPOTANT:__ E-mail addresses should be unique!
If you import e-mails into openCRX with the IMAP Adapter, openCRX tries to match sender and recipients based on e-mail addresses. For obvious reasons, this will produce unexpected (if not undesired) results if e-mail addresses in openCRX are not unique.

You can test your openCRX database for duplicate e-mail addresses with the following query:

	```
	SELECT email_address, count(*)
	FROM OOCKE1_ADDRESS
	GROUP BY email_address HAVING count(*) > 1
	```

__NOTE:__ Since openCRX v2.9.1, unknown e-mail addresses are created as composites of the segment administrator, e.g. admin-Standard.

The following information is required to connect an IMAP client to openCRX:

* __Host:__ IP address or host name of openCRX Server. Examples: _localhost_, _127.0.0.1_, _myCrxServer.myCompany.com_, etc.
* __Port:__ 1143 (note that the IMAP standard port is 143)
* __User name:__ _<login principal name>@<Segment>_. Example: _guest@Standard-
* __Password:__ principal's openCRX password

The openCRX IMAP adapter supports SSL. It is probably a good idea to make use of that feature and connect your IMAP client securely to openCRX.

### Configuring the openCRX IMAP Port ###
The openCRX IMAP port is by default set to 1143 (to avoid conflicts with other IMAP daemons listening on the IMAP standard port 143). You can change this configuration in the file web.xml located in the directory _opencrx-core-CRX\opencrx-imap-CRX\WEB-INF\_. Look for the the param-name port.

If you build your own EARs you can change the openCRX LDAP port in your project's file build.properties (imap.listenPort) or directly in your build.xml.

### Configuring the IMAP Maildir Cache ###
For increased performance the openCRX IMAP Adapter works with a cache. The location of this cache, the so-called Maildir, can be set as a JAVA_OPTS.

You can reset the cache by deleting it. The openCRX IMAP Adapter will recreate the cache automatically.

__Example:__
Add the option -Dorg.opencrx.maildir="%CATALINA_HOME%\maildir" to the JAVA_OPTS in your Tomcat start batch file (e.g. tomcat.bat, run.sh, etc.).

### Enabling SSL Support for IMAP ###
With the following steps you can enable SSL support for IMAP:

* Create cert and key with OpenSSL (e.g. server.key, server.crt)
* Convert cert and key to PEM format using OpenSSL:
	* Key: openssl rsa -in server.key -out server-key.pem -outform PEM
    * Cert: openssl x509 -in server.crt -out server-cert.pem -outform PEM
* Use a Java Keytool which allows you to a) create a keystore, b) import a certificate, c) import a private key. The following tools allow you to easily manage Java keystores:
	* Portecle: http://sourceforge.net/projects/portecle/
    * KeyTool IUI: http://yellowcat1.free.fr/keytool_iui.html
* Add the following init-param tags to the web.xml of the IMAPServlet (but don't forget to adapt the values according to your environment):

	```
	...
	  <init-param>
	    <param-name>sslKeystoreFile</param-name>
	    <param-value>/var/ssl/keystore.jks</param-value>
	  </init-param>
	  <init-param>
	    <param-name>sslKeystoreType</param-name>
	    <param-value>JKS</param-value>
	  </init-param>
	  <init-param>
	    <param-name>sslKeystorePass</param-name>
	    <param-value>changeit</param-value>
	  </init-param>
	  <init-param>
	    <param-name>sslKeyPass</param-name>
	    <param-value>changeit</param-value>
	  </init-param>
	...
	```

* to avoid confusion, you might also want to change the port from 1143 (IMAP for openCRX) to 1443 (IMAPS for openCRX).

#### Connecting Thunderbird ####
The following information is required to configure an IMAP account:

* __Email account:__ <login principal name>@<Segment>. Example: guest@Standard
* __Password:__ openCRX password of the respective principal
* __Your name:__ <login principal name>@<Segment>. Example: guest@Standard
* __Email Address:__ your e-mail address. Example: guest@mycompany.com
* __Type of server:__ IMAP
* __Incoming Server:__ name or IP address of your openCRX server. Example: 127.0.0.1
* __Outgoing Server:__name or IP address of your openCRX server. Example: 127.0.0.1
* __Port:__ 1143
* __Incoming User Name:__ <login principal name>@<Segment>. Example: guest@Standard

![img](31/Admin/files/GroupwareServices/pic350.png)

If you move an e-mail message from a non-openCRX IMAP folder to an openCRX IMAP folder and the target folder does not have a valid E-Mail Activity Creator defined, openCRX will not be able to create an EMailActivitiy in that folder. Due to the move operation the message is deleted from the source folder in your IMAP client and your e-mail message will be lost. Hence, it is good practice to copy (and not move) e-mails to openCRX IMAP folders. Only after verifying that the EMailActivitiy was actually created by openCRX in the target folder is it save to delete the message from the source folder.

#### Connecting MS Outlook ####
The following steps are required to configure MS Outlook 2007 for IMAP:

* __Email account:__ <login principal name>@<Segment>. Example: guest@Standard
* __Password:__ openCRX password of the respective principal
* __Your name:__ <login principal name>@<Segment>. Example: guest@Standard
* __Email Address:__ your e-mail address. Example: guest@mycompany.com
* __Account Type:__ IMAP
* __Incoming Server:__ name or IP address of your openCRX server. Example: 127.0.0.1
* __Outgoing Server:__name or IP address of your openCRX server. Example: 127.0.0.1
* __Incoming Port:__ 1143
* __Incoming User Name:__ <login principal name>@<Segment>. Example: guest@Standard

![img](31/Admin/files/GroupwareServices/pic360.png)
