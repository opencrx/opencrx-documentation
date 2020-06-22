# How to use the Twitter Services #

openCRX features to support/connect to Twitter:

* OAuth (see http://oauth.net/ for more information)
* Support for consumer key and consumer secret; a wizard to create access token and access key. The openCRX implementation is based on the library twitter4j (see http://twitter4j.org for more information).
* Wizards to send direct messages and status updates
* Workflow to send alert notifications via Twitter

### Register with Twitter ###

Before openCRX can invoke the Twitter API, you need to register your instance of openCRX at http://twitter.com/oauth_clients/new to acquire a consumer key and a consumer secret. Register your openCRX instance as follows:

* Application Name: name of your openCRX instance, e.g. 'openCRX of MyCompany'
	* Application Website: the URL users can access the openCRX instance, e.g. https://crm.mycompany.com/opencrx-core-CRX
	* Application Type: Client
	* Default Access type: Read/Write
    * Use Twitter for login: false
* If registration is successful you should get a 'Consumer Key' and a 'Consumer Secret' for your application.
	* Login as admin-Root and navigate to Administration > Configuration.
    * Create a new component configuration with
    	* Name: Twitter
        * Qualifier: Twitter
    * Navigate to the newly created component configuration and add the following string properties:
        * CRX.OAuth.ConsumerKey: Twitter consumer key
        * CRX.OAuth.ConsumerSecret: Twitter consumer secret
    * Logout (Users are now able to setup Twitter accounts).

__NOTE:__ segment-specific tokens are configured using the pattern

	```
	<provider name>.<segment name>.OAuth.ConsumerKey
    <provider name>.<segment name>.OAuth.ConsumerSecret
	```
	
### Create Twitter Account ###

* Login as user, e.g. guest
* Twitter accounts are configured on a user's home in the tab _Service Accounts_. A Twitter account is created as follows:
	* Name: Twitter user display name
    * Active: true
    * Default: true
* Invoke the wizard 'Twitter - Create access token'. The wizard shows an URL and a field to enter a PIN code. Open the URL in a new browser window. This redirects you to Twitter asking to grant access for the openCRX instance. If you grant access a PIN code will be displayed. Enter the PIN code and click OK. If all goes well, the fields 'Access token key' and 'Access token secret' are set now.

### Using openCRX Wizards ###
On most objects the following two wizards are available:

__Twitter – Send Message:__
This wizard allows to send a message to a list of Twitter users. In addition the message text is attached as note and if you are invoking the wizard on an activity a follow up is created. Note that the message is only visible to the recipients.

__Twitter – Update Status:__
This wizard allows to for one of the configured Twitter accounts. Status updates are visible to all followers of the selected Twitter account.

### Using the SendDirectMessageWorkflow ###
The SendDirectMessageWorkflow works much the same way as the SendMailNotificationWorkflow. However, instead of sending an e-mail to the user in case of alert updates, the alert title including a tiny url pointing to the underlying openCRX object is sent as direct message to the default Twitter account of the subscribing user. The SegmentSetupWizard (can be executed by the segment administrator, e.g. admin-Standard) creates the required entries for the workflow and topic. Users simply need to subscribe to the topic Alert Modifications (Twitter).
