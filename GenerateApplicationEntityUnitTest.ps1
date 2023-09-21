$RequestAccessTokenUri = "https://na-id.azurewebsites.net/connect/token"
 
$body = "client_id=NA&scope=NA&client_secret=NA&grant_type=NA"
 
# Get Access Token
$AccessToken = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'


#Get EntityXml

$GetEntityXmlUri = "https://na.azurewebsites.net/service/api/DataModelAsync/GetEntityXml/3"

# Format Header
$Headers = @{}
$Headers.Add("Authorization","$($AccessToken.token_type) "+ " " + "$($AccessToken.access_token)")
 

$EntityXml = Invoke-RestMethod -Method Get -Uri $GetEntityXmlUri -Headers $Headers

$EntityXmlPath = "C:\Users\MarcKennethLomio\Test.xml"

$EntityXml.Save($EntityXmlPath)