
$version = [Environment]::OSVersion.Version

if (-not [Environment]::Is64BitOperatingSystem) {
	throw "This package requires a 64-bit Windows."
}

$arguments = @{}
$packageParameters = $env:chocolateyPackageParameters
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64        = 'https://www.sfml-dev.org/files/SFML-2.5.1-windows-gcc-7.3.0-mingw-64-bit.zip'
$installationPath = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installationPath
  url64bit      = $url64

  softwareName  = 'sfml*'

  checksum64    = '671E786F1AF934C488CB22C634251C8C8BD441C709B4EF7BC6BBE227B2A28560'
  checksumType64= 'sha256'

  validExitCodes= @(0, 3010, 1641)
}

if (Test-Path $installationPath) {
	rm -Recurse $installationPath
}
Write-Host "Installing to" $installationPath"."
Install-ChocolateyZipPackage  @packageArgs










    








