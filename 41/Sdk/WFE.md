# Workflow Engine integration Guide #

This section shows how openCRX can be integrated with a 3rd-party workflow engine (WFE) 
on an architectural level. openCRX provides the following functions to automate
tasks:

* __Programmed tasks__: openCRX can be extended by programmed tasks. Programmed
  tasks are Java classes implementing the synchronous or asynchronous workflow interface
  which are registered as workflow tasks. Tasks can be used in activity processes.
* __Activity Processes__: Activity processes can be defined with state diagrams. 
  One or more actions (predefined or programmed tasks) are performed during transitions.
* __Scheduled Workflows__: Scheduled Workflows are (Java) programs which run in the
  background and perform (periodically) user-definable actions. Scheduled workflows 
  can either be registered with openCRX or run as stand-alone task.
* __Extension of Business Logic__: The standard business logic of openCRX can
  be customized by extending the openCRX backend classes. 

openCRX does not include a WFE because there are many existing WFEs optimized for
this task and workflows typically span multiple services and applications so openCRX
would only be a sub-system in the bigger system. Instead openCRX allows the easy 
integration with existing WFEs either using the openCRX API or the REST interface. 

Three different types of integration are discussed:

* The WFE invokes openCRX services exposed by the openCRX API.
* openCRX has a sophisticated activity management. The set of allowed
  states of an activity and the possible transitions are controlled by user-definable
  state machines. Whenever a state transition is performed a
  user-definable set of actions can be performed. Such can action can trigger a WFE.
* The GUI of openCRX can be launched by client applications (e.g. the WFE
  GUI) and the user can be navigated to open work items.
  These three integration scenarios are discussed in the next sections taking as
  sample a simplified sales order process as shown below.

![img](41/Sdk/files/WFE/pic010.png)

The process is executed by the WFE:

1. In a first step, a customer sends a request.
1. In case of a quote request, a quote is created and sent to the customer for confirmation.
1. After successful confirmation the quote is forwarded as a sales order.
1. Processing of the order (e.g. invoicing, payment, etc.).
1. After successful payment and shipment the order is completed.
1. The request is closed.
1. The quote can optionally be canceled.

We assume that several systems are involved during the execution of the workflow. In this example 
we assume that the following steps are handled within openCRX:

* Step 2: Quote request
* Step 4: Sales order request
* Step 5: Complete sales order
* Step 7: Cancel request

## Quote Request ##
When the WFE arrives at the Quote request process it performs the following actions:

1. __Via openCRX API__: Create a new quote by invoking the operation createQuote().
1. __Via openCRX API__: Fill the created quote with all available information (e.g. customer, 
   currency, order date, products, prices).
1. __Via openCRX API__: In order that the ordering process can be tracked within openCRX it 
   is strongly recommended to create a corresponding
   activity. E.g. create the activity Order #123. Attach the WFE work item
   number to this activity and link the activity with created quote. Assign
   the activity to a sales order manager.
1. __Manual__: The sales agent now sees the open activity Order #123 in its
   open activity list within openCRX. The sales manager selects the
   attached quote and completes it (pricing, etc.).
1. __Manual__: After completing the quote the sales manager performs the
   transition Complete quote on the Order #123.
1. __openCRX__: The transition Complete quote triggers WFE. Any information
   which is required by a concrete WFE implementation can be passed to
   the WFE system.
1. The WFE executes the process Send quote. This process is not performed
   by openCRX.

![img](41/Sdk/files/WFE/pic020.png)

## Sales Order Request ##
The customer receives the quote and either cancels it or confirms the sales
order. After confirmation the following steps are performed:

1. __Via openCRX API__: Look the quote created in the previous step. Activity
   number and quote number are known within WFE (they were delivered
   by the openCRX callback described in the previous section). Now create a
   sales order based on the quote with createSalesOrder().
1. __Via openCRX API__: Do a transition Create sales order on the activity
   Order #123. Link the activity with the newly created sales order.
1. __Manual__: The sales agent (which is still assigned to the activity) gets a
   follow up alert. He/she opens the sales order and verifies it. After
   verification perform the transition Complete sales order on activity Order #123.
1. __openCRX__: The transition Complete sales order triggers WFE so that it
   can proceed to the next step.
1. WFE executes the next step shipping and payment. This step can retrieve
   all required sales order information from openCRX to prepare the
   shipment and invoicing. After the payment is received the WFE proceeds
   to the next step.

![img](41/Sdk/files/WFE/pic030.png)

## Complete Sales Order ##
The complete sales order process completes all open order and
activity items. The following actions are performed on openCRX:

1. __Via openCRX API__: Perform the transition Complete sales order on
   activity Order #123. This sets the status of the action to complete and 
   unassigns the sales agent.
1. __Via openCRX API__: Optionally apply delivered material bookings.
1. __Via openCRX API__: Optionally createInvoice() and attach invoice information.

![img](41/Sdk/files/WFE/pic040.png)

## Cancel Request ##
The quote request can be canceled as shown in the figure below. The following actions
are performed on openCRX:

1. __Via openCRX API__: Perform transition Cancel order on activity Order
   #123. Optionally attach additional cancellation information.

![img](41/Sdk/files/WFE/pic050.png)

## GUI Integration ##
Most WFEs come with a standard GUI which allows users to

* get a list of all activity work items and perform actions on them
* monitor active workflows, etc.

However, typically the user works with a custom-tailored GUI. The GUI has
access to all systems, e.g. WFE and openCRX.

![img](41/Sdk/files/WFE/pic060.png)

* In the Item List pane the user sees all active work items assigned to him.
  Open work items are typically collected from all systems which are involved
  in the workflow. E.g. the GUI retrieves all active work items from the WFE,
  all open activities from openCRX, etc. In the example described above the
  user should see the entry Order #123 and its current state.
* When the user clicks on a work item the GUI of the corresponding app is
  launched. In our case this is the standard openCRX GUI or an enhanced,
  customer-specific openCRX GUI. Launching of the openCRX GUI is simple. It
  is sufficient to open a browser and navigate to the corresponding openCRX
  object. If the integration is based on the openCRX activity management this
  is typically an activity (in our example Order #123, which holds references
  to the quote, sales order and invoice). Creating a proper openCRX URL can
  be done with the class _org.openmdx.application.gui.generic.servlet.Action_.
