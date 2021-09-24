Clear-Host
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$ArtifactStorageLocation="C:\artifacts\artifacts-storage\"
$TomcatDestination="C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\"
cd "C:\artifacts\artifacts-storage"
$Foldername= $(get-date -f MM-dd-yyyy_HH_mm_ss)
$ArtifactDestination=$ArtifactStorageLocation+$Foldername
mkdir $Foldername
Write-Host "********Copying the WAR file to Artifactory location*************"
Copy-Item "C:\Program Files (x86)\Jenkins\workspace\CI-CD-Pipeline-Tomcat\target\java-tomcat-maven-example.war" -Destination $ArtifactDestination
Write-Host "********WAR Copied to Artifactory location**********"
Write-Host "Stopping the Web server"
Stop-Service -Name "Tomcat9"
Write-Host "******Deploying the WAR to Web server***********"
Copy-Item $ArtifactDestination\java-tomcat-maven-example.war -Destination $TomcatDestination
write Start-Sleep 5
Start-Service -Name "Tomcat9"
Write-Host "*****Deployment completed and services started******"


