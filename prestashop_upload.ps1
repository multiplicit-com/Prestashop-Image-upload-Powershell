# ==== CONFIG ====
$BaseUrl  = "http://3.9.146.195"                         # Webservice base URL
$ApiKey   = "YOUR_REAL_API_KEY"                          # Webservice key
$ImageDir = "C:\Users\lownd\DOWNLOADED\RESIZED"          # Folder with images named by product ID
# ================

if (!(Test-Path $ImageDir)) {
    Write-Error "Image directory does not exist: $ImageDir"
    exit
}

# Build Basic Auth header: key as username, empty password
$pair       = "$ApiKey:"
$authHeader = "Basic " + [Convert]::ToBase64String(
    [Text.Encoding]::ASCII.GetBytes($pair)
)
$Headers = @{ Authorization = $authHeader }

Get-ChildItem -Path $ImageDir -File | ForEach-Object {

    $file = $_.FullName
    $base = $_.BaseName
    $ext  = $_.Extension.ToLower()

    # Only handle image files
    if ($ext -notin @(".png", ".jpg", ".jpeg", ".webp")) {
        Write-Host "Skipping non-image file: $file"
        return
    }

    # Extract numeric product ID from filename
    if ($base -match "(\d+)") {
        $ProductId = [int]$Matches[1]
    } else {
        Write-Warning "Skipping: cannot extract product ID from filename '$base'"
        return
    }

    $uploadUrl = "$BaseUrl/api/images/products/$ProductId/"

    Write-Host "Uploading $file to product $ProductId ..."

    try {
        $response = Invoke-WebRequest `
            -Uri $uploadUrl `
            -Method Post `
            -Headers $Headers `
            -Form @{ image = Get-Item $file } `
            -ErrorAction Stop

        Write-Host "  Upload successful (HTTP $($response.StatusCode))." -ForegroundColor Green
    }
    catch {
        Write-Warning "  Upload failed for product $ProductId : $($_.Exception.Message)"
    }
}
