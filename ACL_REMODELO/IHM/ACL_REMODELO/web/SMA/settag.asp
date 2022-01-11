
<% @language = "vbscript" %>
<!--#include file="config.inc"-->
<!--#include file="variables.inc"-->
<!--#include file="functions.inc"-->
<% call chkLogon %>

<%
	dim tag
	dim mytype
	dim comment
	dim action
	dim value
	dim error
	dim vIndex, vOK
	
	tag = Request.QueryString("Tag")
	mytype = Request.QueryString("Type")
	msg = Request.QueryString("Message")
	value = Request.Form("Value")
	action = Request.Form("ACTION")
	
	'Verify if the TAG being passed is a valid
	vOK = 0
	for vIndex = 0 to (UBound(tagList)-1)
		if tagList(vIndex) = tag then
			if tagWrite(vIndex)=True then
				vOK = 1
			end if
		end if
	next
	
	if vOK = 0 then
		Response.Redirect("LogOn.asp")
	end if
	

	
	On Error Resume Next
	if mysession.IsValidLevel(writeLevel) = false then
		Response.Redirect("LogOn.asp")
	elseif action = "Cancel" then
		Response.Redirect("tags.asp")
	elseif mytype = 0 and value <> "" then
		if value = "On" then
			tags.Value(tag) = "1"
		else
			tags.Value(tag) = "0"
		end if
		if err.number = 0 then
			Response.Redirect("tags.asp")
		end if
	elseif action <> "" then
		tags.Value(tag) = value
		if err.number = 0 then
			Response.Redirect("tags.asp")
		end if
	else
		value = tags.Value(tag)
	end if
	
	if err.number <> 0 then
		error = true
	else
		error = false	
	end if	
%>


<% call CreateHeader(0) %>

<% call PageTitle("Set Tag", "logo.gif") %>

<%
	myWrite "<form method=""POST"" action=""settag.asp?Tag=" & tag & "&Type=" & myType & """>"
	if mytype = 0 then
		dim onBold
		dim offBold
		if value = "1" then
			onBold = "style=""font-weight: bold"""
			offBold = ""
		else
			onBold = ""
			offBold = "style=""font-weight: bold"""
		end if
		myWrite "<input type=""submit"" value=""On"" name=""Value""" & onBold &">"
		myWrite "<input type=""submit"" value=""Off"" name=""Value""" & offBold & ">"
	else
		myWrite "<p>New value: <input type=""text"" name=""Value"" value="""& value &""">"
		myWrite "<input type=""submit"" value=""Set"" name=""ACTION""></p>"
	end if
	if error then
		myWrite "<p>Fail to write!!!</p>"
	end if
	myWrite "<p><input type=""submit"" value=""Cancel"" name=""ACTION""></p>"
	myWrite "</form>"
%>

<% CreateFooter() %>

<p>&nbsp;</p>

</body>
</html>
