$env:PROJECTNAME = "CustomCountries"
$env:BUILDCONFIGURATION = "Debug"
$env:APIDIR = "/src/api/custom-countries"
$env:WEBAPPDIR = "/src/webapp/countries-webapp"
$env:VERSION = "1.0"

. .\BuildNetApi.ps1
. .\BuildReactApp.ps1

$sw = [Diagnostics.Stopwatch]::StartNew()
CIBuildNetApi
CIBuildReact
# Docker compose applications
exec {
	& docker-compose up -d --build
}
$sw.Stop()
write-host "Build time: " $sw.Elapsed.ToString()