$portNumber = Read-Host 'Give port number'

$processes = (Get-NetTCPConnection | ? {($_.LocalPort -eq $portNumber) -or ($_.RemotePort -eq $portNumber) }).OwningProcess

foreach ($process in $processes) 
{
    $childProcesses = (gwmi win32_process | ? parentprocessid -eq  $process)#.processid# (wmic process where "(ParentProcessId=$process)").ProcessId

    foreach ($childProcess in $childProcesses) 
    {
        $childProcess = $childProcess.processid
        Get-Process -PID $childProcess | Stop-Process -Force
    }
}
