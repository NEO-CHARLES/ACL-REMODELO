
<% @language = "vbscript" %>
<!--#include file="config.inc"-->
<!--#include file="variables.inc"-->
<!--#include file="functions.inc"-->
<% call chkLogon %>

<%
Response.ExpiresAbsolute=#May 31,2001 13:30:15#
 %>

<% call CreateHeader(tagRefresh) %>

<body>

<% call PageTitle("Process", "logo.gif") %>

<% call PageDefaultMenu() %>

<%

	Sub StartTable()
		myWrite "<table>"
		myWrite "<th class=""tagdescription"">Description</th>"
		myWrite "<th>Value</th>"
	end sub 
	
	Sub EndTable()
		myWrite "</table>"
	end sub
	
	Sub AddRow(tag, desc, value, tagtype, canWrite)
		dim myvalue
		dim tagInfo
		if desc = "" then
		    desc = tag
		end if
		tagInfo = "settag.asp?Tag=" & tag & "&Type="&tagtype
		myWrite "<tr>"
		myWrite "<td class=""description"">" & desc &"</td>"
		if tagtype = 0 then
			if value = "1" then
				myvalue = "On"
			else
				myvalue = "Off"
			end if
		else
			myvalue = value
		end if
		if myvalue = "" then
			myvalue = emptyString
		end if
		if mysession.IsValidLevel(writeLevel) and canWrite then
			myWrite "<td><a href="& tagInfo &">" & myvalue &"</a></td>"
		else
			myWrite "<td>" & myvalue &"</td>"
		end if
		myWrite "</tr>"
	end Sub

	dim tag
	dim numitems
	numitems = UBound(tagList)
	if numitems = 0 then
		myWrite "There are no tags to be listed"
	else
		StartTable
		for i=0 to numitems-1
			On Error Resume Next
			call AddRow(tagList(i), tagLabels(i), tags.Value(tagList(i)), tags.Type(tagList(i)), tagWrite(i))	
		next
		EndTable			
	end if
	
%>

<% CreateFooter() %>

<p>&nbsp;</p>

</body>
</html>
