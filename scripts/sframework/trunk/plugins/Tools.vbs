'FMA Script Framework Plugin
'Tools
'aka the first useful plugin for this framework ^^

'Windows shutdown:
'RunDll32.EXE Shell32.Dll,SHExitWindowsEx n 
'0 = Abmelden (== Neu anmelden) (8,16,32,64,128; -1) 
'1 = Runterfahren und Ausschalten 
'2 = Neu Booten 
'4 = Alle aktiven Programme abwürgen

'TODO:
'-Test logoff, shutdown, reboot

Class Tools
	
	Private List
	Private m_Self
	Private m_MenuReg
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"General tools")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Miscellaneous stuff to interact with the PC")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "dVrVm"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		Set List = New LinkedList
		Dim bi
		bi = List.BackInserter
		bi.Item = Array( g_(Me,"Monitor off"),    s & ".MonOff" )
		bi.Item = Array( g_(Me,"Monitor on"),     s & ".MonOn" )
		bi.Item = Array( g_(Me,"Lock WS"),        s & ".Lock" )
		bi.Item = Array( g_(Me,"Log off"),        s & ".LogOff" )
		bi.Item = Array( g_(Me,"Hibernate"),      s & ".Hibernate" )
		bi.Item = Array( g_(Me,"Shutdown"),       s & ".Shutdown" )
		bi.Item = Array( g_(Me,"Reboot"),         s & ".Reboot" )
		bi.Item = Array( g_(Me,"Cancel Shutdown"),s & ".CancelShutdown" )
		bi.Item = Array( g_(Me,"Disconnect FMA"), s & ".Disconnect" )
		bi.Item = Array( g_(Me,"Disconnect Temporary"), s & ".DisconnectTemp" )
		bi.Item = Array( g_(Me,"Close FMA"),      s & ".CloseFMA" )
		If IsEmpty(Settings(Me, "FMATitle")) or Settings(Me, "FMATitle") = "" Then Settings(Me, "FMATitle") = "floAt's Mobile Agent"
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
		mainMenu.SetList List
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		mainMenu.ShowMenu
	End Sub
	
	' Locks the workstation
	Sub Lock
		Shell.Run "Rundll32.exe user32.dll,LockWorkStation"
		am.Update
	End Sub
	
	' Log off the current user
	Sub LogOff
		Shell.Run "LogOff"
		am.Update
		fma.Disconnect
	End Sub
	
	' Shuts down the PC
	Sub Shutdown
		'Shell.Run "RunDll32.EXE Shell32.Dll,SHExitWindowsEx 1"
		Shell.Run "shutdown -f -s -t 30"
		am.Title = g_(Me,"Shutdown..")
		fma.Disconnect
	End Sub
	
	' Reboots the PC
	Sub Reboot
		'Shell.Run "RunDll32.EXE Shell32.Dll,SHExitWindowsEx 2"
		Shell.Run "shutdown -f -r -t 30"
		am.Title = g_(Me,"Reboot..")
		fma.Disconnect
	End Sub
	
	Sub CancelShutdown
		Shell.Run "shutdown.exe -a"
		am.Title = g_(Me,"Canceled")
		am.Update
	End Sub
	
	' Hibernate
	Sub Hibernate
		Shell.Run "Rundll32.exe powrprof.dll,SetSuspendState"
		fma.Disconnect
	End Sub
	
	' Disconnects the mobile phone from FMA
	Sub Disconnect
		fma.Disconnect
	End Sub

	' Disconnects temporary the mobile phone from FMA to allow disable BT connection and keep autoconnect alive
	Sub DisconnectTemp
		fma.DisconnectTemporary
	End Sub

	' Closes FMA
	Sub CloseFMA
		If Shell.AppActivate(Settings(Me, "FMATitle")) Then Shell.SendKeys "%{F4}"
	End Sub
	
	' Switches the monitor off
	Sub MonOff
		Shell.Exec ScriptFolder & "helper\moncloser 0"
		am.Update
	End Sub	
	
	' Switches the monitor on
	Sub MonOn
		Shell.Exec ScriptFolder & "helper\moncloser 1"
		am.Update
	End Sub
	
End Class