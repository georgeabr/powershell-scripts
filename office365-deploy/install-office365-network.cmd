@echo off

@echo Network install - Office 365
@echo =============================
@echo.

@echo Mapping Office 365 network installation folder
net use f: \\10.10.10.11\Office365 /user:CORP\djoin password
rem The djoin account needs read-only perrmissions for the folder above

@echo Copying setup files
mkdir c:\office365-install

copy f:\init\setup.exe c:\office365-install
copy f:\init\Office-network-show-uninstall-2007-1.xml c:\office365-install

@echo.
@echo Running Office 365 setup application, removing Office 2007
rem setup.exe /configure Office-network-show-uninstall-2007-1.xml
c:\office365-install\setup.exe /configure c:\office365-install\Office-network-show-uninstall-2007-1.xml

@echo.
@echo Deleting files, unmapping Office 365 network installation folder
rem dir c:\office365-install
net use f: /delete
del c:\office365-install\*.* /q
rmdir c:\office365-install

@echo.
echo Installation completed. Press any key to exit.
echo ==============================================
pause >nul
