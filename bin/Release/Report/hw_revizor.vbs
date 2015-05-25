Const ForReading = 1

Const ForWriting = 2

 

strComputer = "."

 

 

 

'Set objComputer = CreateObject("Shell.LocalMachine")

 

Set objWMIService = GetObject( "winmgmts://./root/cimv2" )

               

                Set colItems = objWMIService.ExecQuery( "Select * from Win32_ComputerSystem", "WQL", 48 )

               

                For Each objItem in colItems

                               strComputer = objItem.Name

                Next

 

Set objFSO = CreateObject("Scripting.FileSystemObject")

 

Set objCommentFile = objFSO.OpenTextFile(strComputer & ".ini",  ForWriting, TRUE)

 

 

on error resume next

 

objCommentFile.Write "[��������� ����������]"

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

 

               

objCommentFile.Write "���������|��� ����������= " & strComputer & VbCrLf

 

on error resume next

Set colItems = objWMIService.ExecQuery("SELECT TotalVisibleMemorySize FROM Win32_OperatingSystem")

If Err Then ShowError

 

For Each objItem in colItems

     objCommentFile.Write "��������� �����|��������� ������= " & (((objItem.TotalVisibleMemorySize +1023) / 1024) / 1024) & " ��"  & VbCrLf

Next

 

on error resume next

Set colItems = objWMIService.ExecQuery("SELECT Name FROM Win32_Keyboard")

For Each objItem in colItems

    objCommentFile.Write "����|����������= " & objItem.Name & VbCrLf

Next

on error resume next

Set colMice = objWMIService.ExecQuery _
    ("Select * from Win32_PointingDevice")

 

For Each objMouse in colMice

     objCommentFile.Write "����|����= " & objMouse.HardwareType & VbCrLf

 

Next

on error resume next

Set colItems = objWMIService.ExecQuery("SELECT Description, Manufacturer FROM Win32_SoundDevice")

i=1

For Each objItem in colItems

    objCommentFile.Write "�����������|�������� �������" & i & "=" & objItem.Description & VbCrLf

    i=i+1

Next

on error resume next

Set colItems = objWMIService.ExecQuery("SELECT Product, OtherIdentifyingInfo, SerialNumber, Manufacturer FROM Win32_BaseBoard")

 

For Each objItem in colItems

 

objCommentFile.Write "DMI|DMI �������� ����� ��������� �����= " & objItem.SerialNumber & VbCrLf

 

Next

 

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[DMI]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

on error resume next

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

 

Set colItems = objWMIService.ExecQuery("SELECT Name, CurrentClockSpeed, SocketDesignation, Manufacturer FROM Win32_Processor")

 

i=1

For Each objItem in colItems

   objCommentFile.Write "����������" & i & "|�������� ����������|�������������= " & objItem.Manufacturer & VbCrLf

   objCommentFile.Write "����������" & i & "|�������� ����������|������= " & objItem.Name & VbCrLf

   objCommentFile.Write "����������" & i & "|�������� ����������|��� �������= " & objItem.SocketDesignation & VbCrLf

   objCommentFile.Write "����������" & i & "|�������� ����������|������� �������= " & objItem.CurrentClockSpeed & VbCrLf

i=i+1

Next

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[��������� �����]"

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set colItems = objWMIService.ExecQuery("SELECT Product, OtherIdentifyingInfo, SerialNumber, Manufacturer FROM Win32_BaseBoard")

 

For Each objItem in colItems

 

 

objCommentFile.Write "������������� ��������� �����|�����= " & objItem.Manufacturer & VbCrLf

objCommentFile.Write "�������� ��������� �����|��������� �����= " & objItem.Product & VbCrLf

objCommentFile.Write "DMI|DMI �������� ����� ��������� �����= " & objItem.SerialNumber & VbCrLf

 

Next

 

 

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[����� Windows]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set colItems = objWMIService.ExecQuery ("SELECT Name, AdapterRAM FROM Win32_VideoController")

i=1

For Each objItem in colItems

    objCommentFile.Write "����� Windows" & i & "|�������� �������������|����� ��������= " & (((objItem.AdapterRAM) / 1024) / 1024) & " ��."  & VbCrLf

    objCommentFile.Write "����� Windows" & i & "|�������� �������������|�������� ����������= " & objItem.Name  & VbCrLf

i=i+1

Next

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[�������]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DesktopMonitor")

i=1

For Each objItem in colItems

   

objCommentFile.Write "�������" & i & "|�������� ��������|��� ��������= " & objItem.Name  & VbCrLf

objCommentFile.Write "�������" & i & "|�������� ��������|ID ��������= " & objItem.DeviceID  & VbCrLf

objCommentFile.Write "�������" & i & "|������������� ��������|�����= " & objItem.MonitorManufacturer  & VbCrLf

objCommentFile.Write "�������" & i & "|�������� ��������|��� ��������= " & objItem.DisplayType  & VbCrLf

i=i+1

Next

 

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[ATA]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set colDiskDrives = objWMIService.ExecQuery ("SELECT Model, size, Manufacturer FROM Win32_DiskDrive")

 

i=1

For each objDiskDrive in colDiskDrives

 

   objCommentFile.Write "ATA" & i & "|������������� ATA-����������|�����= " & objDiskDrive.Manufacturer  & VbCrLf

   objCommentFile.Write "ATA" & i & "|�������� ���������� ATA|ID ������= " & objDiskDrive.Model  & VbCrLf

   objCommentFile.Write "ATA" & i & "|���������� ������ ���������� ATA|��������������� �������= " & ((objDiskDrive.Size /1024)/1024)/1024  & VbCrLf     

    

    i=i+1

Next

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[���������� ����������]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set colItems = objWMIService.ExecQuery("Select * from Win32_CDROMDrive")

i=1

For Each objItem in colItems

 

    objCommentFile.Write "���������� ����������" & i & "|�������� ����������� ����������|�������������= " & objItem.Manufacturer  & VbCrLf

    objCommentFile.Write "���������� ����������" & i & "|�������� ����������� ����������|�������� ����������= " & objItem.Name  & VbCrLf

   

    i=i+1

Next

 

 

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[��������]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set colInstalledPrinters =  objWMIService.ExecQuery ("SELECT Name FROM Win32_Printer")

i=1

For each objPrinter in colInstalledPrinters

 

if objPrinter.Name = "Fax" or objPrinter.Name = "Microsoft XPS Document Writer" then

 

else

    objCommentFile.Write "��������" & i & "|�������� ��������|��� ��������= " & objPrinter.Name   & VbCrLf

     i=i+1

end if

Next

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[���� Windows]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

'######################################################################################################

 

on error resume next

Set colItems = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")

On Error Resume Next

 

i=1

For Each objItem in colItems

 

 

For Each arrValue In arrIPAddress

 

If Not IsNull(objItem.IPAddress) Then

      For z = 0 To UBound(objItem.IPAddress)

        objCommentFile.Write  "���� Windows" & i & "|������ �������� ��������|����� IP / �������= " & objItem.IPAddress(z)  & VbCrLf

      i=i+1

Next

   End If

 

i=1

objCommentFile.Write  "���� Windows" & i & "|�������� �������� ��������|���������� �����= " & objItem.MACAddress  & VbCrLf

objCommentFile.Write  "���� Windows" & i & "|�������� �������� ��������|������� �������= " & objItem.Description  & VbCrLf

i=i+1

Next

 

 

 

Next

 

 

 

'#######################################################################################################

 

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[������������ �������]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

 

Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")

 

For Each objOperatingSystem in colOperatingSystems

    objCommentFile.Write "�������� ������������ �������|�������� ��= " & objOperatingSystem.Caption & VbCrLf

    objCommentFile.Write "������������ ����������|���� ��������= " & objOperatingSystem.SerialNumber & VbCrLf

    objCommentFile.Write "�������� ������������ �������|������ ��= " & objOperatingSystem.Version & VbCrLf

Next

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

objCommentFile.Write "[������������� ���������]"

 

objCommentFile.Write VbCrLf

objCommentFile.Write VbCrLf

 

on error resume next   

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colSoftware = objWMIService.ExecQuery("SELECT Name, Vendor FROM Win32_Product")

 

i=1

For Each objSoftware in colSoftware

   objCommentFile.Write "������������� ���������" & i & "= " & objSoftware.Name & VbCrLf

   objCommentFile.Write objSoftware.Name & "|Publisher=" & objSoftware.Vendor & VbCrLf

      i=i+1

Next

 

 

Sub ShowError()

                strMsg = vbCrLf & "Error # " & Err.Number & vbCrLf & _
                         Err.Description & vbCrLf & vbCrLf

                Syntax

End Sub

 

 

objCommentFile.Close