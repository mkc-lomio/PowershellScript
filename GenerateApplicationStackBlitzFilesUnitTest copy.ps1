function Create-StackblitzFiles() {

    param (
        [Parameter(Mandatory)] [pscustomobject]$StackblitzFiles,
        [Parameter(Mandatory)] [string]$Location
    )

   $StackblitzFiles | ForEach-Object {

   Write-Host -f Green "APPLICATION ID:" $_.applicationId

    try
    {
     for($i = 0; $i -lt $_.modules.length; $i++){ 
   
     $FolderPath = $Location + $_.modules[$i].moduleName;
  
     #Validate folder if exist
     If (Test-Path $FolderPath) {
      $WarningMsg = $_.modules[$i].moduleName + " FOLDER ALREADY EXIST!"
      Write-Warning $WarningMsg
     }else{
      # Create a folder
      New-Item -Path  $FolderPath -ItemType Directory
       Write-Host -f Green $_.modules[$i].moduleName "FOLDER SUCCESSFULLY CREATED!"

     for($x = 0; $x -lt $_.modules[$i].files.length; $x++){ 
      
     $FilePath = $FolderPath + '\' + $_.modules[$i].files[$x].fileName

     #Validate file if exist
     If (Test-Path $FilePath ) {

      $WarningMsg = $_.modules[$i].files[$x].fileName + " FILE ALREADY EXIST!"
      Write-Warning $WarningMsg

      }
      else{ 
  
       # File creation
       New-Item -Path $FilePath -ItemType File -Value $_.modules[$i].files[$x].fileContent
    
       Write-Host -f Green $_.modules[$i].files[$x].fileName "SUCCESSFULLY CREATED!"
      }
    
      }
     }

    }

    }catch
    {
     $ErrorMsg = $_.Exception.Message  
     Write-Host "Application Id:" $_.applicationId $ErrorMsg -BackgroundColor Red 
    }
     
 }
}

function Get-StackblitzFilesByAppId() {
  param (
        [Parameter(Mandatory)] [int]$ApplicationId
    )

$RequestAccessTokenUri = "https://na-id.azurewebsites.net/connect/token"
 
$body = "client_id=ida_script&scope=BlastAsiaCatalyst_api&client_secret=eGFtdW46aWRhX3NjcmlwdA&grant_type=client_credentials"
 
# Get Access Token
$AccessToken = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'


$APIUri = "https://na.azurewebsites.net/service/api/ApplicationStackblitzFileAsync/GetStackblitzFilesByAppId/$ApplicationId"

# Format Header
$Headers = @{}
$Headers.Add("Authorization","$($AccessToken.token_type) "+ " " + "$($AccessToken.access_token)")
 
try
{
   Write-Verbose "Calling $APIUri"
   $StackBlitzFiles = Invoke-RestMethod -Method Get -Uri $APIUri -Headers $Headers
    
   $StackBlitzFiles
}catch
{
     $ErrorMsg = $_.Exception.Message  
     Write-Host $ErrorMsg -BackgroundColor Red
     return $null
} 
 
}


$StackBlitzFiles = Get-StackblitzFilesByAppId 3


$Location = "C:\Users\MarcKennethLomio\source\repos\na\na.app\src\api\na.app.Test\Powershellscripts\na.app.SPA\ClientApp\src\app\pages\"

if(![string]::IsNullOrEmpty($StackBlitzFiles)){
Create-StackblitzFiles $StackBlitzFiles $Location
}