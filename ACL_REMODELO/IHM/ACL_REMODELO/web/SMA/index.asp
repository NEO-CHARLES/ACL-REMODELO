
<% @language = "vbscript" %>
<!--#include file="config.inc"-->
<!--#include file="variables.inc"-->
<!--#include file="functions.inc"-->
<% call chkLogon %>

<html>
<% call CreateHeader(0) %>

<body>
<% call PageTitle("Main menu", "logo.gif") %>
<p><a href="alarms.asp?n=1">Alarms</a></p>
<%
	if isProcessTagsEnabled then
		myWriteLn "<p><a href=""Tags.asp?n=2"">Process</a></p>"
	end if
%>
<p><a href="LogOn.asp?LogOff=Yes"> Log Off </a></p>

<%
	

	
	sub LoadMainMenu()
		
	end sub
	
	'Start verification code
	call LoadMainMenu
	
%>

<% CreateFooter() %>

<p>&nbsp;</p>

</body>
</html>
