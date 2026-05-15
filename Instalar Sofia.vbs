' Sofia 2.0 — Instalador Visual para Windows
' Dois cliques neste arquivo para instalar.
' Nenhuma janela preta aparece — apenas a interface grafica.

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Caminho do script PowerShell (na mesma pasta ou em scripts/)
strDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
strPS1 = strDir & "\scripts\install-gui.ps1"

' Verificar se o arquivo PS1 existe
If Not objFSO.FileExists(strPS1) Then
    MsgBox "Arquivo de instalacao nao encontrado:" & vbCrLf & strPS1 & vbCrLf & vbCrLf & "Certifique-se de que a pasta 'scripts' esta no mesmo local que este arquivo.", vbCritical, "Sofia 2.0 — Erro"
    WScript.Quit
End If

' Lanca PowerShell sem janela visivel (0 = escondido)
objShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & strPS1 & """", 0, True
