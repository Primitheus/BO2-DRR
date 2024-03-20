echo off
set GAME_FOLDER=E:\Games\Call of Duty\Call of Duty Black Ops 2
set OAT_BASE=C:\OATBuild
set MOD_BASE=%cd%
set MOD_NAME=dierise_rebirth

"%OAT_BASE%\Linker.exe" ^
-v ^
--load "%GAME_FOLDER%\zone\all\zm_prison.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_prison_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_highrise_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_transit_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_buried.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_buried_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_nuked_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_nuked.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_tomb.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_tomb_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\so_zencounter_zm_prison.ff" ^
--load "%GAME_FOLDER%\zone\all\so_zclassic_zm_prison.ff" ^
--load "%GAME_FOLDER%\zone\all\so_zsurvival_zm_transit.ff" ^
--base-folder "%OAT_BASE%" ^
--asset-search-path "%MOD_BASE%" ^
--source-search-path "%MOD_BASE%\zone_source" ^
--output-folder "%MOD_BASE%\zone" mod

set err=%ERRORLEVEL%

if %err% EQU 0 (
XCOPY "%MOD_BASE%\zone\mod.ff" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.ff" /Y
XCOPY "%MOD_BASE%\zone\mod.all.sabl" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.all.sabl" /Y
XCOPY "%MOD_BASE%\zone\mod.all.sabs" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.all.sabs" /Y
XCOPY "%MOD_BASE%\zone\mod.json" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.json" /Y

) ELSE (
COLOR C
echo FAIL!
)
pause