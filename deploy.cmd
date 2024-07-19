:: 1. Script to run Kudu Sync
echo "Running Kudu Sync"
call :ExecuteCmd "%DEPLOYMENT_SOURCE%\KuduSync\KuduSync.cmd" -v 50 -f "%DEPLOYMENT_SOURCE%" -t "%DEPLOYMENT_TARGET%" -n "%NEXT_MANIFEST_PATH%" -p "%PREVIOUS_MANIFEST_PATH%" -i ".git;.hg;.deployment;deploy.cmd"
IF !ERRORLEVEL! NEQ 0 goto error

:: 2. Clear the temp space
echo "Listing temp space in %DEPLOYMENT_TEMP%"
for /d %%X in ("%DEPLOYMENT_TEMP%/*") do dir /a-d /b "%%X"
for %%X in ("%DEPLOYMENT_TEMP%/*.*") do dir /a-d /b "%%X"
:: for /d %%X in ("%DEPLOYMENT_TEMP%/*") do rmdir /s /q "%%X"
:: for %%X in ("%DEPLOYMENT_TEMP%/*.*") do del /q "%%X"

:: 3. If there's an error, stop the deployment
:error
exit /b %errorlevel%