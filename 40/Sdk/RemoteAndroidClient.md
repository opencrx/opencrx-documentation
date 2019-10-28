# How to write a remote _openCRX_ Android client #

This guide explains how to write a remote _Android_ client accessing _openCRX_.

## Thanks to ##
Many thanks to [Bruno Studer](https://sourceforge.net/u/brunostuder/profile/) for this contribution.

## Prepare ##
This guide assumes that 

* the _openCRX 4.0 Server_ is successfully installed as described in [openCRX 4.0.0 Server Installation Guide](40/Admin/InstallerServer.md).
* the _openCRX/Sample_ custom project is installed and deployed as described in [How to create a custom project](40/Sdk/CustomProject.md).
* the _Android SDK_ installed. See [Get the Android SDK](http://developer.android.com/sdk/index.html) for more information.

## Overview ##
The sample _Android_ client accesses _openCRX_ by invoking the service _org:opencrx:sample:client1:Segment:queryAccounts_.
This service is part of the _openCRX/Sample_ custom project. This requires that the _openCRX/Sample_ application is up-and-running.

The custom interface _org:opencrx:sample:client1_ has a very small memory-footprint so the 
resulting _Android_ application can easily be loaded by _Android_ devices. The standard interfaces of
_openCRX_ (_org:opencrx:kernel:account1_, _org:opencrx:kernel:activity1_, _org:opencrx:kernel:contract1_, 
_org:opencrx:kernel:product1_, etc.) have a much larger memory-footprint so using these interfaces 
typically does not work at all or results in very slow application loading times.

The _openCRX_ client application below performs the following operations:

* Setup the persistence manager
* Connect to _openCRX_ using the _REST/Http_ transport
* Invoke the service queryAccounts() and display the result

__AccountLoader.java__

```
package org.opencrx.sample.android;

import java.io.CharArrayWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;

import android.content.AsyncTaskLoader;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import org.opencrx.sample.client1.jmi1.AccountT;
import org.opencrx.sample.client1.jmi1.QueryAccountParams;
import org.opencrx.sample.client1.jmi1.QueryAccountResult;
import org.openmdx.application.rest.http.SimplePort;
import org.openmdx.base.accessor.jmi.spi.EntityManagerFactory_1;
import org.openmdx.base.jmi1.Provider;
import org.openmdx.base.naming.Path;
import org.openmdx.base.persistence.cci.ConfigurableProperty;
import org.openmdx.base.persistence.cci.PersistenceHelper;
import org.openmdx.base.resource.cci.ConnectionFactory;
import org.openmdx.base.rest.connector.EntityManagerProxyFactory_2;
import org.openmdx.base.rest.spi.ConnectionFactoryAdapter;
import org.openmdx.base.transaction.TransactionAttributeType;
import org.openmdx.kernel.jdo.ReducedJDOHelper;
import org.w3c.spi2.Datatypes;
import org.w3c.spi2.Structures;

public class AccountLoader
    extends AsyncTaskLoader<List<AccountLoader.AccountItem>> {

  private static final String TAG = AccountLoader.class.getSimpleName();
  private final String queryName;
  private final String queryCity;

  public AccountLoader(
      Context context,
      String queryName,
      String queryCity) {
    super(context);
    this.queryName = queryName;
    this.queryCity = queryCity;
  }

  @Override
  public List<AccountLoader.AccountItem> loadInBackground() {
    Log.d(TAG,
        "search name:" + this.queryName + ", city:" + this.queryCity);

    List<AccountLoader.AccountItem> accountItems = new ArrayList<AccountLoader.AccountItem>();

    final SharedPreferences prefs = this.getContext()
        .getSharedPreferences(SettingsActivity.PREFERENCES,
            Context.MODE_PRIVATE);
    final String serverName = prefs.getString(SettingsActivity.SERVERNAME,
        null);
    final String login = prefs.getString(SettingsActivity.LOGIN,
        null);
    final String password = prefs.getString(SettingsActivity.PASSWORD,
        null);
    if (serverName == null || login == null || password == null) {
      return accountItems;
    }

    try {
      final SimplePort port = new SimplePort();
      port.setMimeType("application/vnd.openmdx.wbxml");
      port.setUserName(login);
      port.setPassword(password);
      port.setConnectionURL("http://" + serverName + "/opencrx-rest-CRX/");
      final ConnectionFactory connectionFactory = new ConnectionFactoryAdapter(port,
          true,
          TransactionAttributeType.NEVER);
      final Map<String, Object> dataManagerProxyConfiguration = new HashMap<String, Object>();
      dataManagerProxyConfiguration.put(ConfigurableProperty.ConnectionFactory.qualifiedName(),
          connectionFactory);
      dataManagerProxyConfiguration.put(ConfigurableProperty.PersistenceManagerFactoryClass
          .qualifiedName(),
          EntityManagerProxyFactory_2.class.getName());
      final PersistenceManagerFactory outboundConnectionFactory = ReducedJDOHelper
          .getPersistenceManagerFactory(dataManagerProxyConfiguration);

      final Map<String, Object> entityManagerConfiguration = new HashMap<String, Object>();
      entityManagerConfiguration.put(ConfigurableProperty.ConnectionFactory.qualifiedName(),
          outboundConnectionFactory);
      entityManagerConfiguration.put(ConfigurableProperty.PersistenceManagerFactoryClass
          .qualifiedName(),
          EntityManagerFactory_1.class.getName());
      final PersistenceManagerFactory pmf = ReducedJDOHelper
          .getPersistenceManagerFactory(entityManagerConfiguration);

      final PersistenceManager pm = pmf.getPersistenceManager(login,
          password);
      PersistenceHelper.currentUnitOfWork(pm).begin();

      org.opencrx.sample.client1.jmi1.Segment segment;
      try {
        segment = (org.opencrx.sample.client1.jmi1.Segment) pm
            .getObjectById(new Path("xri://@openmdx*org.opencrx.sample.client1/provider/CRX/segment/Standard"));
      } catch (Exception e) {
        final Provider provider = (Provider) pm
            .getObjectById(new Path("xri://@openmdx*org.opencrx.sample.client1/provider/CRX"));
        segment = pm.newInstance(org.opencrx.sample.client1.jmi1.Segment.class);
        provider.addSegment("Standard",
            segment);
        Log.i(TAG,
            "Segment created");
      }

      final List<Structures.Member<QueryAccountParams.Member>> members = new ArrayList<Structures.Member<QueryAccountParams.Member>>();
      if (this.queryName != null) {
        members.add(Datatypes.member(QueryAccountParams.Member.name,
            this.queryName));
      }
      if (this.queryCity != null) {
        members.add(Datatypes.member(QueryAccountParams.Member.postalCity,
            this.queryCity));
      }
      final QueryAccountParams params = Structures.create(QueryAccountParams.class,
          members);
      final QueryAccountResult result = segment.queryAccounts(params);

      PersistenceHelper.currentUnitOfWork(pm).commit();

      List<AccountT> accounts = result.getAccounts();
      for (AccountT account : accounts) {
        accountItems.add(new AccountItem(account.getFullName(), account.getPostalCity()));
      }

      pm.close();

    } catch (Throwable e) {
      log(TAG,
          e);
    }
    Log.d(TAG,
        "found " + accountItems.size() + " accounts");
    return accountItems;
  }

  public static void log(
      String tag,
      Throwable e) {
    Log.e(TAG,
        "Exception " + (e.getMessage() != null ? e.getMessage() : "NULL"),
        e);

    final CharArrayWriter w = new CharArrayWriter();
    PrintWriter pw = new PrintWriter(w);
    e.printStackTrace(pw);
    final String msg = w.toString();
    final int length = msg.length();
    for (int i = 0; i < length; i += 1024) {
      if (i + 1024 < length)
        Log.w(tag,
            msg.substring(i,
                i + 1024));
      else
        Log.w(tag,
            msg.substring(i,
                length));
    }
  }

  public static final class AccountItem {

    protected AccountItem(
        String fullName,
        String city) {
      super();
      this.fullName = fullName;
      this.city = city;
    }

    private final String fullName;
    private final String city;

    @Override
    public String toString() {
      if (city != null) {
        return fullName + ", " + city;
      } else {
        return fullName;
      }
    }

    public String getFullName() {
      return fullName;
    }

    public String getCity() {
      return city;
    }

  }

}
```

## Compile and Build ##
You can build the _APK_ as follows:

```
cd ./opencrx4-custom/sample/src/apk/opencrx-sample-android
ant release
```

This generates the directories _./gen_ and _./bin_ whereas the .apk is created in _./bin_. The ant script
requires that the environment variable _ANDROID\_HOME_ is set, e.g. _/opt/android-sdk-linux/_.

## Run ##
Install _opencrx-sample-android.apk_ on an _Android_ device and start the application. The client
asks you for a server name, user name and password. The server name is of the form _ip address:port_ 
(e.g. 10.10.10.20:8080) and must point to a running _openCRX/Sample_ instance. User and password must
be a valid _openCRX_ user (e.g. _admin-Standard_ / _admin-Standard_ or _guest_ / _guest_). The client then
connects with the URL _http://ip address:port/opencrx-core-REST_, invokes the service _queryAccounts()_ 
and displays the result on the _Android_ device.

## Congratulations ##
Congratulations! You have successfully built and run your first _openCRX_ Android client.
