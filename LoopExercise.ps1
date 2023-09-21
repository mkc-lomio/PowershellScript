$array = @("item1", "item2", "item3")
 
for($i = 0; $i -lt $array.length; $i++){ $array[$i] }

$arrayObject  = @([pscustomobject]@{firstname = "Marc"; lastname = "Test"}, [pscustomobject]@{firstname = "World"; lastname = "Peace"})
$arrayObject | ForEach-Object {
    Write-Host $_.firstname $_.lastname
}