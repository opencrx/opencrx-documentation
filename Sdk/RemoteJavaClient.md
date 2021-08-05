# How to write a remote _openCRX_ Java client #

This guide explains how to write a remote Java client accessing _openCRX_. A remote client
accesses a running _openCRX_ server instance via the REST/HTTP protocol.

__IMPORTANT:__ This guide assumes that _openCRX Server_ is successfully setup as described in 
[openCRX Server Installation Guide]((Admin/InstallerServer.md)).

__HINT:__ For non-_Java_ programming languages, openCRX offers a _REST_ service which allows remote clients to 
access the full API of _openCRX_. For more information see [How to use the REST Servlet](Sdk/Rest.md). 
For the _Java_ programming language, _openCRX_ offers a client library which allows to access _openCRX_  using 
the standard _openCRX_ Java API.

## Prepare ##
_SampleRemoteClient_ performs the following operations:

* Setup the persistence manager
* Connect to _openCRX_ using the _REST/Http_ transport
* Run a query to retrieve contacts matching a given name pattern and display the result on the console

Create a working directory (e.g. _~/opencrx-sample-remote-client_) with the following layout:

```
opencrx-sample-remote-client/
   + src/main/java/org/opencrx/kernel/client
     - SampleRemoteClient.java
   + lib/
     - opencrx-client.jar
     - openmdx-client.jar
     - javaee-api-8.0-4.jar
```

* _SampleRemoteClient.java_: copy the source from [here](https://github.com/opencrx/opencrx/tree/master/core/src/test/java/org/opencrx/kernel/client/). Adapt
  the values for the variables _userName_, _password_ and _connectionUrl_ to your environment. The default values are ok for standard installations.
* _opencrx\_client.jar_: copy from _/opencrx/jre-11/core/lib/_
* _openmdx\_client.jar_: copy from _/openmdx/jre-1.8/client/lib_
* _javaee-api-8.0-4.jar_: copy from _TOMEE\_HOME/lib_

## Compile ##

Next open a shell and go to the working directory (e.g. e.g. _~/opencrx-sample-remote-client_). Compile
_SampleRemoteClient.java_:

```
javac -d bin -cp "bin:lib/*" src/main/java/org/opencrx/kernel/client/SampleRemoteClient.java
```

## Run ##
Next run the client:

```
java -cp "bin:lib/*" org.opencrx.kernel.client.SampleRemoteClient
```

## Next Steps ##
You are now free to extend the client programming according to your needs. You have access to the
full API of _openCRX_, that is

* Perform queries
* Create and update objects
* Invoke operations

## Congratulations ##
Congratulations! You have successfully built and run your first _openCRX_ Java remote client.
