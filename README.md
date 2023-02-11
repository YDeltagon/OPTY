## ABOUT <!-- omit in toc -->

This is a simple menu for use commands to fix some bugs and optimize your computer

**Based on 3 year of experience in IT, and 2 years of laziness typing the same commands**

This is a script for optimize your computer
With a lot of options :

- cleaning,
- defragmenting,
- optimizing,
- fix,
- and more...

This script is made for **Windows 10/11**

ONLY work WITH a **valid** internet connection

---

**RESTART THE COMPUTER BEFORE RUNNING THE SCRIPT** - This allows any pending updates to complete.

- Download `OPTY.bat` (no need to download the other files)
- Right click on and select "**Run as administrator**"
  - If you need to execute FixUserShellFolderPermissions in a entreprise environnement
    - Execute with the user account
- Use the menu to run the desired script
- **Reboot** the system before doing *anything else*.

## CHANGE-LOGS<!-- omit in toc -->

- [REPOSITORY](#repository)
  - [**TO-DO**](#to-do)
  - [**Autoopti + shutdown - 2023-02-11**](#autoopti--shutdown---2023-02-11)
- [OPTY](#opty)
  - [**TO-DO**](#to-do-1)
  - [**v01.0.5 - Fix - 2023-02-07**](#v0105---fix---2023-02-07)
  - [**v01.0.4 - Link - 2023-01-29**](#v0104---link---2023-01-29)
  - [**v01.0.3 - Shortcut - 2023-01-28**](#v0103---shortcut---2023-01-28)

### REPOSITORY

#### **TO-DO**

    - 

#### **AutoOpti + shutdown - 2023-02-11**

    - Add the ability to create a shortcut on the desktop to execute autoopti + shutdown

#### **Update script - 2023-01-28**<!-- omit in toc -->

    - Now, OPTY check on GitHub for update
    - All script (opti/enable/reg...) need to be downloaded from GitHub
      - ReEnable.bat is now standalone
      - RegProfil.bat is now standalone
      - Opti.bat is now standalone
        - This is more easy to update
    - OPTY now pass in a new version
    - Add all files Standalone in the repo

#### **Release - 2023-01-27**<!-- omit in toc -->

    - First Release
    - Update some bug
    - Update fixusershellfolderpermissions.ps1

#### **No fork - 2023-01-16**<!-- omit in toc -->

    - Unfork my project
    - TRON is now just a note for me
    - TRON is not used anymore
    - All opty just in one .bat

#### **Clean and Opti - 2023-01-12**<!-- omit in toc -->

    - Delete all unused files from TRON
    - Big update on OPTY.bat

#### **Office Elec - 2023-01-11**<!-- omit in toc -->

    - Add a script to fix a bug in Office Elec by ALPI (not working for now)
        *Script made by ChatGPT

#### **ReadMe v2 - 2023-01-11**<!-- omit in toc -->

    - Reformate Readme
    - Delete changelog.txt for all modules

#### **ChangeLog and Reorganization - 2023-01-11**<!-- omit in toc -->

    - Create a OPTY Changelog
    - Create a REPO Changelog
    - Create a TRON REWORK Changelog
    - Rename the TRON Changelog
    - Reorganization

#### **ReadMe - 2023-01-10**<!-- omit in toc -->

    - Fork of TRON
    - Add my custom OPTY.bat

### OPTY

#### **TO-DO**

    - Add logs for all steps

#### **v01.0.5 - Fix - 2023-02-07**

    - Little fix things
      - mdisenable do not loop anymore
      - Reorganize auto-opti order
    - Add Shutdown or Reboot option after the auto-opti

#### **v01.0.4 - Link - 2023-01-29**

    - Update Link
      - Donwload files directly on Github repo, and not from latest
    - Update ping check and update if no-admin
    - Fix some bug
      - Auto-Defrag
      - No Shutdown confirmation

#### **v01.0.3 - Shortcut - 2023-01-28**

    - Add a fonction to create a shortcut on public desktop
    - Add REM to all steps
    - Update FixUserShellFolderPermissions.ps1 menu for user
    - Changelog of all standalone files is now in the files

#### **v01.0.2 - Auto Update +++ - 2023-01-28**<!-- omit in toc -->

    - Get out some old menu
      - ReEnable.bat is now standalone
      - RegProfil.bat is now standalone
      - Opti.bat is now standalone
        - This is more easy to update
    - Add a check for admin right or not
      - if admin : menu is full
      - if user : menu is lite with only user-side options
    - Update some bug
    - Add color for menu and bug
    - Add ping test to GitHub for update

#### **v01.0.1 - Auto Update - 2023-01-27**<!-- omit in toc -->

    - Add auto update Opty.bat
    - Add auto download fixusershellfolderpermissions.ps1 from GitHub if need
    - Update some bug

#### **v01.0.0 - Release - 2023-01-27**<!-- omit in toc -->

    - First Release
    - Update some bug

#### **v00.1.2 - Big update - 2023-01-12**<!-- omit in toc -->

    - Add powercfg.exe /hibernate options on the disenable menu
    - Add a option to NOT reboot after the autoopti
    - Update menu
    - Update english translation
    - Update google chrome step for kill chrome process before update
    - Rename all steps and menu
    - Rework the clean and delete step
    - Fix FixUserShellFolderPermissions.ps1 to execute manualy
    - Make Auto opti lite and full with a variable based on the manual opti, write more clean and fast

#### **v00.1.1 - English update - 2023-01-12**<!-- omit in toc -->

    - Update menu
    - Update english translation
    - Update AutoOpti
    - Update ManualOpti

#### **v00.1.0 - First usable version (no TRON) - 2023-01-11**<!-- omit in toc -->

    - Update menu
    - Update english translation
    - Update FixUserShellFolderPermissions.ps1

    - Create manualopti
    - Create autoopti_lite
    - Create autoopti_full
    - Create menu_reenable
    - Create menu_regprofil

#### **v00.0.2 - English update (not work) - 2023-01-11**<!-- omit in toc -->

    - Update English translation
    - Update menu

#### **v00.0.1 - First push (not work) - 2023-01-11**<!-- omit in toc -->

    - Not executables for the times

---

| AUTHOR | YDeltagon : [Twitch](https://twitch.tv/YDeltagon) - [Twitter](https://twitter.com/YDeltagon)
| - | - |