# How to create a custom project #

This guide explains how to create a custom project for _openCRX_. A custom project allows to extend the customizing delivered with the standard distribution of _openCRX_ by adding and modifying

* Headers, footers and logos
* Groovy-based controls
* Code tables
* Wizards
* Reports
* Backend extensions
* Model and database extensions
* Custom WARs

A custom project allows to separate the directory structure of the _openCRX_ distribution and the custom-specific files.

This guide assumes that the _openCRX SDK_ is installed (also see [here](Sdk/StepByStepEclipse.md)).

## Checkout and build the sample custom project ##

_openCRX SDK_ comes with a sample custom project. Follow the steps below to install and build it. 

### Build for Linux ###

In a first step open a shell and cd to a directory where you have installed _openCRX SDK_ (see  [here](Sdk/StepByStepEclipse.md) for more information).

```
cd /tmp/dev
./setenv.sh
```

Then checkout and build the sample project.

```
git clone ssh://<user>@git.code.sf.net/p/opencrx/opencrx4-custom opencrx4-custom
cd opencrx4-custom
cd opt
ant install-opt
cd ..
cd sample
ant all
```

### Build for Windows ###
In a first step open a shell and cd to a directory where you have installed _openCRX SDK_ (see  [here](Sdk/StepByStepEclipse.md) for more information).

```
cd \temp\dev
setenv.bat
```

Then checkout and build the sample project.

```
git clone ssh://<user>@git.code.sf.net/p/opencrx/opencrx4-custom-git opencrx4-custom
cd opencrx4-custom
cd opt
ant install-opt
cd ..
cd sample
ant all
```

## Verify project structure ##
After successfully building the project the directory structure looks as shown below.

![img](Sdk/files/CustomProject/pic150.png | width=320)

* _jre-1.8/sample/deployment-units_: custom-specific deployment units (e.g. _EAR_, _WAR_)
* _jre-1.8/sample/lib_: custom-specific _JARs_
* _sample/etc/deployment-unit_: custom web application.
* _sample/build.properties_: allows to customize project-specific properties
* _sample/build.xml_: custom-specific Ant _build.xml_
* _sample/src/data/org.opencrx.sample_: contains the custom-specific UI extensions. You have to put the custom-specific files such for ui, codes, reports, wizards, etc. in these directories. They are added to the _WAR_. A very important file is the ./WEB-INF/web.xml which contains the configuration of all servlets.
* _sample/src/java_: custom-specific backend
* _sample/src/ear_: custom-specific deployment descriptors
* _sample/src/model_: custom-specific model extension

## Import the Eclipse projects ##
Import the _Eclipse_ projects which come with the _sample_ project:
* _sample/.project_: openCRX 4 Custom ~ Sample (jre-1.8)
* _sample/src/model/emf/.project_: openCRX 4 Custom ~ Sample (EMF)
* _sample/src/model/papyrus/.project_: openCRX 4 Custom ~ Sample (Papyrus)

## MyWebApp ##
_MyWebApp_ shows how to add a custom-specific web application to _openCRX_. _MyWebApp_ is developed with Google Web Toolkit (GWT). 

Unzip _MyWebApp.zip_ to a directory of your choice. Open a shell and switch to this directory. Before you can build the project we have to adapt _build.xml_. Open _build.xml_ with a text editor and adapt the following variables to your environment:

```
<!-- Configure path to GWT SDK -->
<property name="gwt.sdk" location="/opt/gwt-2.5.1" />
<property name="openmdx.sdk" location="/tmp/dev/opencrx4/opt/openmdx-2.15.0/jre-1.8/core/lib" />
<property name="opencrx.sdk" location="/tmp/dev/opencrx4/jre-1.8/core/lib" />
```
 
Now build the project with _ant war_. Copy the resulting _MyWebApp.war_ to the directory _sample/etc/deployment-unit_ and build the sample EAR with _ant assemble_. 

_MyWebApp.war_ is now part of the resulting _opencrx-core-CRX.ear_. The web module is registered in _application.xml_ (see _src/ear/opencrx-core-CRX.ear/META-INF_).
 
The class _com.mycompany.mywebapp.server.GreetingServiceImpl_ shows how a GWT service accesses the _openCRX_ backend. Deploy the _EAR_ and lauch _MyWebApp_ with the URL _http://localhost:8080/mywebapp_.

## Store ##
The _Store_ application shows how to build a stand-alone web application which uses _openCRX_ as backend. 
After running _ant all_ you will find in _jre-1.8/sample/deployment-units_ the file _opencrx-sample-store.war_. 
You can deploy this _WAR_ to any application server instance. E.g. deploy to the _webapps_ directory of your 
current _Tomcat_ instance. In order to be able to connect to your _openCRX Server_ instance, check the 
following entries  in the _./sample/src/war/opencrx-sample-store.war/WEB-INF/web.xml_:

```
<context-param>
	<param-name>url</param-name>
	<param-value>http://127.0.0.1:8080/opencrx-rest-CRX/</param-value>
</context-param>
<context-param>
	<param-name>userName</param-name>
	<param-value>admin-Standard</param-value>
</context-param>
<context-param>
	<param-name>password</param-name>
	<param-value>admin-Standard</param-value>
</context-param>
```

Adapt the parameter values according to your environment and run _ant assemble_ again after having made modifications.

The _Store_ application comes with some sample data which you can load with the standard _openCRX GUI_:

* Login as segment administrator (e.g. _admin-Standard_).
* On the user's home select _File > Import_ and import the file _sample/src/war/opencrx-sample-store.war/data/uoms.xml_.
* Next import the file _sample/src/war/opencrx-sample-store.war/data/products.xml_.
* Now launch the _Store_ application with _http://localhost:8080/opencrx-sample-store/Store.jsp_. Adapt host and
  port according to your environment.
  
You then get the start screen as shown below:

![img](Sdk/files/CustomProject/pic140.png)

If you want to build your own web application and use _openCRX_ as backend it should be straight-forward 
to use the _Store_ application as template and adapt it to your use-cases and _GUI_ frameworks.

## Model extension ##
_openCRX_ follows a _Model Driven Software Development_ (MDSD) approach. Hence, many _openCRX_ artifacts (_API_,
_XML_ schemas, persistence mappings and classes, etc.) are the derived from the model. I.e. they are generated 
at build-time by model mapping tools provided by the underlying _MDA_ framework 
_openMDX_ (see [here](http://www.opencrx.org) for more information). As a consequence, the _openCRX Core_ model 
must be extended in case new attributes or operations are to be added to the _API_, GUI, or database. In order 
to get a basic understanding of the _MDSD_ approach it is a good idea to read the following documents:

* [_Introduction to Modeling with openMDX_](http://sourceforge.net/p/openmdx/wiki/IntroductionToModeling/) 
* [_openMDX Workshop_ project](http://sourceforge.net/p/openmdx/wiki/Sdk40.Workshop/)
* The source files of the _openCRX Sample_ project

The _sample_ project comes with a simple model extension. In _Eclipse_ open the _Papyrus_ model by opening
_openCRX 4 Custom ~ Sample (Papyrus)/models.di_. Then select the diagram named _org.opencrx.sample.account1-Main_. It 
should look as shown below:

![img](Sdk/files/CustomProject/pic160.png)

The _sample_ project extends the _openCRX Core_ model by the following elements:

* Class _org:opencrx:sample:account1:MyContact_: _MyContact_ extends the class _org:opencrx:kernel:account1:Contact_ 
  from _openCRX/Core_. It adds the  and adds the multi-valued attribute _hobby_.
* Class _org:opencrx:sample:account1:Gadget_: _Gadget_ extends the classes _org:opencrx:kernel:base:Note_, 
  _org:opencrx:kernel:base:SecureObject_, _org:opencrx:kernel:base:Auditee_, and _org:openmdx:base:BasicObject_. 
  All attributes are inherited.
* Association _org:opencrx:sample:account1:MyContactOwnsGadget_: the composite association allows to add 0..n gadgets
  to a _MyContact_. 

## Next steps ##
* If you want to rename the project _sample_ by your own name, e.g. _myname_ then you have to adapt _build.xml_, _build.properties_ and the directory name containing the data files in _src/data_
* If you want to learn more about UI customizing then see [here](http://www.opencrx.org/documents.htm) for more information

## Congratulations ##
You have successfully created your first _openCRX_ custom project.
