<%
Dim isProcessTagsEnabled
Dim isEnabled
Dim logonExpiration
Dim stateColumn
Dim typeColumn
Dim timeColumn
Dim tagColumn
Dim msgColumn
Dim accessLevel
Dim ackLevel
dim writeLevel
Dim dateFormat
Dim tagRefresh
dim alarmRefresh
dim showLogo
dim emptyString
dim allowAck


'Alarm list columns
typeColumn = True
stateColumn = True
timeColumn = True
tagColumn = False
msgColumn = True
accessLevel =0
ackLevel =0
writeLevel =0
dateFormat = 4
alarmRefresh =60
tagRefresh =60
showLogo = true
emptyString = "Empty"
logonExpiration = 600
allowAck = True
isEnabled=False
isProcessTagsEnabled=False

'***!!!***Start tag list***!!!***=0
Dim tagList(0)
Dim tagLabels(0)
Dim tagWrite(0)
'***!!!***End tag list***!!!***=0
%>