-----------------------------------------
-- Show and Hide <application>
-----------------------------------------
--
-- This script allows you to easily
-- toggle the visibility of a specific
-- app, similar to how Twitter and
-- Sparrow toggle with their global
-- hotkey option.
-- 
-- 1. Set app name below.
-- 2. If you use Spaces, make the
-- app visible on all Spaces.
-- 3. Run this script through a
-- global hotkey in QuickSilver
-- or something similar.
--
-----------------------------------------

set theApp to "Alacritty"

if isAppActive(theApp) then
	hideApp(theApp)
else
	activateApp(theApp)
end if


-- helper methods

on isAppActive(appName)
	tell application "System Events" to set activeApps to (get name of processes whose frontmost is true)
	appName is equal to item 1 of activeApps
end isAppActive

on activateApp(appName)
	tell application appName to activate
end activateApp

on hideApp(appName)
	tell application "Finder" to set visible of process appName to false
end hideApp
