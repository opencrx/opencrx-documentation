# How to extend the standard GUI using PortalExtension #

This guide explains how to customize the standard GUI by extending the default portal extension.

The class _org.opencrx.kernel.portal.PortalExtension_ controls GUI-related functions of
_openCRX_. The standard implementation can be extended for custom projects very easily. Here is how.

## Create a custom project ##
First create a custom project. 
See [How to create custom projects](Sdk/CustomProject.md) for more info.

## Create a custom PortalExtension class ##
Within this custom project create a portal extension class. The class must extend
_org.opencrx.kernel.portal.PortalExtension_. The override one or more methods of
the default implementation. 

## Register in web.xml ##
Next register _com.mycompany.opencrx.sample.portal.PortalExtension_ in the _web.xml_ of 
the custom project.

## Build, Test and Deploy ##
If you run under Eclipse set break points in the _isEnabled()_ methods. You will see 
how and when Portal calls the _PortalExtension_ methods during the rendering process. 

Run _ant deliverables_ and _ant assemble_ to compile and build the EAR.
