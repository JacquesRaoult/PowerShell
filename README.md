# PowerShell
Custom scripts for PowerShell

1. Open PowerShell profile :
```
notepad $PROFILE
```

2. If not existing create it :
```
New-Item -Path $PROFILE -Type File -Force
notepad $PROFILE
```
3. Tree function for Node.js projects
```
function nodeTree {
    $basePath = (Get-Location).Path
    function Show-TreeRecursive([string]$Path, [string]$Prefix = "") {
        $items = Get-ChildItem -Path $Path -Force -ErrorAction SilentlyContinue |
                 Where-Object {
                     -not ($_.Name -match '^(node_modules|\.git)$') -and
                     -not ($_.Attributes -band [IO.FileAttributes]::Hidden)
                 } |
                 Sort-Object { -not $_.PSIsContainer }, Name  # Dossiers avant fichiers
        $count = $items.Count
        for ($i = 0; $i -lt $count; $i++) {
            $item = $items[$i]
            $isLast = ($i -eq $count - 1)
            $connector = if ($isLast) { "└── " } else { "├── " }
            Write-Host "$Prefix$connector$($item.Name)"
            if ($item.PSIsContainer) {
                $newPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix│   " }
                Show-TreeRecursive $item.FullName $newPrefix
            }
        }
    }
    Write-Host "."
    Show-TreeRecursive $basePath ""
}
```
