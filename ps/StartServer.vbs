set shell = CreateObject("WScript.Shell")
command = "powershell.exe -executionpolicy bypass -nologo -command " & shell.CurrentDirectory & "\Server.ps1"
shell.Run command,1

'debug - Kinda pointless now because the script requires admin rights and results in a new window. 
'command = "powershell.exe -NoExit -executionpolicy bypass -nologo -command " & shell.CurrentDirectory & "\Server.ps1"