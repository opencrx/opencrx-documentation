# openCRX SDK for _Eclipse_ Step-by-Step Guide #

This guide explains how to setup _openCRX SDK_ for _Eclipse_.

## Prerequisites ##

This guide assumes that you have installed

* _openMDX SDK for Eclipse_ as described in [openMDX SDK for Eclipse](https://sourceforge.net/p/openmdx/wiki/Sdk41.StepByStepEclipse/).
* _openCRX SDK for Ant_ as described in [openCRX SDK for Ant Step-by-Step](Sdk/StepByStepAnt.md).
* _openCRX Server_ as described in [openCRX 4.1.0 Server Installation Guide](Admin/InstallerServer.md).

The workspace in _Eclipse_ then looks as shown below.

![img](files/StepByStepEclipse/pic010.png)

And the directory structure looks like this.

![img](files/StepByStepEclipse/pic020.png)

## Add openCRX to Workspace ##

Next we will import the _openCRX SDK_ projects. Select _File > Import_.

![img](files/StepByStepEclipse/pic060.png)

Select _Existing Projects into Workspace_.

![img](files/StepByStepEclipse/pic070.png)

Navigate to _/tmp/dev/opencrx4/core_ and import the project _openCRX 4 ~ Core_.

![img](files/StepByStepEclipse/pic090.png)

Navigate to _/tmp/dev/opencrx4/test-core_ and import the project _openCRX 4 ~ Test Core_.

![img](files/StepByStepEclipse/pic091.png)

Then navigate all the thirdparty projects as shown below.

![img](files/StepByStepEclipse/pic092.png)

![img](files/StepByStepEclipse/pic093.png)

![img](files/StepByStepEclipse/pic094.png)

![img](files/StepByStepEclipse/pic096.png)

![img](files/StepByStepEclipse/pic097.png)

![img](files/StepByStepEclipse/pic098.png)

The package explorer view now lists the projects shown below:

![img](files/StepByStepEclipse/pic100.png)

Depending on the Eclipse version, the autoscan may not have found the projects containing the UML (EMF) models. In this case we have to add them manually. The models are located in the following directories:

* openCRX/Core model: _/tmp/dev/opencrx4/core/src/model/emf/_

Import the openCRX/core model:

![img](files/StepByStepEclipse/pic110.png)

The package explorer view listing all projects:

![img](files/StepByStepEclipse/pic140.png)

## Launch openCRX under Eclipse ##

If we want to launch _openCRX_ under _Eclipse_ we first have to create a launch file. Open the run configurations with _Run > Run Configurations_ as shown below:

![img](files/StepByStepEclipse/pic220.png)

Then select _Java Application_ and _New_ to create a new launch file:

![img](files/StepByStepEclipse/pic230.png)

Fill the fields of the tab _Main_ as follows:

* Set the name to _openCRX TomEE_
* Set the project to empty
* Set to the main class to _org.apache.catalina.startup.Bootstrap_

![img](files/StepByStepEclipse/pic240.png)

In the tab _Arguments_ set the fields as follows:

__IMPORTANT:__ adapt the values to your environment.

* Set program arguments to _start_
* Set JVM parameters to

```
	-XX:MaxPermSize=128M  
	-Xmx800M 
	-Dcatalina.home="/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/" 
	-Djava.endorsed.dirs="/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/endorsed" 
	-Dcatalina.base="/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/" 
	-Djava.io.tmpdir="/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/temp" 
	-Dorg.openmdx.persistence.jdbc.useLikeForOidMatching=false
	-Dorg.opencrx.maildir="/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/maildir"
```

* Set working directory to _/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/_

![img](files/StepByStepEclipse/pic250.png)

Before we can launch _TomEE_ we have to complete the classpath. Click on _Add External JARs_ and navigate to the _openCRX Server_ installation directory, e.g. _/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/bin/_. Select all JARs in this directory as shown below: 

![img](files/StepByStepEclipse/pic290.png)

The selected JARs are added to the _User Entries_.

Then click on _Add External JARs_ and navigate to the _openCRX Server_ installation directory, e.g. _/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/lib/_. Select all JARs in this directory as shown below: 

![img](files/StepByStepEclipse/pic291.png)

The selected JARs are added to the _User Entries_. 

As last step we add the workspace projects. Navigate to _User Entries_ and click _Add projects_. Select all projects as shown below:

![img](files/StepByStepEclipse/pic260.png)

Finally you can start _TomEE_. Open the _Run_ dialog with _Run > Open Run Dialog_. Select _openCRX TomEE_ and click _Run_. The console output should look as shown below.

```
	INFO: Matched: file:/tmp/dev/opencrx4/apache/jre-1.8/httpclient/lib/apache-mime.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/apache/jre-1.8/httpclient/lib/httpmime.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/core/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/core/build/jre-1.8/model/opencrx-core.openmdx-xmi.zip
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/core/build/jre-1.8/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/core/etc/log/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/core/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/google/jre-1.8/zxing/lib/zxing-core.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/openqa/jre-1.8/selenium/lib/commons-exec.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/openqa/jre-1.8/selenium/lib/json.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/openqa/jre-1.8/selenium/lib/selenium.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/pdfbox/jre-1.8/pdfbox/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/pdfbox/jre-1.8/pdfbox/lib/FontBox.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrx4/test-core/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/FontBox.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-application.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-extension.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-kernel.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-mail.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-resources.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-security.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/zxing-core.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/gateway.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/lib/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/lib/tomcat7-websocket.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2-example/helloworld/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2-example/workshop/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/ant/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/client/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/core/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/core/build/jre-1.8/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/core/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/opt/bitronix/lib/btm.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/opt/postgresql/jre-1.8/postgresql-9/lib/postgresql-9.2.jdbc4.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/opt/radius/jre-1.8/TinyRadius-1/lib/tiny-radius.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/enterprise/lib/osgi.enterprise.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/enterprise/lib/osgi.enterprise.persistence.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/enterprise/lib/osgi.enterprise.servlet.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/enterprise/lib/osgi.enterprise.transaction.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/enterprise/lib/osgi.enterprise.xml.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/annotations.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/concurrent.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/ejb.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/jcache.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/jdo2-api.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/netscape-ldap.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/osgi/jre-1.8/extension/lib/resource.jar
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/portal/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/portal/build/jre-1.8/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/portal/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/security/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/security/build/jre-1.8/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/security/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/test-core/build/jre-1.8/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/test-core/src/resource/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.DeploymentsResolver loadFromClasspath
	INFO: Matched: file:/tmp/dev/openmdx2/tomcat/build/tomcat-7/eclipse/
	Feb 02, 2015 4:29:03 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.InitEjbDeployments deploy
	INFO: Auto-deploying ejb opencrx_core_CRX_EntityManagerFactoryAccessor: EjbDeployment(deployment-id=opencrx_core_CRX_EntityManagerFactoryAccessor)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.AutoConfig processResourceRef
	INFO: Auto-linking resource-ref 'jdbc_opencrx_CRX' in bean opencrx_core_CRX_EntityManagerFactoryAccessor to Resource(id=jdbc_opencrx_CRX)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.ConfigurationFactory configureService
	INFO: Configuring Service(id=Default Managed Container, type=Container, provider-id=Default Managed Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.AutoConfig createContainer
	INFO: Auto-creating a container for bean ear-scoped-cdi-beans_Application_ID.Comp1731334991: Container(type=MANAGED, id=Default Managed Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.ReportValidationResults logResults
	WARNING: WARN ... opencrx_core_CRX_EntityManagerFactoryAccessor:	Ignoring 2 invalid <container-transaction> declarations.  Bean not using Container-Managed Transactions.
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.ReportValidationResults logResults
	WARNING: 1 warning for EjbModule(path=opencrx_core_CRX_EntityManagerFactoryAndGateway)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX" loaded.
	Feb 02, 2015 4:29:04 PM org.apache.openejb.util.OptionsLog info
	INFO: Using 'openejb.system.apps=true'
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: openejb
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.InitEjbDeployments deploy
	INFO: Using openejb.deploymentId.format '{ejbName}'
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.InitEjbDeployments deploy
	INFO: Auto-deploying ejb openejb/Deployer: EjbDeployment(deployment-id=openejb/Deployer)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.InitEjbDeployments deploy
	INFO: Auto-deploying ejb openejb/ConfigurationInfo: EjbDeployment(deployment-id=openejb/ConfigurationInfo)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.InitEjbDeployments deploy
	INFO: Auto-deploying ejb MEJB: EjbDeployment(deployment-id=MEJB)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "openejb" loaded.
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating TransactionManager(id=Default Transaction Manager)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating SecurityService(id=Tomcat Security Service)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating Resource(id=jdbc_opencrx_CRX)
	Feb 02, 2015 4:29:04 PM org.apache.tomee.jdbc.TomEEDataSourceCreator$TomEEDataSource readOnly
	INFO: Disabling testOnBorrow since no validation query is provided
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating Resource(id=mail/provider/CRX)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating Container(id=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating Container(id=My Stateful Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.core.stateful.SimplePassivater init
	INFO: Using directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/temp for stateful session passivation
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler logUnusedProperties
	WARNING: Property "PoolSize" not supported by "My Stateful Container"
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating Container(id=Default Managed Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.core.managed.SimplePassivater init
	INFO: Using directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/temp for stateful session passivation
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=org.opencrx.core.CRX.EntityManagerFactoryAccessor) --> Ejb(deployment-id=opencrx_core_CRX_EntityManagerFactoryAccessor)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/Application_ID/opencrx_core_CRX_EntityManagerFactoryAndGateway/opencrx_core_CRX_EntityManagerFactoryAccessor!org.openmdx.application.rest.ejb.Connection_2Home) --> Ejb(deployment-id=opencrx_core_CRX_EntityManagerFactoryAccessor)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/Application_ID/opencrx_core_CRX_EntityManagerFactoryAndGateway/opencrx_core_CRX_EntityManagerFactoryAccessor) --> Ejb(deployment-id=opencrx_core_CRX_EntityManagerFactoryAccessor)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:04 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:04 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:04 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:04 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:04 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 54 ms.
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Created Ejb(deployment-id=opencrx_core_CRX_EntityManagerFactoryAccessor, ejb-name=opencrx_core_CRX_EntityManagerFactoryAccessor, container=My Stateful Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Started Ejb(deployment-id=opencrx_core_CRX_EntityManagerFactoryAccessor, ejb-name=opencrx_core_CRX_EntityManagerFactoryAccessor, container=My Stateful Container)
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-core-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-ical-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-caldav-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-carddav-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-webdav-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-imap-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-vcard-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-spaces-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-rest-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-ldap-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-airsync-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-bpi-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-calendar-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/opencrx-documents-CRX/META-INF/context.xml
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using default host: localhost
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: openejb
	Feb 02, 2015 4:29:04 PM org.apache.openejb.util.OptionsLog info
	INFO: Using 'openejb.jndiname.format={deploymentId}{interfaceType.openejbLegacyName}'
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=openejb/DeployerBusinessRemote) --> Ejb(deployment-id=openejb/Deployer)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/openejb/openejb/Deployer!org.apache.openejb.assembler.Deployer) --> Ejb(deployment-id=openejb/Deployer)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/openejb/openejb/Deployer) --> Ejb(deployment-id=openejb/Deployer)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=openejb/ConfigurationInfoBusinessRemote) --> Ejb(deployment-id=openejb/ConfigurationInfo)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/openejb/openejb/ConfigurationInfo!org.apache.openejb.assembler.classic.cmd.ConfigurationInfo) --> Ejb(deployment-id=openejb/ConfigurationInfo)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/openejb/openejb/ConfigurationInfo) --> Ejb(deployment-id=openejb/ConfigurationInfo)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=MEJB) --> Ejb(deployment-id=MEJB)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/openejb/MEJB!javax.management.j2ee.ManagementHome) --> Ejb(deployment-id=MEJB)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.JndiBuilder bind
	INFO: Jndi(name=global/openejb/MEJB) --> Ejb(deployment-id=MEJB)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Created Ejb(deployment-id=openejb/Deployer, ejb-name=openejb/Deployer, container=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Created Ejb(deployment-id=MEJB, ejb-name=MEJB, container=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Created Ejb(deployment-id=openejb/ConfigurationInfo, ejb-name=openejb/ConfigurationInfo, container=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Started Ejb(deployment-id=openejb/Deployer, ejb-name=openejb/Deployer, container=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Started Ejb(deployment-id=MEJB, ejb-name=MEJB, container=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler startEjbs
	INFO: Started Ejb(deployment-id=openejb/ConfigurationInfo, ejb-name=openejb/ConfigurationInfo, container=My Stateless Container)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler deployMBean
	INFO: Deployed MBean(openejb.user.mbeans:application=openejb,group=org.apache.openejb.assembler.monitoring,name=JMXDeployer)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=openejb)
	Feb 02, 2015 4:29:04 PM org.apache.openejb.server.SimpleServiceManager start
	INFO:   ** Bound Services **
	Feb 02, 2015 4:29:04 PM org.apache.openejb.server.SimpleServiceManager printRow
	INFO:   NAME                 IP              PORT  
	Feb 02, 2015 4:29:04 PM org.apache.openejb.server.SimpleServiceManager start
	INFO: -------
	Feb 02, 2015 4:29:04 PM org.apache.openejb.server.SimpleServiceManager start
	INFO: Ready!
	Feb 02, 2015 4:29:04 PM org.apache.catalina.startup.Catalina load
	INFO: Initialization processed in 23756 ms
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.OpenEJBNamingContextListener bindResource
	INFO: Importing a Tomcat Resource with id 'UserDatabase' of type 'org.apache.catalina.UserDatabase'.
	Feb 02, 2015 4:29:04 PM org.apache.openejb.assembler.classic.Assembler createRecipe
	INFO: Creating Resource(id=UserDatabase)
	Feb 02, 2015 4:29:04 PM org.apache.catalina.core.StandardService startInternal
	INFO: Starting service Catalina
	Feb 02, 2015 4:29:04 PM org.apache.catalina.core.StandardEngine startInternal
	INFO: Starting Servlet Engine: Apache Tomcat (TomEE)/7.0.55 (1.7.2)
	Feb 02, 2015 4:29:04 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-core-CRX
	Feb 02, 2015 4:29:04 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 7 ms.
	Feb 02, 2015 4:29:05 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-ical-CRX
	Feb 02, 2015 4:29:05 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 6 ms.
	Feb 02, 2015 4:29:05 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-caldav-CRX
	Feb 02, 2015 4:29:05 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 6 ms.
	Feb 02, 2015 4:29:05 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-carddav-CRX
	Feb 02, 2015 4:29:05 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:05 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-webdav-CRX
	Feb 02, 2015 4:29:05 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 6 ms.
	Feb 02, 2015 4:29:05 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-imap-CRX
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:05 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:05 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 8 ms.
	Feb 02, 2015 4:29:05 PM org.openmdx.kernel.log.LoggerFactory getLogger
	INFO: Sys|openMDX Version|openmdx-system: 2.15.0, openmdx-base: 2.15.0
	Feb 02, 2015 4:29:05 PM org.openmdx.base.mof.spi.Model_1Factory getModelPackages
	INFO: The model package set [org:opencrx, org:opencrx:kernel:base, org:opencrx:kernel:generic, org:opencrx:kernel:home1, org:opencrx:kernel:document1, org:opencrx:kernel:workflow1, org:opencrx:kernel:building1, org:opencrx:kernel:address1, org:opencrx:kernel:account1, org:opencrx:kernel:product1, org:opencrx:kernel:contract1, org:opencrx:kernel:activity1, org:opencrx:kernel:forecast1, org:opencrx:kernel:code1, org:opencrx:kernel:uom1, org:opencrx:security:identity1, org:opencrx:security:realm1, org:opencrx:security:authentication1, org:opencrx:security:authorization1, org:opencrx:kernel:reservation1, org:opencrx:kernel:admin1, org:opencrx:kernel:model1, org:opencrx:kernel:ras1, org:opencrx:kernel:depot1, org:opencrx:kernel, org:opencrx:security, org:opencrx:application:shop1, org:oasis-open, org:omg:model1, org:openmdx:base, org:openmdx:generic1, org:openmdx:kernel, org:openmdx:preferences2, org:openmdx:state2, org:openmdx:role2, org:w3c, org:openmdx:ui1, org:openmdx:security:realm1, org:openmdx:security:authorization1, org:openmdx:security:authentication1, org:openmdx:audit2, test:openmdx:app1, test:openmdx:clock1, test:openmdx:datatypes1, test:openmdx:model1, org:openmdx:example:helloworld1, org:openmdx:example:workshop1] is based on the openmdxmof.properties located at [file:/tmp/dev/opencrx4/core/src/resource/META-INF/openmdxmof.properties, file:/tmp/dev/openmdx2/core/src/resource/META-INF/openmdxmof.properties, file:/tmp/dev/openmdx2/portal/src/resource/META-INF/openmdxmof.properties, file:/tmp/dev/openmdx2/security/src/resource/META-INF/openmdxmof.properties, file:/tmp/dev/openmdx2/test-core/src/resource/META-INF/openmdxmof.properties, file:/tmp/dev/openmdx2-example/helloworld/build/jre-1.8/eclipse/META-INF/openmdxmof.properties, file:/tmp/dev/openmdx2-example/workshop/build/jre-1.8/eclipse/META-INF/openmdxmof.properties, jar:file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/openmdx-security.jar!/META-INF/openmdxmof.properties, jar:file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/openmdx-portal.jar!/META-INF/openmdxmof.properties, jar:file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/openmdx-base.jar!/META-INF/openmdxmof.properties, jar:file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/opencrx-kernel.jar!/META-INF/openmdxmof.properties]
	Feb 02, 2015 4:29:05 PM org.openmdx.kernel.id.spi.TimeBasedIdGenerator createClockSequence
	INFO: Sys|Clock sequence created|cef
	Feb 02, 2015 4:29:05 PM org.openmdx.kernel.id.spi.TimeBasedIdGenerator createRandomBasedNode
	INFO: Sys|The time based id generator has a random based node|3115e492f267
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:05 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 328 bytes loaded in 0 ms
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 2 ms
	Feb 02, 2015 4:29:05 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 33811 bytes loaded in 2 ms
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:05 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:05 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 34458 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 46384 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 32904 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 4475 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 15381 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 7629 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 70881 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 56465 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 100928 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 128465 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 9576 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 3369 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 3718 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 1142 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 2114 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 468 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 460 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 7335 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 5356 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 16422 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 15529 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 59064 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 365 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 377 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 110118 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 438 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 20337 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 4689 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 2469 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 3748 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 3759 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 1671 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 1019 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 1376 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 27328 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 14611 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 2423 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 5990 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 3863 bytes loaded in 1 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 29165 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 970 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 3339 bytes loaded in 0 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 2 ms
	Feb 02, 2015 4:29:06 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 200347 bytes loaded in 2 ms
	Feb 02, 2015 4:29:07 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:07 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:07 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:07 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:07 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 1466 bytes loaded in 0 ms
	Feb 02, 2015 4:29:07 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:07 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:07 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:07 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:07 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 9690 bytes loaded in 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 438 bytes loaded in 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 20337 bytes loaded in 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 4689 bytes loaded in 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.application.xml.spi.ImportHelper setFeature
	INFO: Sys|Unable to set SAXReader feature|feature={0}, value={1}
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys Performance|WBXML String table loaded|Elapsed time: 0 ms
	Feb 02, 2015 4:29:08 PM org.openmdx.base.wbxml.StandardStringSource populate
	INFO: Sys|WBXML String table: 1376 bytes loaded in 0 ms
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Accounts
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Activities
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Addresses
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Buildings
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Admin
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Base
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Cloneable
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Contracts
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Depots
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Documents
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Exporter
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Forecasts
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.ICalendar
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.XmlImporter
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Models
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Notifications
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Products
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.SecureObject
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.UserHomes
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.VCard
	Feb 02, 2015 4:29:09 PM org.opencrx.kernel.backend.AbstractImpl registerImpl
	INFO: Sys|Registering impl|org.opencrx.kernel.backend.Workflows
	Feb 02, 2015 4:29:09 PM org.openmdx.base.mof.cci.Persistency <init>
	INFO: Sys|ORM mapping: Persistence Modifiers|Apply configuration file:/tmp/dev/opencrx4/core/build/jre-1.8/src/resource/META-INF/openmdxorm.properties
	Feb 02, 2015 4:29:09 PM org.openmdx.base.mof.cci.Persistency <init>
	INFO: Sys|ORM mapping: Persistence Modifiers|Apply configuration file:/tmp/dev/openmdx2/core/build/jre-1.8/src/resource/META-INF/openmdxorm.properties
	Feb 02, 2015 4:29:09 PM org.openmdx.base.mof.cci.Persistency <init>
	INFO: Sys|ORM mapping: Persistence Modifiers|Apply configuration file:/tmp/dev/openmdx2/portal/build/jre-1.8/src/resource/META-INF/openmdxorm.properties
	Feb 02, 2015 4:29:09 PM org.openmdx.base.mof.cci.Persistency <init>
	INFO: Sys|ORM mapping: Persistence Modifiers|Apply configuration file:/tmp/dev/openmdx2/security/build/jre-1.8/src/resource/META-INF/openmdxorm.properties
	Feb 02, 2015 4:29:09 PM org.openmdx.base.mof.cci.Persistency <init>
	INFO: Sys|ORM mapping: Persistence Modifiers|Apply configuration file:/tmp/dev/openmdx2-example/helloworld/build/jre-1.8/eclipse/META-INF/openmdxorm.properties
	Feb 02, 2015 4:29:09 PM org.openmdx.base.mof.cci.Persistency <init>
	INFO: Sys|ORM mapping: Persistence Modifiers|Apply configuration jar:file:/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/apps/opencrx-core-CRX/APP-INF/lib/openmdx-base.jar!/META-INF/openmdxorm.properties
	IMAPServer CRX is listening on port 1143
	Feb 02, 2015 4:29:09 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-vcard-CRX
	Feb 02, 2015 4:29:09 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:09 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:09 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:09 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:09 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:09 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:09 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:09 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-spaces-CRX
	Feb 02, 2015 4:29:09 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-rest-CRX
	Feb 02, 2015 4:29:10 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 6 ms.
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-ldap-CRX
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	LDAPServer CRX is listening on port 1389
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-airsync-CRX
	Feb 02, 2015 4:29:10 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-bpi-CRX
	Feb 02, 2015 4:29:10 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-calendar-CRX
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /opencrx-documents-CRX
	Feb 02, 2015 4:29:10 PM org.apache.tomcat.util.digester.SetPropertiesRule begin
	WARNING: [SetPropertiesRule]{Context/Realm/Realm} Setting property 'debug' to '0' did not find a matching property.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 8 ms.
	Feb 02, 2015 4:29:10 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deploying web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/docs
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /docs
	Feb 02, 2015 4:29:10 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/docs
	Feb 02, 2015 4:29:10 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/docs" loaded.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/docs
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 8 ms.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/docs)
	Feb 02, 2015 4:29:10 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deployment of web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/docs has finished in 60 ms
	Feb 02, 2015 4:29:10 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deploying web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /host-manager
	Feb 02, 2015 4:29:10 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager
	Feb 02, 2015 4:29:10 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager" loaded.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 4 ms.
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager/META-INF/context.xml
	Feb 02, 2015 4:29:10 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager)
	Feb 02, 2015 4:29:10 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deployment of web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/host-manager has finished in 80 ms
	Feb 02, 2015 4:29:10 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deploying web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager
	Feb 02, 2015 4:29:10 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /manager
	Feb 02, 2015 4:29:10 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager
	Feb 02, 2015 4:29:10 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager" loaded.
	Feb 02, 2015 4:29:10 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:10 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:10 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 4 ms.
	Feb 02, 2015 4:29:11 PM org.apache.tomee.catalina.TomcatWebAppBuilder deployWebApps
	INFO: using context file /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager/META-INF/context.xml
	Feb 02, 2015 4:29:11 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager)
	Feb 02, 2015 4:29:11 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deployment of web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/manager has finished in 54 ms
	Feb 02, 2015 4:29:11 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deploying web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/ROOT
	Feb 02, 2015 4:29:11 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /
	Feb 02, 2015 4:29:11 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/ROOT
	Feb 02, 2015 4:29:11 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/ROOT" loaded.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/ROOT
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 4 ms.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/ROOT)
	Feb 02, 2015 4:29:11 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deployment of web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/ROOT has finished in 46 ms
	Feb 02, 2015 4:29:11 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deploying web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/tomee
	Feb 02, 2015 4:29:11 PM org.apache.tomee.catalina.TomcatWebAppBuilder init
	INFO: ------------------------- localhost -> /tomee
	Feb 02, 2015 4:29:11 PM org.apache.openejb.config.ConfigurationFactory configureApplication
	INFO: Configuring enterprise application: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/tomee
	Feb 02, 2015 4:29:11 PM org.apache.openejb.config.AppInfoBuilder build
	INFO: Enterprise application "/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/tomee" loaded.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Assembling app: /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/tomee
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.CdiBuilder initSingleton
	INFO: Existing thread singleton service in SystemInstance(): org.apache.openejb.cdi.ThreadSingletonServiceImpl@2068d09d
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container is starting...
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [CdiPlugin]
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.plugins.PluginLoader startUp
	INFO: Adding OpenWebBeansPlugin : [OpenWebBeansJsfPlugin]
	Feb 02, 2015 4:29:11 PM org.apache.webbeans.config.BeansDeployer validateInjectionPoints
	INFO: All injection points were validated successfully.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.cdi.OpenEJBLifecycle startApplication
	INFO: OpenWebBeans Container has started, it took 5 ms.
	Feb 02, 2015 4:29:11 PM org.apache.openejb.assembler.classic.Assembler createApplication
	INFO: Deployed Application(path=/tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/tomee)
	Feb 02, 2015 4:29:11 PM org.apache.catalina.startup.HostConfig deployDirectory
	INFO: Deployment of web application directory /tmp/dev/opencrxServer-4.1.0/apache-tomee-webprofile-1.7.4/webapps/tomee has finished in 54 ms
	Feb 02, 2015 4:29:11 PM org.apache.coyote.AbstractProtocol start
	INFO: Starting ProtocolHandler ["http-bio-8080"]
	Feb 02, 2015 4:29:11 PM org.apache.coyote.AbstractProtocol start
	INFO: Starting ProtocolHandler ["ajp-bio-8009"]
	Feb 02, 2015 4:29:11 PM org.apache.catalina.startup.Catalina start
	INFO: Server startup in 6196 ms
```

# Congratulations #
Congratulations! You have successfully prepared _openCRX SDK_ for _Eclipse_.
