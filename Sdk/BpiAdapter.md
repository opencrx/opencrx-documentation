# 3rd party integration with the _openCRX BPI adapter_ #

This guide explains how to integrate 3rd party applications with _openCRX_ using the _BPI adapter_ 
(_BPI_ stands for business process integration).

__IMPORTANT:__ This guide assumes that _openCRX 4.2 Server_ is successfully setup as described in 
[openCRX 4.2.0 Server Installation Guide](http://www.opencrx.org/opencrx/4.2/installerServer/installer_openCRX_server.html). 
Also, the _openCRX SDK_ must be installed as described in [openCRX SDK for Ant Step-by-Step Guide](Sdk/StepByStepAnt.md).

For non-_Java_ programming languages, _openCRX_ offers a _REST_ service which allows remote clients to
access the full API of _openCRX_ (for more information see [How to use the REST Servlet](Sdk/Rest.md)).
In addition, _openCRX_ offers a _Java_ client library which allows to access _openCRX_ using the standard
_openCRX_ Java API (for more information see [How to write a remote _openCRX_ Java client](Sdk/RemoteJavaClient.md)).
Basically, this allows any type of 3rd party application to be integrated with _openCRX_. However, 
for some situations, a custom-specific _API_ is often desirable. Some scenarios are:

* For complex use-cases the business-logic can not be implemented in the 3rd party application. It
  must be implemented server-side.
* The interface is predefined by the 3rd party application and a specific service must
  be provided.
* For performance reasons, the service call round-trips must be minimized and therefore an
  optimized service must be provided.

The _openCRX BPI adapter_ supports these scenarios in a straight-forward and flexible way.


## The BPI adapter standard services ##

The _openCRX BPI adapter_ comes with a set of standard services. These services offer only
very basic services and serve mainly as a starting point for custom-specific extensions.


### Get code table ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Root/codeTable/<name>
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiCodeTable_.

Example:

```
{
   "name":[
      "org:opencrx:kernel:address1:PostalAddressable:postalCountry",
      "org:opencrx:kernel:account1:Contact:address!postalCountry",
      "org:opencrx:kernel:account1:SearchIndexEntry:postalCountry",
      "org:opencrx:kernel:account1:Contact:citizenship",
      "org:opencrx:kernel:account1:Account:address*Business!postalCountry",
      "country"
   ],
   "entry":[
      {
         "shortText":[
            "NA",
            ...
         ],
         "longText":[
            " N/A",
            ...
         ],
         "xri":"xri://@openmdx*org.opencrx.kernel.code1/provider/CRX/segment/Root/valueContainer/country/entry/000",
         "id":"000",
         "createdAt":"Feb 12, 2013 10:39:24 AM",
         "createdBy":[
            "admin-Root"
         ],
         "modifiedAt":"Feb 12, 2013 10:45:53 AM",
         "modifiedBy":[
            "admin-Root"
         ]
      },  
      ...
   ],
   "xri":"xri://@openmdx*org.opencrx.kernel.code1/provider/CRX/segment/Root/valueContainer/country",
   "id":"country",
   "createdAt":"Feb 12, 2013 10:39:24 AM",
   "createdBy":[
      "admin-Root"
   ],
   "modifiedAt":"Feb 12, 2013 10:45:53 AM",
   "modifiedBy":[
      "admin-Root"
   ]
}
```


### Get contact  ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/contact/<alias name>
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiContact_.

Example:

```
{
   "lastName":"guest",
   "salutationCode":0,
   "businessAddress":[
      {
         "emailAddress":"guest@opencrx.org",
         "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ/address/94IJRA7NHUHNJXFBIJASE6A09",
         "id":"94IJRA7NHUHNJXFBIJASE6A09",
         "createdAt":"Mar 5, 2010 11:01:38 AM",
         "createdBy":[
            "guest"
         ],
         "modifiedAt":"Mar 5, 2010 11:01:38 AM",
         "modifiedBy":[
            "guest"
         ]
      }
   ],
   "fullName":"guest,",
   "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:f0fe74d0-12ec-11d9-9ab3-9d41e6fd0a25\nREV:20101207T125303Z\nN:guest;;;;\nFN: guest\nADR;HOME;ENCODING\u003dQUOTED-PRINTABLE:;;postalAddress0...\u003d0D\u003d0A\u003d0D\u003d0ApostalAddress2\u003d0D\u003d0ApostalStreet0...\u003d0D\u003d0A\u003d0D\u003d0ApostalStreet2;;;;Aruba [AW]\nURL;WORK:a@opencrx.org\nEMAIL;PREF;INTERNET:guest@opencrx.org\nEND:VCARD\n",
   "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ",
   "id":"8P500BLsEdmas51B5v0KJQ",
   "createdAt":"Sep 30, 2004 2:28:29 PM",
   "createdBy":[
      "admin-Standard"
   ],
   "modifiedAt":"Dec 7, 2010 1:53:03 PM",
   "modifiedBy":[
      "guest"
   ]
}
```


### Get contact memberships ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/contact/<alias name>/membership
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiAccountMembership_.

Example:

```
[
   {
      "name":"guest,",
      "memberRole":[

      ],
      "account":{
         "lastName":"admin-Standard",
         "salutationCode":2,
         "businessAddress":[

         ],
         "fullName":"admin-Standard,",
         "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:9a1bbcc0-281b-11dd-9ac4-750fe47a38f8\nREV:20120817T150104Z\nN:admin-Standard;;;Mrs.;\nFN: admin-Standard\nEND:VCARD\n",
         "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/admin-Standard",
         "id":"admin-Standard",
         "createdAt":"Dec 8, 2004 5:00:26 PM",
         "createdBy":[
            "root"
         ],
         "modifiedAt":"Nov 9, 2012 12:09:13 PM",
         "modifiedBy":[
            "admin-Standard"
         ]
      },
      "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ/accountMembership/(@openmdx*accountMember/CRX/Standard/admin-Standard/L29VJBRVZRRAAUZGHWYC06WP8*-1)",
      "id":"accountMember/CRX/Standard/admin-Standard/L29VJBRVZRRAAUZGHWYC06WP8*-1"
   }
]
```


### Get organization ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/organization/<name>
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiOrganization_.

Example:

```
{
   "businessAddress":[
      {
         "postalAddressLine":[
            "Crixp Corp."
         ],
         "postalStreet":[
            "Technoparkstr. 1"
         ],
         "postalCode":"8005",
         "postalCountry":756,
         "postalCity":"Zürich",
         "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/06a664f0-9bbb-11dc-9033-994ced7c5dbf/address/LF4EQMGN7HGPUUZGHWYC06WP8",
         "id":"LF4EQMGN7HGPUUZGHWYC06WP8",
         "createdAt":"May 15, 2013 1:55:50 PM",
         "createdBy":[
            "admin-Standard"
         ],
         "modifiedAt":"May 15, 2013 1:55:50 PM",
         "modifiedBy":[
            "admin-Standard"
         ]
      }
   ],
   "fullName":"CRIXP",
   "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:06a664f0-9bbb-11dc-9033-994ced7c5dbf\nREV:20130515T120350Z\nN:CRIXP\nFN:CRIXP\nADR;WORK:;;Crixp Corp.\\nTechnoparkstr. 1;Zürich;ZH;8005;Switzerland [CH]\nEND:VCARD\n",
   "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/06a664f0-9bbb-11dc-9033-994ced7c5dbf",
   "id":"06a664f0-9bbb-11dc-9033-994ced7c5dbf",
   "createdAt":"Nov 26, 2007 2:00:48 AM",
   "createdBy":[
      "admin-Standard"
   ],
   "modifiedAt":"May 15, 2013 2:03:50 PM",
   "modifiedBy":[
      "admin-Standard"
   ]
}
```


### Get organization members ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/organization/<name>/member
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiAccountMember_.

Example:

```
[
   {
      "name":"guest,",
      "memberRole":[

      ],
      "account":{
         "lastName":"guest",
         "salutationCode":0,
         "businessAddress":[
            {
               "emailAddress":"guest@opencrx.org",
               "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ/address/94IJRA7NHUHNJXFBIJASE6A09",
               "id":"94IJRA7NHUHNJXFBIJASE6A09",
               "createdAt":"Mar 5, 2010 11:01:38 AM",
               "createdBy":[
                  "guest"
               ],
               "modifiedAt":"Mar 5, 2010 11:01:38 AM",
               "modifiedBy":[
                  "guest"
               ]
            }
         ],
         "fullName":"guest,",
         "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:f0fe74d0-12ec-11d9-9ab3-9d41e6fd0a25\nREV:20101207T125303Z\nN:guest;;;;\nFN: guest\nADR;HOME;ENCODING\u003dQUOTED-PRINTABLE:;;postalAddress0...\u003d0D\u003d0A\u003d0D\u003d0ApostalAddress2\u003d0D\u003d0ApostalStreet0...\u003d0D\u003d0A\u003d0D\u003d0ApostalStreet2;;;;Aruba [AW]\nURL;WORK:a@opencrx.org\nEMAIL;PREF;INTERNET:guest@opencrx.org\nEND:VCARD\n",
         "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ",
         "id":"8P500BLsEdmas51B5v0KJQ",
         "createdAt":"Sep 30, 2004 2:28:29 PM",
         "createdBy":[
            "admin-Standard"
         ],
         "modifiedAt":"Dec 7, 2010 1:53:03 PM",
         "modifiedBy":[
            "guest"
         ]
      },
      "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/06a664f0-9bbb-11dc-9033-994ced7c5dbf/member/L29V2KG7RVR36UZGHWYC06WP8",
      "id":"L29V2KG7RVR36UZGHWYC06WP8"
   },
   {
      "name":"admin-Standard,",
      "memberRole":[

      ],
      "account":{
         "lastName":"admin-Standard",
         "salutationCode":2,
         "businessAddress":[

         ],
         "fullName":"admin-Standard,",
         "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:9a1bbcc0-281b-11dd-9ac4-750fe47a38f8\nREV:20120817T150104Z\nN:admin-Standard;;;Mrs.;\nFN: admin-Standard\nEND:VCARD\n",
         "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/admin-Standard",
         "id":"admin-Standard",
         "createdAt":"Dec 8, 2004 5:00:26 PM",
         "createdBy":[
            "root"
         ],
         "modifiedAt":"Nov 9, 2012 12:09:13 PM",
         "modifiedBy":[
            "admin-Standard"
         ]
      },
      "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/06a664f0-9bbb-11dc-9033-994ced7c5dbf/member/L29V2PNNPKYQQUZGHWYC06WP8",
      "id":"L29V2PNNPKYQQUZGHWYC06WP8"
   }
]
```


### Get activity creator ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/activityCreator/<name>
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiActivityCreator_.

Example:

```
{
   "name":"Bugs + Features",
   "xri":"xri://@openmdx*org.opencrx.kernel.activity1/provider/CRX/segment/Standard/activityCreator/nsPHEC5oEd2N2ktd7OG-Hg",
   "id":"nsPHEC5oEd2N2ktd7OG-Hg",
   "createdAt":"May 30, 2008 6:51:16 PM",
   "createdBy":[
      "admin-Standard"
   ],
   "modifiedAt":"Oct 15, 2008 3:40:48 PM",
   "modifiedBy":[
      "admin-Standard"
   ]
}
```


### Create activity ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/activityCreator/<name>/createActivity
```
__Method__

```
POST
```
__Request Body__

The request is of type _org.opencrx.application.bpi.datatype.BpiCreateAtivityParams_.

Example:

```
{ 
   "name" : "name of activity",
   "description" : "description of activity",
   "detailedDescription" : "detailed description of activity",
   "priority" : "required priority 0-5",
   "reportingContact": "id of reporting contact",
   "scheduledStart": "Jan 01, 2013 4:47:13 PM",
   "scheduledEnd": "Jan 01, 2013 5:47:13 PM"
}
```


### Get activity ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/activity/<activity number>
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiActivity_.

Example:

```
{
   "activityNumber":"1237919",
   "name":"Test URL #1",
   "scheduledStart":"Nov 1, 2010 11:30:00 AM",
   "scheduledEnd":"Nov 1, 2010 1:30:00 PM",
   "activityState":10,
   "reportingContact":{
      "lastName":"guest",
      "salutationCode":0,
      "businessAddress":[
         {
            "emailAddress":"guest@opencrx.org",
            "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ/address/94IJRA7NHUHNJXFBIJASE6A09",
            "id":"94IJRA7NHUHNJXFBIJASE6A09",
            "createdAt":"Mar 5, 2010 11:01:38 AM",
            "createdBy":[
               "guest"
            ],
            "modifiedAt":"Mar 5, 2010 11:01:38 AM",
            "modifiedBy":[
               "guest"
            ]
         }
      ],
      "fullName":"guest,",
      "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:f0fe74d0-12ec-11d9-9ab3-9d41e6fd0a25\nREV:20101207T125303Z\nN:guest;;;;\nFN: guest\nADR;HOME;ENCODING\u003dQUOTED-PRINTABLE:;;postalAddress0...\u003d0D\u003d0A\u003d0D\u003d0ApostalAddress2\u003d0D\u003d0ApostalStreet0...\u003d0D\u003d0A\u003d0D\u003d0ApostalStreet2;;;;Aruba [AW]\nURL;WORK:a@opencrx.org\nEMAIL;PREF;INTERNET:guest@opencrx.org\nEND:VCARD\n",
      "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ",
      "id":"8P500BLsEdmas51B5v0KJQ",
      "createdAt":"Sep 30, 2004 2:28:29 PM",
      "createdBy":[
         "guest"
      ],
      "modifiedAt":"Dec 7, 2010 1:53:03 PM",
      "modifiedBy":[
         "guest"
      ]
   },
   "assignedTo":{
      "lastName":"guest",
      "salutationCode":0,
      "businessAddress":[
         {
            "emailAddress":"guest@opencrx.org",
            "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ/address/94IJRA7NHUHNJXFBIJASE6A09",
            "id":"94IJRA7NHUHNJXFBIJASE6A09",
            "createdAt":"Mar 5, 2010 11:01:38 AM",
            "createdBy":[
               "guest"
            ],
            "modifiedAt":"Mar 5, 2010 11:01:38 AM",
            "modifiedBy":[
               "guest"
            ]
         }
      ],
      "fullName":"guest,",
      "vcard":"BEGIN:VCARD\nVERSION:2.1\nUID:f0fe74d0-12ec-11d9-9ab3-9d41e6fd0a25\nREV:20101207T125303Z\nN:guest;;;;\nFN: guest\nADR;HOME;ENCODING\u003dQUOTED-PRINTABLE:;;postalAddress0...\u003d0D\u003d0A\u003d0D\u003d0ApostalAddress2\u003d0D\u003d0ApostalStreet0...\u003d0D\u003d0A\u003d0D\u003d0ApostalStreet2;;;;Aruba [AW]\nURL;WORK:a@opencrx.org\nEMAIL;PREF;INTERNET:guest@opencrx.org\nEND:VCARD\n",
      "xri":"xri://@openmdx*org.opencrx.kernel.account1/provider/CRX/segment/Standard/account/8P500BLsEdmas51B5v0KJQ",
      "id":"8P500BLsEdmas51B5v0KJQ",
      "createdAt":"Sep 30, 2004 2:28:29 PM",
      "createdBy":[
         "guest"
      ],
      "modifiedAt":"Dec 7, 2010 1:53:03 PM",
      "modifiedBy":[
         "guest"
      ]
   },
   "category":[

   ],
   "participant":[

   ],
   "localizedField":[

   ],
   "xri":"xri://@openmdx*org.opencrx.kernel.activity1/provider/CRX/segment/Standard/activity/!9L2L3OLNB1JVJEBW34GOOEQA3",
   "id":"!9L2L3OLNB1JVJEBW34GOOEQA3",
   "createdAt":"Nov 1, 2010 10:21:35 AM",
   "createdBy":[
      "guest"
   ],
   "modifiedAt":"Nov 1, 2010 10:27:00 AM",
   "modifiedBy":[
      "guest"
   ]
}
```


### Do Follow-Up ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/activity/<activity number>/doFollowUp
```
__Method__

```
POST
```
__Request Body__

The request is of type _org.opencrx.application.bpi.datatype.BpiDoFollowUpParams_.

Example:

```
{ 
   "title" : "title of follow up",
   "text" : "text of follow up",
   "assignTo" : "optional contact id of assignTo contact",
   "transition" : "optional transition name"
   "updateActivity": "optional flag. When set to true, activity's detailedDescription is set to text and follow up is created with old detailedDescription"
}
```


### Get assigned activities ###

__URL__

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.application.bpi1/provider/CRX/segment/Standard/contact/<alias name>/assignedActivity
```
__Method__

```
GET
```
__Response Body__

The response is of type _org.opencrx.application.bpi.datatype.BpiActivity_.

Example:

```
[
   {
      "activityNumber":"1278567",
      "name":"Kampagne #1 - E-Mails / guest, / guest",
      "description":"description",
      "additionalInformation":"detailed description",
      "scheduledStart":"May 6, 2013 5:19:52 PM",
      "scheduledEnd":"May 6, 2013 6:19:52 PM",
      "activityState":0,
      "category":[

      ],
      "localizedField":[

      ],
      "xri":"xri://@openmdx*org.opencrx.kernel.activity1/provider/CRX/segment/Standard/activity/LFDW7HS3ULGPUR9IWK9XN31UW",
      "id":"LFDW7HS3ULGPUR9IWK9XN31UW",
      "createdAt":"May 6, 2013 5:19:52 PM",
      "createdBy":[
         "guest"
      ],
      "modifiedAt":"May 7, 2013 1:08:34 AM",
      "modifiedBy":[
         "guest"
      ]
   },
   ...
]
```


## How to extend the BPI adapter ##

The _BPI adapter_ can be extended by custom-specific services. Below is an an example which adds
a product retrieval service. The service has the following URL

```
http://localhost:8080/opencrx-bpi-CRX/org.opencrx.sample.adapter1/provider/CRX/segment/Standard/product/<product number>
```

and it returns _JSON_ objects of the type _MyBpiProduct_.

__MyBpiProduct.java__

```
package org.opencrx.sample.bpi.adapter;

import java.util.List;

public class MyBpiProduct extends org.opencrx.application.bpi.datatype.BpiObject {

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}
	private String name;
	private String description;
	private String productNumber;
	
}
``` 

The following steps are required to extend the _BPI adapter_:

* Extend the _BpiAdapterServlet_
* Implement the custom action _GetProductAction_
* Extend the _BpiPlugIn_


### Extend the _BpiAdapterServlet_ ###

Services and their URLs are registered in the _init()_ method of the _BpiAdapterServlet_. 
In order to add new services, the standard _BpiAdapterServlet_ must be extended. Here is an example:

__MyBpiAdapterServlet.java__

```
package org.opencrx.sample.bpi.adapter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import org.openmdx.base.naming.Path;

/**
 * MyBpiAdapterServlet
 *
 */
public class MyBpiAdapterServlet extends org.opencrx.application.bpi.adapter.BpiAdapterServlet {

    @Override
    public void init(
        ServletConfig config            
    ) throws ServletException {
        super.init(config);
        super.registerAction(
            new Path("xri://@openmdx*org.opencrx.sample.adapter1/provider/:*/segment/:*/product/:*"),
            new GetProductAction()
        );
    }

    @Override
    protected BpiPlugIn newPlugIn(
    ) {
        return new MyBpiPlugIn();
    }

}
```


### Implement custom actions ###

Next we have to implement the actions which serve the URLs listed in the _init()_ section.
In our example we have to provide the implementation for the _GetProductAction_. As shown in
see source, the action class delegates to the plug-in class methods _findProducts()_, 
_toBpiProduct()_, _newBpiProduct()_. We will extend the plug-in class in the next step.

__GetProductAction.java__

```
package org.opencrx.sample.bpi.adapter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opencrx.application.bpi.adapter.BpiAction;
import org.opencrx.application.bpi.adapter.BpiPlugIn;
import org.opencrx.kernel.activity1.jmi1.ActivityTracker;
import org.openmdx.base.exception.ServiceException;
import org.openmdx.base.naming.Path;

/**
 * Get product action.
 *
 */
public class GetProductAction extends BpiAction {

    @Override
    public void perform(
        Path path, PersistenceManager pm,
        BpiPlugIn plugIn,        
        HttpServletRequest req, 
        HttpServletResponse resp
    ) throws IOException, ServiceException {
        MyBpiPlugIn myPlugIn = (MyBpiPlugIn)plugIn;
        List<Product> products = plugIn.findProducts(path, pm);
        if(products == null || products.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND); 
        } else {
            Product product = products.iterator().next();
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");
            PrintWriter pw = resp.getWriter();
            plugIn.printObject(
                pw,
                myPlugIn.toMyBpiProduct(
                    product, 
                    myPlugIn.newMyBpiProduct()
                )
            );
            resp.setStatus(HttpServletResponse.SC_OK);
        }
    }

}
```


### Extend the _BpiPlugIn_ ###

Next we add the missing methods to the plug-in class which are used by the _GetProductAction_ class.

__MyBpiPlugIn.java__

```
package org.opencrx.sample.bpi.adapter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManager;

import org.opencrx.application.bpi.adapter.BpiPlugIn;
import org.opencrx.application.bpi.datatype.BpiActivity;
import org.openmdx.base.exception.ServiceException;
import org.openmdx.base.naming.Path;

/**
 * MyBpiPlugIn
 *
 */
public class MyBpiPlugIn extends BpiPlugIn {

    @Override
    public MyBpiProduct newMyBpiProduct(
    ) {
        return new MyBpiProduct();
    }
    
    @Override
    public List<Product> findProducts(
        Path path, 
        PersistenceManager pm
    ) {
        org.opencrx.kernel.product1.jmi1.Segment productSegment = (org.opencrx.kernel.product1.jmi1.Segment)pm.getObjectById(
            new Path("xri://@openmdx*org.opencrx.kernel.product1").getDescendant("provider", path.get(2), "segment", path.get(4))
        );
        ProductQuery productQuery = (ProductQuery)pm.newQuery(Product.class);
        productQuery.thereExistsProductNumber().equalTo(path.getBase());
        productQuery.orderByCreatedAt().ascending();
        productQuery.forAllDisabled().isFalse();
        return productSegment.getProduct(productQuery);        
    }

    protected MyBpiProduct toMyBpiProduct(
        Product product,
        MyBpiProduct myBpiProduct
    ) throws ServiceException, IOException {
        PersistenceManager pm = JDOHelper.getPersistenceManager(product);
        super.toBpiObject(product, myBpiProduct);
        myBpiProduct.setName(product.getName());
        myBpiProduct.setDescription(product.getDescription());
        myBpiProduct.setProductNumber(product.getProductNumber());
        return myBpiProduct;
    }

}
```


### Configure web.xml ###

The _BPI adapter_ has its own _web.xml_. It must be added to the _openCRX_ custom project 
to the directory _./opencrx-custom/<project name>/src/data/<data dir name>.bpi/_, e.g.
_./opencrx-custom/sample/src/data/org.opencrx.sample.bpi/_ for the sample project. For this 
purpose you can take the _web.xml_ from the openCRX/Core project located in 
_opencrx4/core/src/data/org.opencrx.bpi/_ and adapt the servlet class matching the 
_MyBpiAdapterServlet_ class.


__web.xml__

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE web-app PUBLIC "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN" "http://java.sun.com/dtd/web-app_2_3.dtd">
<web-app>
	<display-name>openCRX BPI service</display-name>
	<servlet>
		<servlet-name>BpiAdapterServlet</servlet-name>
		<servlet-class>org.opencrx.sample.bpi.adapter.MyBpiAdapterServlet</servlet-class>
	</servlet>
	<servlet-mapping>
		<servlet-name>BpiAdapterServlet</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>
	<session-config>
		<session-timeout>1</session-timeout>
	</session-config>
	<resource-ref>
		<res-ref-name>jdbc_opencrx_CRX</res-ref-name>
		<res-type>javax.sql.DataSource</res-type>
		<res-auth>Container</res-auth>
	</resource-ref>		
	<security-constraint>
		<web-resource-collection>
			<web-resource-name>bpi</web-resource-name>
			<description>bpi</description>
			<url-pattern>/</url-pattern>
		</web-resource-collection>
		<auth-constraint>
			<role-name>*</role-name>
		</auth-constraint>
		<user-data-constraint>
			<transport-guarantee>NONE</transport-guarantee>
		</user-data-constraint>
	</security-constraint>
	<login-config>
		<auth-method>BASIC</auth-method>
	</login-config>
	<security-role>
		<description>An openCRX user</description>
		<role-name>OpenCrxUser</role-name>
	</security-role>	
</web-app>
```


## Congratulations ##
Congratulations! You have successfully extended the _openCRX BPI adapter_.
