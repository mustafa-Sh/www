$rootPath = Split-Path $MyInvocation.MyCommand.Definition -Parent;
function getUserInput() {
	Write-Output "Do you want to update the WWW module to latest version or a specific version?"
	$UPGRADE_TO = Read-Host -Prompt "(1:Latest Version; 2:Specific Version; 0:Exit)"
	return $UPGRADE_TO
}

function getFileHash($file) {
	$hash = Get-FileHash -Algorithm SHA256 -Path $file
	$hash = $hash.Hash;
	return $hash
}

function postModuleUpdate() {
	xcopy ".\www\upgrade-scripts\config-files\*.*" ".\" /Y /R /q
	$appId = (Get-Content ".\ionic.config.json" | Out-String | ConvertFrom-Json).id
	$appflowConfig = Get-Content ".\appflow.config.json" | Out-String | ConvertFrom-Json
	@($appflowConfig.apps)[0].appId = $appId
	($appflowConfig | ConvertTo-Json -depth 32 ) -replace '\\u0026', '&' | set-content '.\appflow.config.json'
	Write-Output "WWW module is updated successfully to the specified version."
	$hashPs1Updated = getFileHash "./upgrade-www-module.ps1"
	if (($hashPs1Updated -ne $hashPs1Init)) {
		Write-Output "Applying Updated Scripts"
		# powershell -command "$rootPath\upgrade-www-module.ps1 9"
		.".\upgrade-www-module.ps1" $true
		#pause 
		exit
		# cmd.exe /c '.\upgrade-www-module.bat'
	}
	else {
		Write-Output "Please COMMIT the changes to repository before generating the build from Appflow."
		#pause
		EXIT
	}
}

try {
	if ($args.Count -gt 0 -and $args[0]) {
		$hashPs1Init = $hashPs1Updated
		postModuleUpdate
	}
	else {
		$UPGRADE_TO = getUserInput
		$hashPs1Init = getFileHash "./upgrade-www-module.ps1"
		if ($UPGRADE_TO -eq 0) {
			Write-Output "You Chose to Exit!"
			#pause
			EXIT
		}
		else {
			if ($UPGRADE_TO -eq 1) {
				Write-Output "updating WWW module to latest version...."
				git submodule update --remote
				postModuleUpdate
			}
			else {
				if ($UPGRADE_TO -eq 2) {
					Set-Location www
					$sub_ver = git rev-parse --short HEAD
					Write-Output "Current WWW module HASH/TAG is: $sub_ver"
					git submodule update --remote --quiet
	
					Write-Output "List of last 10 versions of WWW:"
					Write-Output  "HASH   		COMMENT"
					Write-Output ------- ----------------------------------------
					git --no-pager log --oneline -n 10 
					Write-Output ------------------------------------------------
					git checkout $sub_ver --quiet
					Write-Output "Please enter HASH code/Version TAG of the commit you want to update to "
					$VERSION_HASH = Read-Host -Prompt "[obtained from the list above][0:Exit]"
					if ($VERSION_HASH -eq 0) {
						Write-Output "You Chose to Exit!"
						Set-Location $rootPath
						#pause
						EXIT
					}
					Write-Output "updating WWW module to version $VERSION_HASH...."
					git checkout $VERSION_HASH
					Set-Location $rootPath
					postModuleUpdate
				}
				else {
					Write-Output Wrong Input entered!
					getUserInput
				}
			}
		}
	}

}
catch {
	Set-Location $rootPath
	Write-Output $_
	Write-Output "Upgrade Failed! Please check the above log."
	#pause
	EXIT
}

