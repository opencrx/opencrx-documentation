# How to write a remote _openCRX_ Java client #

This guide explains how to write a remote Java client accessing _openCRX_.

__IMPORTANT:__ This guide assumes that _openCRX 4.0 Server_ is successfully setup as described in 
[openCRX 4.0.0 Server Installation Guide](http://www.opencrx.org/opencrx/4.0/installerServer/installer_openCRX_server.html). In addition 
the _openCRX SDK_ must be installed as described in [openCRX SDK for Ant Step-by-Step Guide](40/Sdk/StepByStepAnt/README.md).

For non-_Java_ programming languages, openCRX offers a _REST_ service which allows remote clients to 
access the full API of _openCRX_. For more information see [How to use the REST Servlet](40/Sdk/Rest/README.md). 
For the _Java_ programming language, _openCRX_ offers a client library which allows to access _openCRX_  using 
the standard _openCRX_ Java API.

## Prepare ##
The _openCRX_ client application list below performs the following operations:

* Setup the persistence manager
* Connect to _openCRX_ using the _REST/Http_ transport
* Run a query to retrieve contacts matching a given name pattern and display the result on the console

__SampleOpenCrxClient.java__

```
import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;
import javax.naming.NamingException;

import org.openmdx.base.exception.ServiceException;
import org.openmdx.base.naming.Path;

/**
 * Sample openCRX client program.
 *
 */
public class SampleOpenCrxClient {

	public static void main(
		String[] args
	) throws NamingException, ServiceException {
		String connectionUrl = "http://127.0.0.1:8080/opencrx-rest-CRX/";
		String userName = "admin-Standard";
		String password = "admin-Standard";
		PersistenceManagerFactory pmf = org.opencrx.kernel.utils.Utils.getPersistenceManagerFactoryProxy(
			connectionUrl,
			userName,
			password,
			"application/vnd.openmdx.wbxml" // or 'text/xml' for plain xml protocol
		);
		PersistenceManager pm = pmf.getPersistenceManager(userName, null);
		org.opencrx.kernel.account1.jmi1.Segment accountSegment = 
			(org.opencrx.kernel.account1.jmi1.Segment)pm.getObjectById(
				new Path("xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard")
			);
		org.opencrx.kernel.account1.cci2.ContactQuery contactQuery = 
			(org.opencrx.kernel.account1.cci2.ContactQuery)pm.newQuery(org.opencrx.kernel.account1.jmi1.Contact.class);
		contactQuery.orderByFullName().ascending();
		contactQuery.thereExistsFullName().like("G.*");
		int count = 0;
		for (org.opencrx.kernel.account1.jmi1.Contact contact : accountSegment.<org.opencrx.kernel.account1.jmi1.Contact> getAccount(contactQuery)) {
			System.out.println(contact.refGetPath().toXRI() + ": " + contact.getFullName());
			count++;
			if (count > 100) {
				break;
			}
		}
		pm.close();
	}

}
```


Create a working directory (e.g. _~/temp/opencrx-sample-client_) and add the following files:

* The _Java_ source file _SampleOpenCrxClient.java_. Copy/Paste the source code from above. Adapt
  the values for the variables _userName_, _password_ and _connectionUrl_ to your environment. 
  The default values are ok for standard installations.
* The library _opencrx_client.jar_. Copy it from _./opencrx4/jre-1.8/core/lib/_.
* The library _openmdx_client.jar_. Copy it from _./opencrx4/opt/openmdx-2.15.0/jre-1.8/client/lib/_.
* The library _resource.jar_. Copy it from _./opencrx4/opt/openmdx-2.15.0/osgi/jre-1.8/extension/lib/_.   

## Compile ##

Next open a shell and go to the working directory (e.g. e.g. _~/temp/opencrx-sample-client_). Compile
_SampleOpenCrxClient.java_ as follows:

```
javac -classpath "openmdx-client.jar:opencrx-client.jar" SampleOpenCrxClient.java
```

## Run ##
Next run the client:

```
java -Djava.protocol.handler.pkgs=org.openmdx.kernel.url.protocol -classpath "openmdx-client.jar:opencrx-client.jar:resource.jar:." SampleOpenCrxClient
```

## Next Steps ##
You are now free to extend the client programming according to your needs. You have access to the
full API of _openCRX_, that is

* Perform queries
* Create and update objects
* Invoke operations

## Congratulations ##
Congratulations! You have successfully built and run your first _openCRX_ Java client.
