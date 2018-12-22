
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
