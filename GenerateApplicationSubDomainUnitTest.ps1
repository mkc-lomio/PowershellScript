
function ReadUpdate-FileContent() {

  param (
      [Parameter(Mandatory)] [string]$FilePath,
      [Parameter(Mandatory)] [string]$SubDomain,
      [Parameter(Mandatory)] [string]$naAppName,
      [Parameter(Mandatory)] [string]$Environment
  )

  try
  {
     #Validate folder if exist
   If (Test-Path $FilePath) {
     $SandboxJSON = (Get-Content -path $FilePath -Raw) -replace "{{naAPP_NAME}}",$naAppName -replace "{{SUBDOMAIN}}",$SubDomain -replace "{{ENVIRONMENT}}",$Environment | Out-File $FilePath
       Write-Host -f Green $FilePath "FILE SUCCESSFULLY UPDATED!" 
   }else{
    $WarningMsg = $FilePath + " FILE DOESN'T EXIST!"
    Write-Warning $WarningMsg
   }

  }
  catch
  {
      $ErrorMsg = $_.Exception.Message  
      Write-Host $ErrorMsg -BackgroundColor Red
  }

}

function Get-SubdomainByAppId() {
param (
      [Parameter(Mandatory)] [int]$ApplicationId
  )

$RequestAccessTokenUri = "https://naapp-id.azurewebsites.net/connect/token"

$body = "client_id=ida_script&scope=BlastAsiaCatalyst_api&client_secret=eGFtdW46aWRhX3NjcmlwdA&grant_type=client_credentials"

# Get Access Token
$AccessToken = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'


$APIUri = "https://naapp.azurewebsites.net/service/api/CustomSubDomainsAsync/SubDomainByApplicationId/$ApplicationId"

# Format Header
$Headers = @{}
$Headers.Add("Authorization","$($AccessToken.token_type) "+ " " + "$($AccessToken.access_token)")



   Write-Verbose "Calling $APIUri"
   $Subdomain = Invoke-RestMethod -Method Get -Uri $APIUri -Headers $Headers
   
   if([string]::IsNullOrEmpty($Subdomain.data)){
   
     $ErrorMsg = "SubDomain is null"  
     Write-Host $ErrorMsg -BackgroundColor Red
   }
    
   return $Subdomain
}

$Subdomain = Get-SubdomainByAppId 3

if(![string]::IsNullOrEmpty($Subdomain.data)){
$SubDomainVariables = $Subdomain.data.subDomainName.Split("-")

$naAppName = $SubDomainVariables[0]
$SubdomainName = $SubDomainVariables[1]
$naAppName = $naAppName.ToLower().Replace('.','')
$Environment = $SubDomainVariables[2]

# Two ways to show object properties
# 1
Write-Host ($Subdomain | Format-Table | Out-String)
# 2
# Write-Host ($Subdomain | Format-List | Out-String)


$filePaths = @("C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.api\appsettings.Sandbox.json", 
"C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.SPA\environment.sandbox.ts", 
"C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.Admin\appsettings.Sandbox.json",
"C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.Admin\identityserverdata.Sandbox.json"
"C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.STS.identity\appsettings.Sandbox.json")

$filePaths | ForEach-Object {
 ReadUpdate-FileContent $_ $SubdomainName $naAppName $Environment
}

}