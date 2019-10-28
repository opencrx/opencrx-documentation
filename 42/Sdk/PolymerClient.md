# How to write an _openCRX_ Polymer client #

This guide explains how to write a [Polymer](https://www.polymer-project.org/) client accessing _openCRX_ using the [RESTful API](Sdk/Rest.md).

## Prepare ##
This guide assumes that 

* the _openCRX 4.2 Server_ is successfully installed as described in [openCRX 4.2.0 Server Installation Guide](Admin/InstallerServer.md).
* the _openCRX/Sample_ custom project is installed as described in [How to create a custom project](Sdk/CustomProject.md).
* _Bower_ is installed. See [Bower - A package manager for the web](http://bower.io/) for more information.

## Overview ##
_MyContact_ is a sample _Polymer_ app that accesses _openCRX_ using the standard _RESTful API_. The app is located in the folder _sample/src/war/opencrx-sample-store.war/_ and consists of the following files:

* __index.html:__ Main page of the _MyContact_ app 
* __elements/mycontact-toolbar.html:__ Component for the app toolbar
* __elements/mycontact-contact-list.html:__ Component which allows to display a list of contacts retrieved from the API. The component extends the generic component _mycontact-object-list.html_.
* __elements/mycontact-object-list.html:__ Component which allows to display a list of objects retrieved from the API. The component shows how to implement infinite, incremental scrolling using the _position_ and _size_ parameters of the query API.
* __elements/mycontact-detail.html:__ Component which shows the detail information of a contact including some main attributes and address information. The component demonstrates how to use retrieve, display and update objects.

The implementation using the _RESTful API_ is straight-forward. Use the _Swagger UI_ to explore the API. See [RESTful API](Sdk/Rest.md) for more information.

## Build ##
Build the _MyContact_ app as follows:

```
cd ./opencrx4-custom/sample/src/war/opencrx-sample-mycontact.war
bower update
cd ../../..
ant assemble
```

This generates the _opencrx-sample-mycontact.war_ in the directory _../jre-1.8/sample/deployment-unit/_.

## Run ##
Next deploy _opencrx-sample-mycontact.war_. Copy the file to _./opencrxServer-4.2.0/apache-tomee-plus-7.0.5/webapps/_ and restart Tomcat. Then open a browser and enter the URL _http://localhost:8080/opencrx-sample-mycontact/index.html_.

At startup, the app should display a toolbar and a list of contacts. As a reference see the [demo](http://demo.opencrx.org/opencrx-sample-mycontact/index.html).

In case of troubles consult the browser's console log and / or use [Firebug](http://getfirebug.com/downloads) to track warnings and errors.

## Congratulations ##
Congratulations! You have successfully built and run your first _openCRX_ Polymer client.
