@echo off
rem https://blogs.msdn.microsoft.com/astebner/2006/09/04/solving-setup-errors-by-using-the-subinacl-tool-to-repair-file-and-registry-permissions/
title Resetting ACLs...

setlocal

goto filesExist


:filesExist

echo.
echo Resetting ACLs...
echo (this may take several minutes to complete)
echo.
echo IMPORTANT NOTE: For this script to run correctly, you must change
echo the values named %USERNAME% to be the Windows user account that
echo you are logged in with.
echo.
echo ==========================================================================
echo.
echo.
subinacl.exe /subkeyreg HKEY_CURRENT_USER /grant=administrators=f /grant=system=f /grant=restricted=r /grant=%USERNAME%=f /setowner=administrators > subinacl_HKCU1.txt
echo.
echo.
subinacl.exe /keyreg HKEY_CURRENT_USER /grant=administrators=f /grant=system=f /grant=restricted=r /grant=%USERNAME%=f /setowner=administrators > subinacl_HKCU2.txt
echo.
echo.
subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE /grant=administrators=f /grant=system=f /grant=users=r /grant=everyone=r /grant=restricted=r /setowner=administrators > subinacl_HKLM1.txt
echo.
echo.
subinacl.exe /keyreg HKEY_LOCAL_MACHINE /grant=administrators=f /grant=system=f /grant=users=r /grant=everyone=r /grant=restricted=r /setowner=administrators > subinacl_HKLM2.txt
echo.
echo.
subinacl.exe /subkeyreg HKEY_CLASSES_ROOT /grant=administrators=f /grant=system=f /grant=users=r /setowner=administrators > subinacl_HKR1.txt
echo.
echo.
subinacl.exe /keyreg HKEY_CLASSES_ROOT /grant=administrators=f /grant=system=f /grant=users=r /setowner=administrators > subinacl_HKR2.txt
echo.
echo.
echo ==========================================================================
echo.
echo FINISHED.
echo.
echo Press any key to exit . . .
pause >NUL


:END

endlocal

