# Introduction to the openCRX UML model - Part I #

The business object model of _openCRX_ is specified with _UML_. This has some important advantages:

* It is platform- and language-neutral. Changes of the underlying platform or 
  programming language do not affect the model. 
* The model is mapped by the build process to various artifacts such as _Java APIs_ and
  _JPA_ persistence classes, _XML_ schemas, etc. and it is used at runtime by generic 
  components such as the standard GUI, the _REST_ service or the database access plug-in. 
  So the model is not only a picture. It is an integral and essential part of the development 
  and runtime environment and it guarantees that all artifacts are always consistent. In 
  addition, the automation also saves a lot of programming effort.
* It is visual. Compared to a textual _Java API_ it can be printed out and discussed with
  business analysts and with advanced users.

__IMPORTANT:__ this document is work in progress. It only describes a subset of
the _openCRX_ model.

## Get the model ##
The complete _openCRX_ class diagrams are published [here](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/).

The _openCRX_ model is created using _Eclipse Papyrus_ (for more information see [here](http://www.eclipse.org/papyrus/). 
If you have installed the _openCRX SDK_ you will find the corresponding model files in the directories 
_./opencrx2/core/src/model/emf_ and _./opencrx2/core/src/model/papyrus_. However, the model diagrams are not 
created with _Papyrus_, you won't see any diagrams using _Papyrus_. Instead, the diagrams are created semi-manually 
using the _GraphViz_ utilities. This approach saves a lot of manual layout work and the diagrams 
have a consistent layout.
 
If you want to generate the model diagrams on your local machine as follows you can do this as follows.
Open a shell and go to the _openCRX SDK_ installation directory. Then run the following commands:

```
./setenv.sh
cd core
ant -Dalbum.theme.name=Uptight -Dalbum.theme.path="~/opt/album/themes" -Dalbum.theme.url="http://myweb.com/_style/album/themes" model-diagrams
```

The ant task _model-diagrams_ performs the following operations:

* It processes the manually created GraphViz templates (.dott) located in _./opencrx2/core/src/model/graphviz_.
  It completes the place-holders ${CLASS}, ${ASSOCIATION} and ${INSTANCE_OF}) with the actual
  model information and generates GraphViz compliant .dot files.
* It runs the _GraphViz_ _dot_ utility for each generated .dot file.
* It runs the _album_ utility to generate a web-index.
* The resulting diagrams documentation is store in the directory _./build/model_.

The task must meet the following prerequisites:

* The _GraphViz_ utilities must be installed. See [here](http://www.graphviz.org/) for more information.
* The _album_ utility must be installed. See [here](http://marginalhacks.com/Hacks/album/) for more information.
  Also install the theme 'Uptight'.
* Set the following environment variables

```
export GRAPHVIZ_HOME=/usr/bin
export ALBUM_HOME=/usr/bin
```


## Why a UML model? ##
The UML model represents the service interface of _openCRX_. So if you look at the model 
you look at the _API_ of _openCRX_ in _UML_ notation (most of you are probably more familiar 
with interfaces expresses as _WSDLs_, _Java_ interfaces, _CORBA IDL_s, etc. In _openCRX_ 
we decided to use _UML_ because of the advantages mentioned in the introduction. This
decision may be a little bit of a hurdle for some programmers to get comfortable with 
_openCRX_. The good news is that as long as you stick to the _Java API_ or 
the _REST_ interface you do not have to know that much about _UML_. Moreover, _openCRX_ 
only makes lightweight use of _UML_. It only uses class diagrams. Business objects are 
mapped to _UML_ classes, attributes, operations and associations. Other _UML_ 
diagram and element types or not used. 


## How to read the model? ##

If you want to learn more about _UML_ modeling for _openMDX_-based applications then
[Introduction to Modeling with openMDX](https://sourceforge.net/p/openmdx/wiki/IntroductionToModeling) is a good starting point.


## Package _org.opencrx.kernel_ ##
_kernel_ is the main model package of _openCRX_. It contains all classes used by the 
_openCRX_ core service:

[TOC]


### Package _org.opencrx.kernel.account1_ ###
_account1_ includes all business objects related to account and contact management.  
Accounts can be contacts (which are persons), groups or companies. An account has
an arbitrary number of members which allow to create relationships between accounts.
The type of a membership is specified by its role, e.g. _is friend of_, _is employee of_,
etc.  An account also has an arbitrary number addresses where each address is
specified by its type (postal, e-mail, phone, ...) and usage (business, home, other, 
delivery, ...).

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/account1/010_Main.png)

The main classes of _account1_ are

* _Contact_: Represents a person.
* _LegalEntity_: Represents a company.
* _Group_: Represents any kind of account group. Examples are _openCRX Developers_, _Receiver of openCRX Newsletter_, _VIP Customers_.   
* _UnspecifiedAccount_: Used when the other types do not apply. This type is
  typically used when importing contact information from a 3rd party system. 
  In these cases it is sometimes not possible to decide whether an address record 
  is a person, a legal entity or a group.   

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/account1/030_Addresses.png)

An account has an arbitrary number of addresses. As explained in the 
_address1_ model, an address has a usage and a default flag. This allows 
an account to have multiple postal addresses with different usages such as _Home_, 
_Business_, _Invoice_, _Delivery_, etc. It is important to note that 
addresses are objects and not only strings. If an _EMailAddress_ is referenced by
an _EMailActivity_ or a _PostalAddress_ is referenced by a _Contract_, there 
is no redundant information or copy stored in the activity or contract management. In 
case an address changes it is a good practice not to change the existing address. 
Instead, create the new address and set the disabled flag of the existing address to true. 
First of all, this allows to keep track of the address changes, but more important _old_ 
information is not destroyed. E.g. existing sales orders still show the address where 
the items where actually delivered (and not the new).

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/account1/060_Membership.png)

_Member_s allow to create a relationship between two accounts. The relationship 
is asymmetric in the sense that one account is the owner of the relationship and 
the other account is referenced. The relationship is directed from the owning 
account to the referenced account. The composition asserts that all members are 
removed when the owning account is removed. A relationship is specified by 
its role and quality and has a validity period starting from _validFrom_ until 
_validTo_. If two accounts have relationships in different roles, e.g. 
_is friend of_, _is business partner of_ then a member object has to be created 
for each role. 

Objects of type _Member_ are persistent, i.e. they are stored on the database.
Objects of type _AccountMembership_ are transient and are calculated by a database
view. _AccountMembership_s are the set of all direct and indirect memberships 
between two accounts. A _distance < 0_ means _account is referenced by_ 
and a _distance > 0_ means _account references_.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/account1/070_Organization.png)

The classes _Organization_, _OrganizationalUnit_ and _OrganizationalUnitRelationship_
allow to capture the organizational structure of an account. The organizational 
structure is separated from the account / member structure because typically only 
a very limited number of organizational units need to be exposed as accounts. 
E.g. an international company has several branches worldwide. The main company
and the branches are mapped to legal entities. The maybe complex structure is mapped 
to organizations, organizational units and their relationships. Using the relationship 
type, any kind of relationship between organizational units can be captured. The 
organizational units representing the head quarter or a branch reference the 
corresponding legal entity. Separating the organizational structure from the account and 
membership structure also reflects the fact that the life-cycle of the organizational 
structure and the account and membership structure are typically not in sync.


### Package _org.opencrx.kernel.activity1_ ###
An _Activity_ is a representation of anything what a resource "does". _openCRX_ 
supports the following activity types:

* _Absence_: Represents holidays or some other kind of unavailability.
* _EMail_: Received, sent or archived E-mail.
* _ExternalActivity_: Activity which is described in
  detail by an external or 3rd party system.
* _Incident_: Incident or support case.
* _Mailing_: A mailing.
* _Meeting_: A meeting.
* _PhoneCall_: A phone call.
* _SalesVisit_: A sales visit. Is sub-class of _Meeting_.
* _Task_: A task.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/020_ActivityDetails.png)

An activity is reported by an account / contact. It has a unique activity number, an
actual start and end, a scheduled start and end, a priority and a due by date. Each 
activity has an _ICAL_ _VEVENT_ or _VTODO_ representation. An activity can be assigned to
exactly one person. The assigned person is responsible for the activity. During the
lifetime of the activity, the activity can be reassigned to another person either
by users or by workflows. Moreover, an activity has the following properties:

* __Votes:__ Users can vote for activities. This may be useful in cases when 
  a decision has to be made of how to proceed with the activity. 
* __Group assignments:__ Activities can be assigned to zero or more activity
  groups. This allows to structure the activities and group them to trackers,
  categories and milestones. The shared association _ActivityGroupContainsActivity_
  allows the reverse lookup: it lists all activities assigned to an activity group.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/999_ActivityGroup.png)

* __Product references:__ If the activity management is used for customer support,
  customers typically report issues related to products. _ProductReference_s allow
  to set relationships to products.
* __Effort estimate:__ If used in the context of project management effort estimates 
  can be added to activities. 
* __Involved object:__ A generic way which allows to capture relationships to other objects.
* __Resource assignment:__ Activities are executed by resources. The workload in % allows to 
  define the expected or planned amount of work a resource is working on the activity 
  relative to the companies working calendar. The work records reported by each resource 
  represent the actual work performed.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/010_Activity.png)

Each activity has an activity type. The type contains meta-information about an
activity which all activities of the same type share. Most important, the type
defines the underlying workflow, i.e. the process which controls the execution and
progress of the activity. 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/999_ActivityType.png)

An activity's process is represented by a state diagram composed of states and 
transitions. By the means of actions a transition defines what has to be done
during the transition. The model defines some predefined actions and the generic
action _WfAction_ (workflow action) which allows to execute a workflow, i.e. 
any kind of programmed code.  

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/999_ActivityProcess.png)

An activity is always in a current state. A transition is initiated by the operation 
_doFollowUp()_. It can be invoked by the user using the standard GUI 
or by programs, workflows or triggers. If a transition is executed, the 
corresponding progress is reported as a _FollowUp_ object and the activity 
changes to the new state.  

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/999_ActivityFollowUp.png)

Activities are created by _ActivityCreator_s. Activity creators allow to define

* The type of activity to be created 
* The activity groups to which the activity is initially assigned 
* The resources to which the activity is assigned upon creation

When invoking the operation _newActivity()_ an activity is created with a new activity
number. It is assigned to the configured activity groups and resources. 
Moreover, the workflow is initialized and the activity is set to its initial state.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/999_ActivityCreator.png)

The actual work is performed by resources. In most cases a resource is a person. However, 
a _Resource_ is an abstract worker an can also be a _part time person_, a 
_group of persons_, a _machine_ or a combination of it. A resource has a working 
calendar which allows to specify the availability of a resource.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/activity1/999_Resource.png)


### Package _org.opencrx.kernel.address1_ ###

The model contains abstract classes capturing the different types of addresses:

* _Addressable:_ abstract type which represents any type of address. Every 
  addressable has a main flag and a usage code which allows to specify how the
  address is to be used (_Home_, _Business_, _Delivery_, etc.).
* _RoomAddressable:_ Room. E.g. can be used to capture the room where employees are
  located.
* _PostalAddressable:_ Postal address. 
* _EMailAddressable:_ E-Mail address.
* _WebAddressable:_ Address of a web site.
* _PhoneNumberAddressable:_: phone and fax numbers.

The abstract classes are used in other models to define concrete address types such
as _AccountAddress_ or _ContractAddress_.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/address1/010_Main.png)


### Package _org.opencrx.kernel.admin1_ ###
_admin1_ contains classes required to manage _openCRX_ by the root administrator. 
Currently, the model only contains the segment and _ComponentConfiguration_s.
Component configurations allow to manage configuration options for the individual 
components of _openCRX_. E.g. _CalDavServlet_, _ICalServlet_, _WorkflowHandler_. 
The operation _createAdministrator()_ allows to create a new segment including
its segment administrator. The method _importLoginPrincipal()_ allows to import
login principals and subjects from an external file.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/admin1/010_Main.png)


### Package _org.opencrx.kernel.base_ ###
The _base_ package contains classes and patterns which are used in other model packages. The
most important are

* _PropertySet_ and _Property_
* _SecureObject_
* _Auditee_
* _Indexable_

A property set contains zero or more properties. Property sets are used in many
cases. E.g. a _CrxObject_ is a property set. This allows to attach any number of 
property sets and properties to _CrxObject_s.  

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/base/999_Properties.png)

A _SecureObject_ allows to control read, update and delete access to objects.
An object has an owner and zero or more owning groups. The owner and all users
which are member of one of the groups have access to the object. The level and type
of the access is controlled by the access levels:

* _accessLevelBrowse:_ controls whether the user has browse permission, i.e. is 
  allowed to read composite objects.
* _accessLevelUpdate:_ controls whether a user has update permission.
* _accessLevelDelete:_ controls whether the user has delete permission.

The level determines the user's memberships:

* __none:__ Nobody has access except the root user.
* __private:__ Only the owning user is granted access.
* __basic:__ The owning user and all users which are member of the assigned
  groups and their super-groups recursively are granted access.
* __deep:__ The owning user and all users which are member of the assigned
  groups, their super-groups and their subgroups recursively are granted access.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/base/999_SecureObject.png)

Classes inheriting from _Auditee_ are subject to audit, i.e. all object
modifications are logged in the form of audit entries. _AuditEntry_s are transient 
objects which are calculated by a database view. As a consequence they are read-only. 
The attribute _auditee_ contains the _XRI_ of the modified object. _modifiedFeatures_ 
contains the set of features which were modified. _beforeImage_ lists the attributes
and their corresponding values before update. 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/base/999_Audit.png)

Classes inheriting from _Indexed_ are subject to indexing. How indexing is done
is implementation-specific. The object's index entry can be updated by invoking
the operation _updateIndexEntry()_. An object has zero or more index entries
representing the object's index at different times. The class _ObjectFinder_ 
defined in model _home1_ allows to retrieve objects based on their index entries.  

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/base/999_Indexed.png)


### Package _org.opencrx.kernel.building1_ ###
The _building1_ package allows to capture buildings, building units, facilities
and inventory items. Buildings are composed of building units which itself may be
grouped hierarchically using the relationship _BuildingUnitHasParent_. 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/building1/010_Main.png)

If requied, buildings can be grouped to _BuildingComplex_s. _Building_s, _BuildingUnit_s 
and _BuildingComplex_s all inherit from the abstract type _AbstractBuildingUnit_ and
as such they can contain facilities. 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/building1/999_BuildingUnit.png)

Besides of that, the model supports _InventoryItem_s. Inventory items can be 
linked to each other or they can be linked to facilities (both extend _LinkableItem_). 
The purpose of the link-feature is to capture the (mostly) static relationships 
between items. E.g. a building has three rooms R1, R2 and R3 (represented as building units). 
R1 has the facility _meeting area_ having itself a table, four chairs and a flip-chart as 
inventory items.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/building1/999_InventoryItem.png)

If the building unit plays more the role of a warehouse and the inventory items are 
only stored temporarily in the building it is not recommended to capture the items 
as _InventoryItem_s. Instead, the items should be represented as products and the 
flow of the items as bookings. The reference _InventoryControlledByDepot_ can be used
to capture the relationship _warehouse - depot_.


### Package _org.opencrx.kernel.code1_ ###
The package _code1_ is used to capture code values or predefined value domains mainly
used to populate drop-downs in GUIs.  The _CodeValueContainer_ is the container of
one or more entries. An entry can either be a _CodeValueEntry_ or a _SimpleEntry_. 
An entry has a code _value_ and a validity period specified by _validFrom_ and _validTo_. 
A _CodeValueEntry_ is mainly used to populate drop-downs for code fields of multilingual 
GUIs such as the standard GUI of openCRX. A _SimpleEntry_ can be used by applications and 
adapters accessing _openCRX_ via the _API_ or _REST_. Typically they are used to map 
stringified values to code values and vice versa. You can find _XML_ samples in the folder 
_./opencrx2/core/src/data/org.opencrx/code/Root/_. 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/code1/010_Main.png)


### Package _org.opencrx.kernel.contract1_ ###
The package _contract1_ contains the business objects to capture in a formal
way any kind of agreements made between contract parties. In the most abstract form
a contract is a document where at least two parties have set up an agreement. _contract1_
currently is restricted to contracts used in the sales process. These are:

* _Lead:_ A lead allows to capture the initial sales contact in an informal way.
* __Opportunity:__ An opportunity allows to capture customer interests which are 
  more concrete and more formal than leads. If the customer shows interest in certain
  products, corresponding opportunity positions (or line items) can be created using
  the operation _createPosition()_.
* _Quote:_ A quote represents the next step in the sales pipeline. A quote can be
  created from scratch or based on an existing opportunity.   
* _SalesOrder:_ A sales order contains all terms and conditions and line items
  including prices, sales taxes and discounts as ordered by the customer. A sales
  order can be created from scratch or based an existing quote.
* _Invoice:_ Invoices allow to track invoices sent to the customer. In many cases, 
  _openCRX_ is not the leading system for invoices. Instead, invoices are created 
  by a 3rd party ERP system which are imported automatically by a workflow and linked
  with the corresponding sales order(s). 

__NOTE:__ More contract types such as service or support contracts will probably be
added in future versions of _openCRX_.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/contract1/010_Main.png)

All sales contract types inherit from the abstract class  _AbstractContract_. A
sales contract has a sales rep, a customer, a supplier and broker. Competitors and
additional contacts can be added if needed. It is important to note that a contract
has exactly one contract currency. All amounts and totals refer to this contract 
currency. A contract has a default pricing rule and a default calculation rule. The 
pricing rule defines which price from the set of available product prices is 
automatically selected when creating or updating a contract position. The default 
pricing rule implements a _lowest price_ algorithm. E.g. if a product has a price 
of € 2.- which is valid from _01-01-2010_ until _31-12-2010_ and a special price of 
€ 1.- during _01-08-2010_ until _31-08-2010_ then the lowest price rule selects the 
price € 2.- unless the _pricingDate_ is between _01-08-2010_ and _31-08-2010_.
The model allows to define any kind of user-specific pricing rules. The algorithms
are implemented in _Java_. 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/contract1/070_Contract.png)

The calculation rule defines how the totals are calculated. The 
_getPositionAmountsScript_ returns the rounded amounts at position-level. The
_getContractAmountsScript_ calculates the total of the rounded positions and 
in turn may itself round the calculated totals. The _default calculation rule_ 
simply calculates the total of all contract positions without rounding or otherwise 
manipulating the totals. The totals are then stored in the fields 
_AbstractContract.totalBaseAmount_, _AbstractContract.totalDiscountAmount_, etc. 
The model allows to define any kind of calculation rule. The algorithms are implemented
in _Java_.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/contract1/999_CalculationRule.png)

A sales contract has zero or more contract positions. Important attributes of a
contract position are:

* __Position number:__ An automatically calculated sequence number.
* __Name:__ User-defined name of the position.
* __Quantity:__ Number of ordered units.
* __Product:__ Product.
* __Uom:__ Unit to be used such as _Piece(s)_, _m2_, _kg_.
* __Price per unit:__ Price of the product per unit.
* __Sales tax:__ Reference to the sales tax type object which defines the sales tax rate.

Calculation and pricing rules can be set at position-level. If they are not set the 
rules at contract-level are used as default. The operation _reprice()_ 
recalculates the _pricePerUnit_. In a first step the pricing rule determines the
price level and in a second step the corresponding price is retrieved from
the product. The price is then stored as _listPrice_ and the _pricePerUnit_ is
updated correspondingly. The automatically calculated list price can be overriden
by modifying _pricePerUnit_ manually. The derived attributes are
calculated as follows:

* __baseAmount:__ Calculated as _quantity_ * _pricePerUnit_.
* __discountAmount:__ Calculated on the _baseAmount_ by applying _discount_ and _discountIsPercentage_.
* __taxAmount:__ Calculated as (_baseAmount_ - _discountAmount_) * _salesTaxRate_.
* __amount:__ Calculated as _baseAmount_ - _discountAmount_ + _taxAmount_.

Normally _Uom (price)_ and _Uom (quantity)_ are identical. They can be different in
cases when the _Uom (quantity)_ is based on or derived from the _Uom (price)_. E.g. 1 ha # 
100 m2 * 100 m2 # 10'000 m2. If in this case _Uom (quantity)_ is set to _ha_,
_Uom (price)_ to _m2_ and _quantity_ to 5, the effective quantity used in the
calculation is _quantity_ * _Uom (quantity)_.quantity # 5 * 10'000 # 50'000. This 
feature is useful in cases where customer- or market-specific uoms must be used 
(e.g. 1 barrel # 158.9873 litres, 1 ha # 10'000 m2, 1 ton # 1000 kg). 

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/contract1/090_SalesContractPosition.png)

Both _AbstractContract_ and _AbstractContractPositon_ are _DepotReferenceHolder_s.
This allows to attach depots (see _depot1_ for more information about depots) to 
contracts and contract positions. Depot references attached at position-level override 
depots references at contract-level. The operation _updateInventory()_ executes the 
following steps:

* In case a contract position has been added or the quantity was increased a 
  _CompoundBooking_ is created with a _DebitBooking_ for the depot with usage 
  _01 - supplying goods_ and a _CreditBooking_ for the depot with usage 
  _03 - destination for deliveries_.
* In case a contract position has been removed or the quantity has been reduced
  a _CompoundBooking_ is created with a _CreditBooking_ for the depot with usage 
  _02 - accepting returns_ and a _DebitBooking_ for the depot with usage 
  _03 - destination for deliveries_.

This way bookings allow to capture the flow of items (or products) from the 
warehouse to the customer (when they are sold) and from the customer to the 
warehouse (in case when they are returned). 

_updateInventory()_ requires the following preconditions to be met:

* The name of the depot positions must match the product number, i.e.
  _updateInventory()_ creates debit and credit bookings for depot positions
  with _depotPosition.name = contractPosition.getProduct().getProductNumber()_.
  If the product does not have a product number, the product name is used instead.
  If no depot position with that name exists, a depot position is opened on-demand.
* If the depot reference has set the flag _depotHolderQualifiesPosition_ set to
  true, the depot position name is set to _product number # contract position line number_.
  This option allows to map a contract position to a depot position. 
* The following booking texts must exist
 
```
Name             Infix debit    Infix credit    Infix 1    Infix 2    Credit first
return goods     returns        accepts         returns    to         yes	
deliver goods    delivers       receives        delivers   to	      yes
```


### Package _org.opencrx.kernel.depot1_ ###
_depot1_ is an abstraction of a bank depot and as such can be used in many different
ways. A _Depot_ allows to store any type of items. Depots can be bank depots, warehouses, 
application servers, libraries, etc. Samples for items are securities, electronic 
devices, deployed software components, books in a library.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/depot1/999_Depot.png)

A depot is structured by depot positions. Depot positions are the target of a
booking. As a consequence one always has to specify the depot position when adding 
something to it or removing something from it. A depot position must contain
only items of the same kind. E.g. it is not a good idea to store _fruit_ and
_computers_ in the same depot position. If doing so, questions such as
_how many computers are stored in the depot?_ (or in other words calculating the
balance) are difficult to answer. A _ProductDepotPosition_ allows to capture 
cases where the underlying of a depot position is a product. 

Depot positions can be temporarily locked or closed. In that case no items 
can be added to or removed from it.

_Booking_ records are maintained in order to keep track of items which are 
removed from and added to depot positions. A standard booking is a special case of 
a _CompoundBooking_ and has two legs: a _CreditBooking_ and a _DebitBooking_. The 
same number of items are removed from one position (debit booking leg) and added to 
another position (credit booking leg). Compound bookings guarantee that nothing can
get lost in a depot: the sum _quantityCredit_ of all credit bookings must be equal to the sum
_quantityDebit_ of all debit bookings. In cases where this consistency is not
required a _SimpleBooking_ can be used to add or remove items from a depot position.

A booking has a value date and a booking date. The booking date is the date when
the booking was created (or when it should be reported as created). The value date
marks the time when the item is effective for the balance calculation. Bookings are 
only accepted if the booking date and the value date are within an existing and 
active booking period.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/depot1/999_Booking.png)

A depot is held by the _DepotHolder_. In most cases a depot holder is a person. 
In this case a _DepotContract_ is used to manage to relationship to the accounts. 
A depot holder can also be a _Warehouse_ or a _Site_.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/depot1/999_DepotHolder.png)

Another option to structure depots are _DepotGroup_s. The depot group structure 
is the abstraction of a chart of accounts. 

The _DepotEntity_ is the abstraction of an accounting area. It allows to define
constraints such as the definition of booking texts and booking periods. Depending on a 
company's booking policy, booking periods are created quarterly or at least yearly. 
Past booking periods typically remain open for a few days or weeks and are closed when 
all bookings are complete and controlling is done. As soon as a booking period is 
closed, no more bookings are accepted in the corresponding time periods.

![](http://www.opencrx.org/opencrx/3.0/uml/opencrx-core/depot1/999_DepotEntity.png)
 
Below you find some typical use-cases where _depot1_ can be used. 

#### Example 1: Banking Cash ####
Cash is managed in bank accounts:

* _DepotEntity:_ Booking area or branch
* _DepotHolder:_ Customer contract
* _Depot:_ Multi-currency bank account
* _DepotPosition_: One depot position for each currency
* _CompoundBooking:_ Incoming / Outgoing payment
* _SimpleBooking:_ Not used
* _DepotGroup:_ Chart of accounts

#### Example 2: Banking Securities ####
Securities are managed in bank depots:

* _DepotEntity:_ Booking area
* _DepotHolder:_ Customer contract
* _Depot:_ Depot
* _DepotPosition_: Depot position
* _CompoundBooking:_ Buy / Sell of depot positions.
* _SimpleBooking:_ Not used
* _DepotGroup:_ Chart of accounts

#### Example 3: Telco provider ####
International Telco provider which offers products such as Internet 
Access, TV on-demand, Telephone services, etc. Components are 
delivered to or installed on the customer's site.

* _DepotEntity:_ Branch
* _DepotHolder:_ Customer's site including the site's address.
* _Depot:_ Product bundle. Typically a telco product is bundled, e.g. an Internet-Access consists of several components such as Modem, TV set-top box, ADSL link, etc. 
* _DepotPosition_: Installed component.
* _CompoundBooking:_ Buy / Sell or Installation / Uninstallation of components.
* _SimpleBooking:_ Typically used to track usage of services such as duration of mobile phone calls, internet usage, tv usage, etc.
* _DepotGroup:_ Not used

#### Example 4: Warehouse ####
An international trading company managing multiple warehouses in several branches.

* _DepotEntity:_ Branch
* _DepotHolder:_ Warehouse including the warehouse's address.
* _Depot:_ Item group.  
* _DepotPosition_: Item.
* _CompoundBooking:_ Delivery of items.
* _SimpleBooking:_ not used
* _DepotGroup:_ Not used

Continue reading [Part II](30/Sdk/Modeling2/README.md).

--- End of Part I ---
