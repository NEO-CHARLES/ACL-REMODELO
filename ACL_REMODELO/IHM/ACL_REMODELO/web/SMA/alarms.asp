
<% @language = "vbscript" %>
<!--#include file="config.inc"-->
<!--#include file="variables.inc"-->
<!--#include file="functions.inc"-->
<% call chkLogon %>

<%
Response.ExpiresAbsolute=#May 31,2001 13:30:15#
 %>

<% call CreateHeader(alarmRefresh) %>

<body>

<% call PageTitle("Alarms", "logo.gif") %>

<% call PageDefaultMenu() %>

<%

	Sub StartTable()
		myWrite "<table>"
		chkWrite "<th>State</th>", stateColumn		
		chkWrite "<th class=""alrmessage"">Message</th>", msgColumn		
		chkWrite "<th>Type</th>", typeColumn
		chkWrite "<th>Time</th>", timeColumn
		chkWrite "<th class=""alrtag"">Tag</th>", tagColumn
	end sub 
	
	Sub EndTable()
		myWrite "</table>"
	end sub
	
	Sub AddRow(state, time, tag, altype, msg)
		myWrite "<tr>"
		select case state
			case 0 chkWrite "<td><img src=""active.gif"" alt=""Active""/></td>", stateColumn
			case 1 chkWrite "<td><img src=""ack.gif"" alt=""ack""/></td >", stateColumn
			case 2 chkWrite "<td><img src=""inactive.gif"" alt=""Inactive""/></td>", stateColumn
			case else chkWrite "<td>< img=""error.gif"" alt=""Error"" /></td>", stateColumn
		end select
		if mysession.IsValidLevel(ackLevel) and  state <> 1 and allowAck then
			dim ackInfo
			ackInfo = "ack.asp?Tag=" & tag & "&Type="&altype
			chkWrite "<td><a href=" & ackInfo & ">" & msg &"</a></td>", msgColumn
		else
			chkWrite "<td>" & msg & "</td>", msgColumn
		end if
		chkWrite "<td>" & altype &"</td>", typeColumn		
		chkWrite "<td>" & FormatDateTime(time, dateFormat) &"</td>", timeColumn	
		chkWrite "<td>" & tag &"</td>", tagColumn
		myWrite "</tr>"
	end Sub

	dim alarmItem
	dim numitems
	numitems = alarms.NumItems
	if numitems = 0 then
		myWrite "There are no alarms to be listed"
	else
		StartTable
		for i=0 to numitems-1
			set alarmItem = alarms.item(i)
			call AddRow(alarmItem.State, alarmItem.TimeStamp, alarmItem.Tag, alarmItem.Type, alarmItem.Message)	
		next
		EndTable
			
	end if
	
%>

<% CreateFooter() %>

<p>&nbsp;</p>

</body>
</html>
