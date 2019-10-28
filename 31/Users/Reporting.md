# Reporting #

openCRX provides various technologies that enable you to create reports of a wide variety, anything from simple ad-hoc reports to large scale bulk reports.

## MS Word, LibreOffice Writer, OpenOffice Writer, etc. ##
openCRX supports the JSP-wizard-based generation of RTF documents. You can generate RTF documents from scratch or merge data with existing RTF templates. The RTF documents are generated on the fly and can be opened with any RTF-compatible word processor including OpenOffice Writer and MS Word.

You can test this feature on our demo server (or on your own installation if you installed the openCRX Server) with the following steps: 

* connect and login as user guest
* navigate to any contact and execute the operation _Tools > Mail Merge --> RTF Document_
* the wizard will provide a list of suitable templates and then generate the RTF document on the fly:

![img](Users/files/Reporting/pic010.png)

If you installed the openCRX SDK you will find the templates and the JSP wizard in the following locations:

* _SDK_Install_Dir/opencrx2/core/src/data/org.opencrx/documents_
* _SDK_Install_Dir/opencrx2/core/src/data/org.opencrx/wizards/en_US/MailMerge.jsp

With this approach it is quite easy to generate all kinds of documents, including letters, invoices, purchase orders, etc.

## Large Scale Reporting ##
If your task is to produce a large number of reports (e.g. monthly reporting for all your clients) or reports based on large amounts of data, spreadsheet-based reporting is probably not the way to go. Maybe you want to generate reports in a format other than XLS. On the one hand, openCRX already includes libraries to generate reports and documents in various formats, on the other hand you can easily add additional libraries to openCRX.

Format | Library / Additional Information
-------|---------------------------------
XLS    | Apache POI / http://poi.apache.org/
PDF    | iText / http://www.lowagie.com/iText/
RTF    | Simple RTF Writer / org.opencrx.kernel.utils.rtf

Obviously, there are many more possibilities, like for example exporting data in XML format and then doing some kind of fancy transformation.

In terms of how to generate your reports, there are also various options available depending on your preferences:

### JSP-Based Reporting ###
This approach is typically recommended if you need on-demand reporting and the generation of the report does not put an undue burden on the server. The following screen shot shows an example HTML-report:

![img](Users/files/Reporting/pic020.png)

### Java Program ###
Large-scale batch reporting can be done with a Java Program (basically an openCRX client programmed in Java that prepares the desired reports).

### BI-Reporting Suite ###
If you plan to use a BI-Reporting Suite (e.g. Crystal Reports, Pentaho, BIRT, etc.), you should keep in mind that directly accessing the openCRX database is not a very good idea. We strongly recommend you either retrieve data through the openCRX API (e.g. with REST) or set up a dedicated reporting DB (the process to populate such a reporting DB should retrieve data from the openCRX DB through the openCRX API). The reason for not accessing the openCRX database directly is the following one: while the openCRX API is stable, the OO-to-relational mapping is not and hence the schema of the openCRX DB is subject to change over time. Hence, if you access the openCRX DB directly you will have to adapt your reports if the DB schema changes, a potentially expensive proposition. Furthermore, whenever you access the openCRX DB directly there is no access control.
