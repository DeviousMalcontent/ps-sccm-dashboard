'Bypass execution policy bullshit
set shell = CreateObject("WScript.Shell")
command = "powershell.exe -executionpolicy bypass -nologo -command " & shell.CurrentDirectory & "\Server.ps1"
shell.Run command,1