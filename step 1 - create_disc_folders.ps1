# Set the path to the directory containing the files (use the current directory if not specified)
$directory = Get-Location

# Get all files in the directory
Get-ChildItem -Path $directory -File | ForEach-Object {
    $file = $_
    $filename = $file.BaseName
    $extension = $file.Extension

    # Check if the filename contains parentheses with the word "Disc"
    if ($filename -match '\(.*Disc.*\)') {
        # Initialize the folder name by removing parentheses and their contents
        $folderName = $filename -replace '\(.*?Disc.*?\)', ''
        
        # Remove any extra spaces if they exist
        $folderName = $folderName.Trim()
        
        # Create the target directory if it doesn't exist
        $targetDir = Join-Path -Path $directory -ChildPath $folderName
        if (-not (Test-Path -Path $targetDir)) {
            New-Item -Path $targetDir -ItemType Directory | Out-Null
        }
        
        # Move the file to the target directory
        $destinationPath = Join-Path -Path $targetDir -ChildPath ($filename + $extension)
        Move-Item -Path $file.FullName -Destination $destinationPath
    }
}
