'FMA Script Framework Plugin
'Delorme Street Atlas 8.0 Plugin
'written by skyw33

'in order to have ALL functionality you will need:
'AutoIt 2.x program (not just the activex component)
'clip2txt.exe
'MS Agent (Util.say(phrase) is something I've added to the Util class for having agent speak the "phrase")
'imagemagik
'and probably other stuff I forgot


'This script is actually very old so pardon it's eclectic nature.
'I ported this from a scripting language no longer in existance to an AutoIt script  and then to VBScript when I discovered FMA's scripting framework.  Nice!
'It will NOT run perfectly without some modification directly to the script itself.


Dim A()

Class StreetAtlas8

Private m_Self
Private mainMenu        
       Private directionMenu
       Private detailMenu
               

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
 SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = g_(Me,"Street Atlas")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Lets you control Delorme Street Atlas 8.0")
End Property
Public Property Get AUTHOR 'Who created me?
 AUTHOR      = "skyw33"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
 URL = ""
End Property

'Who am I?
Public Property Let Self (s)
               
               
               
 m_Self = s
 ' Some init stuff here:
 If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Delorme Street Atlas USA"
 If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Progra~1\STREET~1.0\sa8.exe"
               If IsEmpty(Settings(Me, "MapHome"))   or Settings(Me, "MapHome")   = "" Then Settings(Me, "MapHome")   = ""
               If IsEmpty(Settings(Me, "MapFile1"))   or Settings(Me, "MapFile1")   = "" Then Settings(Me, "MapFile1")   = ""
               If IsEmpty(Settings(Me, "MapFile1Title"))   or Settings(Me, "MapFile1Title")   = "" Then Settings(Me, "MapFile1Title")   = ""
               If IsEmpty(Settings(Me, "MapFile2"))   or Settings(Me, "MapFile2")   = "" Then Settings(Me, "MapFile2")   = ""
               If IsEmpty(Settings(Me, "MapFile2Title"))   or Settings(Me, "MapFile2Title")   = "" Then Settings(Me, "MapFile2Title")   = ""
               If IsEmpty(Settings(Me, "MapFile3"))   or Settings(Me, "MapFile3")   = "" Then Settings(Me, "MapFile3")   = ""
               If IsEmpty(Settings(Me, "MapFile3Title"))   or Settings(Me, "MapFile3Title")   = "" Then Settings(Me, "MapFile3Title")   = ""
               If IsEmpty(Settings(Me, "MapFile4"))   or Settings(Me, "MapFile4")   = "" Then Settings(Me, "MapFile4")   = ""
               If IsEmpty(Settings(Me, "MapFile4Title"))   or Settings(Me, "MapFile4Title")   = "" Then Settings(Me, "MapFile4Title")   = ""
               If IsEmpty(Settings(Me, "BackOnTrack"))   or Settings(Me, "BackOnTrack")   = "" Then Settings(Me, "BackOnTrack")   = ""
               If IsEmpty(Settings(Me, "Directions"))   or Settings(Me, "Directions")   = "" Then Settings(Me, "Directions")   = ""
               If IsEmpty(Settings(Me, "Heading"))   or Settings(Me, "Heading")   = "" Then Settings(Me, "Heading")   = ""
 Set mainMenu = New ManagedMenu
               Set directionMenu = New ManagedMenu
               Set detailMenu = New ManagedMenu
 mainMenu.Title = TITLE
End Property
Public Property Get Self
 Self = m_Self
End Property

       
Sub Show()                
               
 Dim llist
 Set llist = New LinkedList
 Dim bi
 bi = llist.BackInserter
 If StreetAtlasOpen() Then                
               
  bi.Item = Array(g_(Me,"Calculate Route"), Self & ".OnAMCalcRoute")
  bi.Item = Array(g_(Me,"Get Directions"), Self & ".OnAMGetDirections")
  bi.Item = Array(g_(Me,"Back on Track"), Self & ".OnAMBackOnTrack")
                       bi.Item = Array(g_(Me,"Time/Distance"), Self & ".OnAMGetTimeDistance")
                       bi.Item = Array(g_(Me,"Guide"), Self & ".OnAMGuide")
  bi.Item = Array(g_(Me,"Heading"), Self & ".OnAMHeading")
  bi.Item = Array(g_(Me,"Miles Remaining"), Self & ".OnAMMilesRemaining")
                       bi.Item = Array(g_(Me,"Reverse Route"), Self & ".ONAMReverseRoute")
                       bi.Item = Array(g_(Me,"Set Current Location"), Self & ".OnAMSetCurrentLocation")
  bi.Item = Array(g_(Me,"Set Destination"), Self & ".OnAMSetDestination")
  bi.Item = Array(g_(Me,"Get Map"), Self & ".OnGetMap")
                       bi.Item = Array(g_(Me,"Home"), Self & ".ONAMHome")
                       bi.Item = Array(Settings(Me, "MapFile1Title"), Self & ".ONAMMap1")
                       bi.Item = Array(Settings(Me, "MapFile2Title"), Self & ".ONAMMap2")
                       bi.Item = Array(Settings(Me, "MapFile3Title"), Self & ".ONAMMap3")
                       bi.Item = Array(Settings(Me, "MapFile4Title"), Self & ".ONAMMap4")
                       bi.Item = Array("Close", Self & ".Close")
  
 Else
  Launch
 End If
 mainMenu.SetList llist
 mainMenu.ShowMenu
End Sub

Function StreetAtlasOpen
 StreetAtlasOpen = shell.AppActivate("DeLorme Street Atlas USA")
End Function

Sub Launch
       
 If Fso.FileExists(Settings(Me, "Exe")) Then
                       Shell.Exec (Settings(Me, "Exe") & " " & Settings(Me, "MapHome"))
                       Dim MyFile
                       Set MyFile= Fso.CreateTextFile(Settings(Me, "BackOnTrack"), True)
                       MyFile.WriteLine("0")
                       
  Util.WaitForAppLoad "DeLorme Street Atlas USA", 10000
 Else
  Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
 End If
 Show
End Sub

Sub Close
         if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%{F4}"
         if Shell.AppActivate("Street Atlas USA") then Shell.SendKeys "%n"
         if not Shell.AppActivate("DeLorme Street Atlas USA") then Util.say(g_(Me,"Street Atlas has been closed"))
         am.Update
End Sub



sub OnAMSetDestination
 am.DlgInputStr g_(Me,"Address"), g_(Me,"Full address:"), 100, "", "OnAMSetDestinationEvent"
end sub

sub OnAMSetDestinationEvent(str)
 dim endPos, length, beginPos, street, city, state, zip
 address = str
 beginPos = 1
 length = len(address)
 endPos = Instr(1, address, "+", 1)
 street = mid(address, beginPos, (endPos - beginPos))
 beginPos = endPos + 1
 endPos = Instr(beginPos, address, "+", 1)
 city = mid(address, beginPos, (endPos - beginPos))
 beginPos = endPos + 1
 endPos = Instr(beginPos, address, "+", 1)
 state = mid(address, beginPos, (endPos - beginPos))
 beginPos = endPos + 1
 endPos = Instr(beginPos, address, "+", 1)
 zip = mid(address, beginPos, (length - beginPos + 1))
 
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%(ga)"
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "{F7}"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "%(o)"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "{TAB 3}"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "{O 90}"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "~"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys street
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "{TAB}"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys city
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "{TAB}"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys state
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "{TAB}"
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys zip
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "%(s)"
 ActiveXManager("AutoItX.Control").RightClick 988, 407
 ActiveXManager("AutoItX.Control").Send "f"
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%(ga)"
 Shell.AppActivate("Locate by Address")
 if Shell.AppActivate("Locate by Address") then Shell.SendKeys "%(c)"
 am.Update
end sub

sub OnGetMap 'this sends the current SA map to phone as image
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "^c"
 Shell.Run "c:\progra~1\IMAGEM~1.7-Q\convert clipboard: c:\map.jpg", 2, true
 Shell.Run "c:\progra~1\IMAGEM~1.7-Q\convert -sample 128x160! c:\map.jpg c:\map2.jpg", 2, true
 obexput "c:\map2.jpg"
end sub

sub OnAMGetDirections
 Dim tempList, backIns
 Set tempList = New LinkedList
 backIns = tempList.BackInserter
 
 Shell.SendKeys "%(ec)"
 Dim MyFileRead, line, rows, GetLine
 Dim Road, Leg, Time, Dist, Dir, Near, HwExit
 Set MyFileRead = Fso.CreateTextFile(Settings(Me, "Directions"), True)
 MyFileRead.Write(ActiveXManager("AutoItX.Control").ClipGet)
 MyFileRead.Close
 rows = 0
 Set MyFile1 = Fso.OpenTextFile(Settings(Me, "Directions"), FILE_FOR_READING)
 
 Do While MyFile1.AtEndOfStream <> True
   MyFile1.ReadLine
   GetLine = MyFile1.Line
 loop
 MyFile1.Close
 redim A(GetLine, 6)
 Set MyFile = Fso.OpenTextFile(Settings(Me, "Directions"), FILE_FOR_READING)
 MyFile.SkipLine
 MyFile.SkipLine
 Do While MyFile.AtEndOfStream <> True
   
       line = MyFile.ReadLine
       Dim regEx, Match, Matches
       Set regEx = New RegExp
       regEx.Pattern = "(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)\t(.*)"
       regEx.Global = True
       
       Dim retVal
       retVal = regEx.Test(line)
       If retVal Then
         Set Matches = regEx.Execute(line)
         Set Match = Matches(0)
         A(rows, 0) = Match.SubMatches(0) 'Road
         A(rows, 1) = Match.SubMatches(1) 'Leg
         A(rows, 2) = Match.SubMatches(2) 'Time
         A(rows, 3) = Match.SubMatches(3) 'Dist
         A(rows, 4) = Match.SubMatches(4) 'Dir
         A(rows, 5) = Match.SubMatches(5) 'Near
         A(rows, 6) = Match.SubMatches(6) 'HwExit
       Else
         regEx.Pattern = "(.*)\t(.*)\t(.*)\t(.*)" 
         Set Matches = regEx.Execute(line)
         Set Match = Matches(0)
         A(rows, 0) = Match.SubMatches(0) 'Road
         A(rows, 2) = Match.SubMatches(2) 'Time
         A(rows, 3) = Match.SubMatches(3) 'Dist
       End If
   backIns.Item = Array(A(rows, 4) & " " & A(rows, 0) & " " & A(rows, 1), Self & ".playdir(" & rows & ")" )
   rows = rows + 1
 Loop
 MyFile.Close
 'am.Update
 
 directionMenu.SetList tempList
 directionMenu.Title = g_(Me,"Directions")
 directionMenu.ShowMenu
end sub



Function filter(str)
 Dim s, i, i2
 s = Trim(Str)
 filter = replace(s,Chr(34),"''")
End Function




Function ReadableDir(dir)
 Dim readable
 If (dir = "N") Then 
   readable = g_(Me,"North")
 ElseIf (dir = "S") Then 
   readable = g_(Me,"South")
 ElseIf (dir = "E") Then 
   readable = g_(Me,"East")
 ElseIf (dir = "W") Then 
   readable = g_(Me,"West")
 ElseIf (dir = "SW") Then 
   readable = g_(Me,"Southwest")
 ElseIf (dir = "SE") Then 
   readable = g_(Me,"Southeast")
 ElseIf (dir = "NE") Then 
   readable = g_(Me,"Northeast")
 ElseIf (dir = "NW") Then 
   readable = g_(Me,"Northwest")
 End If
 ReadableDir = readable
End Function


Sub playDir(i)
 Dim Road, Leg, Time, Dist, Dir, Near, HwExit
 Dim tempList, backIns
 Set tempList = New LinkedList
 backIns = tempList.BackInserter

 Road = Filter(A(i, 0))
 Leg = Filter(A(i, 1))
 Time = Filter(A(i, 2))
 Dist = Filter(A(i, 3))
 Dir = Filter(A(i, 4))
 Near = Filter(A(i, 5))
 HwExit = Filter(A(i, 6))

 line1 = g_(Me,"Go ") & ReadableDir(Dir) & g_(Me," on")
 line2 = Road
 line3 = g_(Me,"Near ") & Near
 line4 = g_(Me,"for ") & Leg & g_(Me," mi")
 line5 = g_(Me,"So Far: ") & Dist & g_(Me," mi")
 line6 = g_(Me,"Elapsed: ") & Time
 line7 = g_(Me,"Exit: ") & HwExit
 backIns.Item = Array(line1, "" )
 backIns.Item = Array(line2, "" )
 backIns.Item = Array(line3, "" )
 backIns.Item = Array(line4, "" )
 backIns.Item = Array(line5, "" )
 backIns.Item = Array(line6, "" )
 backIns.Item = Array(line7, "" )
 
 detailMenu.SetList tempList
 detailMenu.Title = g_(Me,"Directions")
 detailMenu.ShowMenu
End Sub


sub OnAMCalcRoute
 if Shell.AppActivate("Monitor GPS Status") then
   PoorGPS
 else  
   if Shell.AppActivate("Delorme Street Atlas USA") then Shell.SendKeys "^q"
   if not Shell.AppActivate("Calculating Route") then Shell.SendKeys "%y"
 end if
 am.Update
end sub

sub PoorGPS
 Util.say(g_(Me,"There is poor GPS coverage.  Please try again later."))
 if Shell.AppActivate("DeLorme GPS Notification") then Shell.SendKeys "~"
end sub


sub OnAMBackOnTrack
 Dim MyFile, yesno
 Set MyFile = Fso.OpenTextFile(Settings(Me, "BackOnTrack"), 1)
 yesno = MyFile.ReadLine
 Set MyFile = Fso.OpenTextFile(Settings(Me, "BackOnTrack"), 2)
 if yesno = 0 then
   MyFile.WriteLine("1")
   MyFile.Close
   if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%(gb)"
   Util.say(g_(Me,"Back on track is on"))
 else
   MyFile.WriteLine("0")
   MyFile.Close
   if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%(gb)"
   Util.say(g_(Me,"Back on track is off"))
 End If
 am.Update
end sub


sub OnAMGetTimeDistance
end sub


sub OnAMGuide
 if Shell.AppActivate("Monitor GPS Status") then
   PoorGPS
 else
   Util.say(g_(Me,"You are currently on "))
   Util.Sleep(3000)
   if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "+{END}"
   Util.Sleep(2000)
   if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "{INSERT}"
 end if
 am.Update
end sub

sub OnAMMinimizeAtlas
end sub

sub OnAMRestoreAtlas
end sub

sub OnAMHeading
 if Shell.AppActivate("Monitor GPS Status") then
   PoorGPS
 else
   Shell.Run "c:\progra~1\autoit\autoit.exe /reveal"
   Shell.Run "cmd /c del " & Settings(Me, "Heading"), 0, false
   if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%(gm)"
   Util.Sleep(1000)
   if Shell.AppActivate("Monitor GPS Status") then Shell.AppActivate("AutoIt")
   Shell.SendKeys "{PGDN}"
   Shell.SendKeys "+{PGDN}"
   Shell.SendKeys "+{END}"
   Shell.SendKeys "^c"
   Shell.Run "c:\clip2txt.exe " & Settings(Me, "Heading"), 0, false
   Shell.SendKeys "%{F4}"
   Util.Sleep(200)
   Dim fso, MyFile, speed, heading, elevation, direction
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set MyFile = fso.OpenTextFile(Settings(Me, "Heading"), 1)
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   heading = MyFile.ReadLine
   speed = MyFile.ReadLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   MyFile.SkipLine
   elevation = MyFile.ReadLine
   if heading >= 0 then direction = g_(Me,"north")
   if heading >= 11.25 then direction = g_(Me,"north north east")
   if heading >= 33.75 then direction = g_(Me,"north east")
   if heading >= 56.25 then direction = g_(Me,"east north east")
   if heading >= 78.75 then direction = g_(Me,"east")
   if heading >= 101.25 then direction = g_(Me,"east south east")
   if heading >= 123.75 then direction = g_(Me,"south east")
   if heading >= 146.25 then direction = g_(Me,"south south east")
   if heading >= 168.75 then direction = g_(Me,"south")
   if heading >= 191.25 then direction = g_(Me,"south south west")
   if heading >= 213.75 then direction = g_(Me,"south west")
   if heading >= 236.25 then direction = g_(Me,"west south west")
   if heading >= 258.75 then direction = g_(Me,"west")
   if heading >= 281.25 then direction = g_(Me,"west north west")
   if heading >= 303.75 then direction = g_(Me,"north west")
   if heading >= 326.25 then direction = g_(Me,"north north west")
   if heading >= 348.75 then direction = g_(Me,"north")
   MyFile.close
   speed = Round(speed, 0)
   elevation = Round(elevation, 0)
   Util.say(g_(Me,"You are headed ") & direction & g_(Me," going ") & speed & g_(Me," miles per hour at ") & elevation & g_(Me," feet above sea level."))
 end if
 am.Update
end sub





sub OnAMMilesRemaining
end sub

sub OnAMReverseRoute
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "%(pmr)"
 Util.say(g_(Me,"The route has been reversed."))
 am.Update
end sub

sub OnAMSetCurrentLocation
end sub

sub OnAMHome
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "^o"
 dim timeup, currentTime, nextTime
 timeup = 0
 currentTime = Timer
 While (not Shell.AppActivate("Open")) and (not timeup)
   nextTime = Timer
   if ((nextTime - currentTime) > 5) then
     timeup = 1
   end if
 Wend
 if Shell.AppActivate("Open") then Shell.SendKeys Settings(Me, "MapHome")
 Shell.SendKeys "~"
 Util.Sleep(1000)
 Shell.SendKeys "%n"
 Util.say(g_(Me,"The destination is home"))
 am.Update
end sub

sub OnAMMap1
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "^o"
 dim timeup, currentTime, nextTime
 timeup = 0
 currentTime = Timer
 While (not Shell.AppActivate("Open")) and (not timeup)
   nextTime = Timer
   if ((nextTime - currentTime) > 5) then
     timeup = 1
   end if
 Wend
 if Shell.AppActivate("Open") then Shell.SendKeys Settings(Me, "MapFile1")
 Shell.SendKeys "~"
 Util.Sleep(1000)
 Shell.SendKeys "%n"
 Util.say(g_(Me,"The destination is ") & Settings(Me, "MapFile1Title"))
 am.Update
end sub

sub OnAMMap3
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "^o"
 dim timeup, currentTime, nextTime
 timeup = 0
 currentTime = Timer
 While (not Shell.AppActivate("Open")) and (not timeup)
   nextTime = Timer
   if ((nextTime - currentTime) > 5) then
   timeup = 1
   end if
 Wend
 if Shell.AppActivate("Open") then Shell.SendKeys Settings(Me, "MapFile3")
 Shell.SendKeys "~"
 Util.Sleep(1000)
 Shell.SendKeys "%n"
 Util.say(g_(Me,"The destination is ") & Settings(Me, "MapFile3Title"))
 am.Update
end sub

sub OnAMMap4
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "^o"
 dim timeup, currentTime, nextTime
 timeup = 0
 currentTime = Timer
 While (not Shell.AppActivate("Open")) and (not timeup)
   nextTime = Timer
   if ((nextTime - currentTime) > 5) then
     timeup = 1
   end if
 Wend
 if Shell.AppActivate("Open") then Shell.SendKeys Settings(Me, "MapFile4")
 Shell.SendKeys "~"
 Util.Sleep(1000)
 Shell.SendKeys "%n"
 Util.say(g_(Me,"The destination is ") & Settings(Me, "MapFile4Title"))
 am.Update
end sub

sub OnAMMap2
 if Shell.AppActivate("DeLorme Street Atlas USA") then Shell.SendKeys "^o"
 dim timeup, currentTime, nextTime
 timeup = 0
 currentTime = Timer
 While (not Shell.AppActivate("Open")) and (not timeup)
   nextTime = Timer
   if ((nextTime - currentTime) > 5) then
     timeup = 1
   end if
 Wend
 fma.debug Settings(Me, "MapFile2")
 if Shell.AppActivate("Open") then Shell.SendKeys Settings(Me, "MapFile2")
 Shell.SendKeys "~"
 Util.Sleep(1000)
 Shell.SendKeys "%n"
 Util.say(g_(Me,"The destination is ") & Settings(Me, "MapFile2Title"))
 am.Update
end sub


End Class
