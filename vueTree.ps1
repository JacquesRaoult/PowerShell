function vueTree {
    $basePath = (Get-Location).Path
    $excludedFiles = @('eslint.config.js', 'jsconfig.json', 'README.md', 'vite.config.js')
    
    function Show-TreeRecursive([string]$Path, [string]$Prefix = "") {
        $items = Get-ChildItem -Path $Path -Force -ErrorAction SilentlyContinue |
                 Where-Object {
                     -not ($_.Name -match '^(node_modules)$') -and
                     -not ($_.Name -match '^\.')  -and
                     -not ($excludedFiles -contains $_.Name)
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
