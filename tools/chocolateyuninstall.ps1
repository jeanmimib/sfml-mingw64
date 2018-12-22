
#ensure we have admin privileged
if (!(Test-ProcessAdminRights)) {
  Start-ChocolateyProcessAsAdmin "chocolateyuninstall"
}

#delete contents of zip
$zipFileName = 'SFML-2.5.1-windows-gcc-7.3.0-mingw-64-bit.zip'

$packagelibPath=$env:chocolateyPackageFolder
$zipContentFile=(join-path $packagelibPath $zipFileName) + ".txt"

if ((Test-Path -path $zipContentFile)) {
  $zipContents=get-content $zipContentFile
  foreach ($fileInZip in $zipContents) {
    if ($fileInZip -ne $null -and $fileInZip.Trim() -ne '') {
      Remove-Item -Path "$fileInZip" -ErrorAction SilentlyContinue -Recurse -Force
    }
  }
}

# remove sfml from path
$pathToRemove = $env:SFML_INSTALL +'\bin'
$actualPath = Get-EnvironmentVariable -Name 'Path' -Scope 'Machine' -PreserveVariables
foreach ($path in $actualPath.split(';'))
{
  If ($path)
  {
    If (($path -ine "$pathToRemove") -AND ($path -ine "$pathToRemove\"))
    {
    
      [string[]]$newPath += "$path"
    }
  }
}
$assembledNewPath = ($newPath -join(';')).trimend(';')
Set-EnvironmentVariable -Name 'Path' -Value $assembledNewPath -Scope 'Machine'

#delete variable SFML_INSTALL
Uninstall-ChocolateyEnvironmentVariable -VariableName 'SFML_INSTALL' -VariableType 'Machine'


