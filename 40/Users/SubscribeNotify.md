# How to use the Subscribe / Notify Services #

openCRX features a powerful event subscription and notification service:

![img](Users/files/SubscribeNotify/pic010.png)

Once a topic is created, openCRX users can subscribe to it. Users manage their subscriptions individually on their UserHomes (with the Wizard UserSettings or by editing their subscriptions manually). If a topic has subscribed users and a monitored event occurs then the predefined actions are performed. If the action is set to – for example – creating an alert for subscribed users, then each subscribed user will receive an alert on the UserHome.

__IMPORTANT:__ Please note that event and notification services depend on the Servlet SubscriptionHandler, i.e. you must turn on the openCRX Subscription Handler for the respective segment with the Workflow Controller, otherwise Topic Actions are not executed, i.e. no Alerts will be created and E‑mail Notifications will not be delivered.

__IMPORTANT:__ Furthermore, outbound E-Mail Services must be configured (see chapter 8.1 Install and Configure Mail Resource and E-Mail Services) and you must activate the Workflow Handler (see chapter 6.5 Servlet WorkflowHandler) to receive E-Mail Notifications.

The openCRX distribution includes quite a few default topics (see Figure 35: Standard Topics included in the openCRX distribution) to get you started:

* Topic Account Modifications sends an alert to subscribed users whenever an account is modified.
* Topic Activity Follow Up Modifications sends an alert to subscribed users whenever a Follow Up of an Activity is modified.
* Topic Alert Modifications sends an e-mail notification to subscribed users – assuming outbound e-mail services are configured correctly – whenever an Alert is created/modified.

__IMPORTANT:__ Please note that newly created Segments do neither contain Workflow Processes nor Topics (i.e. the respective grids are empty). Both Workflow Processes and Topics can be created by the segment administrator with the wizard Segment Setup.

![img](Users/files/SubscribeNotify/pic020.png)

Users can easily custom-tailor their subscriptions with filters and by selecting event types like Object Creation, Object Replacement, and Object Removal.

## Example Subscription - Account Modifications ##
In this example we will create a subscription to the standard Topic Account Modifications for the user “guest”.

* Login as guest, and execute the operation Edit > User Settings to start the respective wizard. Check both “Is Active” and “Creation” as shown below:

![img](Users/files/SubscribeNotify/pic030.png)

* Click the button _Save_ to store your settings.

__IMPORTANT:__Please note that the Root administrator must start the Subscription Handler – otherwise you will not get any Alerts/Notifications.

## Example Subscription – Activity Assignment Changes ##
With the following steps you can create a subscription to activity assignment changes:

* navigate to your Userhome and create a new Subscription
* populate the fields as follows:
	* Name:	Activities assigned to me
    * Description:	(any description you like)
    * Active: checked
    * Event type: (leave empty)
    * Topic: select Activity Modifications
    * Name of filter #0: assignedTo
    * Value of filter #0: copy the Identity of the respective user's homepage
* save your subscription

## Example Subscription with Filtering ##
In combination with openCRX security the subscription filter feature enables you to provide highly specific subscriptions. Imagine the following situation: there are 2 Activity Trackers DivisionA:ProjectX and DivisionA:ProjectY and some of your users are interested in receiving notifications related to activities of ProjectX only, whereas some users want to receive notifications related to activities of ProjectY only. A third group of users wants to receive notifications from both projects. Such a situation could be handled as follows:

* create a PrincipalGroups DivisionA.ProjectX and DivisionA.ProjectY
* assign PrincipalGroup DivisionA.ProjectX to ActivityTracker DivisionA:ProjectX; like this new activities assigned to this Tracker will also be assigned the PrincipalGroup DivisionA.ProjectX
* assign PrincipalGroup DivisionA.ProjectY to ActivityTracker DivisionA:ProjectY; like this new activities assigned to this Tracker will also be assigned the PrincipalGroup DivisionA.ProjectY
* an Activity Modification subscription of a user wanting notifications related to ProjectX and ProjectY would look as follows:

![img](Users/files/SubscribeNotify/pic040.png)

Enter the name of the attribute (owner in our example) into the name field and then enter the value(s) to match into the value field (in our case Standard:DivisionA.ProjectX and Standard:DivisionA.ProjectY)

__IMPORTANT:__Multiple values of a named filter are combined with OR. Multiple named filters are combined with AND.

## Trouble Shooting Notification Services ##
The following table lists some of the common issues and how to fix them:

### The grids Workflow Processes and/or Topics are empty ###

* verify that the Segment Administrator created Workflow Processes and Topics with the wizard Segment Setup
* click the filter button to see all rows without filtering (maybe you defined a default filter in the past?)

### I started the Subscription Handler but I never receive any Alerts / Notifications ###

* verify that you started the correct Subscription Handler (each segment has its own Subscription Handler)
* in case you upgraded to a new version of openCRX and forgot to delete Workflows and Topics provided by openCRX, stop the Subscription Handler, delete Workflow Processes and Topics, recreate Workflow Processes and Topics with the wizard Segment Setup, and then start the Subscription Handler again
* check the openCRX log files to find out whether bad/corrupt data might be causing problems (e.g. NullPointer Exception during Workflow execution)

### I receive Alerts triggered by my Subscriptions but no Notification E‑mails ###

* verify that JavaMail is properly installed and the mail service properly configured
* verify your e-mail settings (see E-mail Services)
* verify that the Servlet WorkflowHandler of the respective segment is actually turned on
