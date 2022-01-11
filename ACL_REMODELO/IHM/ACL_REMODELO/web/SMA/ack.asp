
<% @language = "vbscript" %>
<!--#include file="config.inc"-->
<!--#include file="variables.inc"-->
<!--#include file="functions.inc"-->
<% call chkLogon %>

<%
	dim tag
	dim mytype
	dim comment
	dim ack
	dim msg
	tag = Request.QueryString("Tag")
	mytype = Request.QueryString("Type")
	msg = Request.QueryString("Message")
	comment = Request.Form("Comment")
	ack = Request.Form("ACK")
	if ack = "Yes" and mysession.IsValidLevel(ackLevel)  then
		call alarms.Ack(mysession, tag, mytype, comment, Request.ServerVariables("REMOTE_ADDR"))
		Response.Redirect("alarms.asp?n=1")
	elseif ack="No" then
		Response.Redirect("alarms.asp?n=1")
	end if	
	
	
%>


<% call CreateHeader(0) %>
	
<% call PageTitle("Ack", "logo.gif") %>

<%
	myWrite "<form method=""POST"" action=""ack.asp?Tag=" & tag & "&Type=" & myType & """>"
	myWrite "<p>Are you sure that you want to acknowledge the alarm?</p>"
%>	
	<p>Comment: <input type="text" name="Comment"></p>
	<p><input type="submit" value="Yes" name="ACK"><input type="submit" value="No" name="ACK"></p>
</form>


<% CreateFooter() %>

<p>&nbsp;</p>

</body>
</html>
