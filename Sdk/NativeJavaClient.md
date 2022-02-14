# How to write a native _openCRX_ Java client #

This guide explains how to write a native _openCRX_ Java client. Unlike with the remote client,
the native client performs a full in-process deployment of _openCRX_ and has direct access
to the _openCRX_ database.

_SampleNativeClient_ performs the following operations:

* Setup the _openMDX_ lightweight container. This section must be disabled if the client is deployed in the
  context of a J2EE web application
* Setup the persistence manager
* Run a query to retrieve contacts matching a given name pattern and display the result on the console

__IMPORTANT:__ Use this deployment scenario with caution. Unexpected effects can occur when
multiple instances of _openCRX_ access the same database.

__HINT:__ For non-_Java_ programming languages, _openCRX_ offers a _REST_ service which allows remote clients to 
access the full API of _openCRX_. For more information see [How to use the REST Servlet](Sdk/Rest.md). 
For the _Java_ programming language, _openCRX_ offers a client library which allows to access _openCRX_  using 
the standard _openCRX_ Java API.

## Prepare ##

Create a working directory (e.g. _~/opencrx-sample-native-client_) with the following layout:

```
opencrx-sample-native-client/
   + src/main/java/org/opencrx/application/client
     - SampleNativeClient.java
   + lib/
     - geronimo-javamail_1.4_mail-1.9.0-alpha-2.jar
     - javaee-api-8.0-4.jar
     - opencrx-config-crx.jar
     - opencrx-core.jar
     - openmdx-base-2.17.10.jar
     - openmdx-portal-2.17.10.jar
     - openmdx-security-2.17.10.jar
     - postgresql-42.2.12.jar
```

* _SampleNativeClient.java_: copy the source from [here](https://github.com/opencrx/opencrx/tree/master/core/src/sample/java/org/opencrx/application/client/). Adapt
  the jdbc connection url as required and add the corresponding jdbc driver jar to _./lib_
* _lib/*.jar_: copy the jars from a running _openCRX_ server installation, e.g. _APP-INF/lib_ and _TOMEE\_HOME/lib_ directories

## Compile ##

Next open a shell and go to the working directory (e.g. e.g. _~/opencrx-sample-native-client_). Compile
_SampleNativeClient.java_:

```
javac -d bin -cp "bin:lib/*" src/main/java/org/opencrx/application/client/SampleNativeClient.java
```

## Run ##
Next run the client:

```
java -cp "bin:lib/*" org.opencrx.application.client.SampleNativeClient
```

## Next Steps ##
You are now free to extend the client programming according to your needs. You have access to the
full API of _openCRX_, that is

* Perform queries
* Create and update objects
* Invoke operations

## Congratulations ##
Congratulations! You have successfully built and run your first _openCRX_ Java native client.
