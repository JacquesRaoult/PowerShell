# PowerShell
### Custom scripts for PowerShell

1. Open PowerShell profile
```
notepad $PROFILE
```

2. If not existing create it
```
New-Item -Path $PROFILE -Type File -Force
notepad $PROFILE
```
3. Copy/paste functions from this repository to profile
4. Save and reload profile
```
. $PROFILE
```
