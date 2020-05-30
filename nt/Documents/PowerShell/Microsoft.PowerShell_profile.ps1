<# The basics so I won't go insane: {{{
}}} #>

# `using`: {{{
using namespace Console
using namespace Microsoft.PowerShell.PSConsoleReadline
using namespace System.Windows.Clipboard
using namespace System.Windows.Forms
using namespace System.Management.Automation
using namespace System.Management.Automation.Language
using namespace System.ConsoleKey
using namespace Microsoft.PowerShell.Utility
using module posh-git
Import-Module posh-sshell

# Import-Module pscx

If (Test-Path "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1") {
    & "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1"  #  [PARAMETERS]
}
# Learn more with this:
# Get-Help "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1"               *


<############### Start of PowerTab Initialization Code ########################
    Added to profile by PowerTab setup for loading of custom tab expansion.
    Import other modules after this, they may contain PowerTab integration.
#>

Import-Module "PowerTab" -ArgumentList "C:\Users\fac\Documents\PowerShell\PowerTabConfig.xml"
################ End of PowerTab Initialization Code ##########################

# }}}

# PSModulePATH: {{{
# Here's a useful function that works on all pwsh versions
function Get-PSVersion {
        if (test-path variable:psversiontable) {
            $psversiontable.psversion
        } else {
            [version]"1.0.0.0"
        }
    }

function Set-PSModulePathCorrectly {
# Note the ternary operator was only introduced in version 7 and == isn't valid
# as a comparison operator. Compare ints with -eq
    if ($PSVersionTable.PSVersion.Major -eq 7) {
        $env:PSModulePATH='C:\Users\fac\scoop\apps\pwsh\current\Modules'
    }
    else {
        $env:PSModulePATH=''
    }

    $env:PSModulePATH+=';C:\Users\fac\Documents\PowerShell\Modules'
    $env:PSModulePATH+=';C:\Users\fac\Documents\WindowsPowerShell\Modules'
    $env:PSModulePATH+=';C:\Users\fac\scoop\shims'
    $env:PSModulePATH+=';C:\Program Files\WindowsPowerShell\Modules'
    $env:PSModulePATH+=';C:\Program Files (x86)\WindowsPowerShell\Modules'
    $env:PSModulePATH+=';C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules'
    $env:PSModulePATH+=';C:\Windows\Syswow64\WindowsPowerShell\v1.0\Modules'
    $env:PSModulePATH+=';C:\Windows\Microsoft.NET\Framework64\v4.0.30319'
    $env:PSModulePATH+=';C:\Windows\Microsoft.NET\Framework\v4.0.30319'
    $env:PSModulePATH+=';C:\Windows\Microsoft.NET\Framework\v3.5'
    $env:PSModulePATH+=';C:\Windows\Microsoft.NET\Framework64\v3.5'
    $env:PSModulePATH+=';C:\ProgramData\chocolatey\lib\chocolatey-core.extension\extensions'
    $env:PSModulePATH+=';C:\ProgramData\chocolatey\lib\chocolatey-dotnetfx.extension\extensions'
    $env:PSModulePATH+=';C:\ProgramData\chocolatey\lib\chocolatey-fastanswers.extension\extensions'
    $env:PSModulePATH+=';C:\ProgramData\chocolatey\lib\chocolatey-visualstudio.extension\extensions'
}

Set-PSModulePathCorrectly
# }}}

# PATH: {{{
# Start with C:\Windows
$env:PATH = 'C:\Windows;C:\Windows\System32;C:\Windows\Syswow64;C:\Windows\System32\OpenSSH;C:\Windows\System32\wbem'
# $env:PATH += ';C:\Windows\Microsoft.NET\Framework64\v4.0.30319'
# $env:PATH += ';C:\Windows\Microsoft.NET\Framework\v4.0.30319'
$env:PATH += ';C:\Windows\System32\WindowsPowerShell\v1.0'
$env:PATH += ';C:\Windows\WinSxS'
$env:PATH += ';C:\Windows\ImmersiveControlPanel'

# .NET
# $env:PATH += ';C:\Windows\Microsoft.NET\Framework64\v3.5;C:\Windows\Microsoft.NET\Framework64\v3.0'
# $env:PATH += ';C:\Windows\Microsoft.NET\Framework\v3.5;C:\Windows\Microsoft.NET\Framework\v3.0'
# Choco pwsh firefox and other app folders
$env:PATH += ';C:\ProgramData\chocolatey\bin'
# Get the visual studio stuff
# $env:PATH += ';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\IDE'
# $env:PATH += ';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools'
# $env:PATH += ';C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE'
# $env:PATH += ';C:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x64'
# $env:PATH += ';C:\Program Files (x86)\Windows Kits\10\bin\x64'
# $env:PATH += ';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin'
# $env:PATH += ';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin'
$env:PATH += ';C:\Program Files (x86)\XML Notepad 2007'
$env:PATH += ';C:\Program Files (x86)\Windows Kits\10\bin\x64'
$env:PATH += ';C:\Program Files (x86)\WindowsPowerShell'
$env:PATH += ';C:\Program Files\WindowsPowerShell'
$env:PATH += ';C:\Program Files (x86)\dotnet'
$env:PATH += ';C:\Program Files\dotnet'
# $env:PATH += ';C:\Program Files\Racket'
$env:PATH += ';C:\Program Files\KeePassXC'
$env:PATH += ';C:\Program Files\Firefox Nightly'
$env:PATH += ';C:\Program Files\Microsoft VS Code Insiders\bin'
$env:PATH += ';C:\Program Files\Oracle\VirtualBox'
$env:PATH += ';C:\Program Files\PowerToys'

$env:PATH += ';C:\totalcmd'
$env:PATH += ';C:\msys64'

# Scoop Dirs:
# Winpython
$env:PATH += ';C:\Users\fac\scoop\apps\winpython\current\\n'
$env:PATH += ';C:\Users\fac\scoop\apps\winpython\current\python-3.8.1.amd64\Scripts'
$env:PATH += ';C:\Users\fac\scoop\apps\winpython\current'
$env:PATH += ';C:\Users\fac\scoop\apps\python-alpha\current\Scripts'
$env:PATH += ';C:\Users\fac\scoop\apps\python-alpha\current'
$env:PATH += ';C:\Users\fac\scoop\shims'
$env:PATH += ';C:\Users\fac\scoop\apps\ruby\current\bin'
# $env:PATH += ';C:\Users\fac\scoop\apps\ruby\current\gems'

# Git. 03/23/2020. Moved to a new dir. Also btw there's an installation of it in VS
# $env:GITDIR =  'C:\\Users\\fac\\scoop\\apps\\git-with-openssh\\current'
# $env:PATH += ";$env:GITDIR\\mingw64\\libexec\\git-core;$env:GITDIR\\mingw64\\bin;$env:GITDIR\\cmd"
# $env:PATH += ';C:\msys64\mingw64\bin'
# $env:PATH += ';C:\msys64\usr\bin'

# Your personal folders
$env:PATH += ';C:\Users\fac\AppData\Roaming\Python\Python38\Scripts'
$env:PATH += ';C:\Users\fac\AppData\Roaming\Python\Python37\Scripts'
$env:PATH += ';C:\Users\fac\AppData\Roaming\Python\Python39\Scripts'
$env:PATH += ';C:\Users\fac\AppData\Local\Programs\Microsoft VS Code'
$env:PATH += ';C:\Users\fac\AppData\Local\Yarn\bin'
$env:PATH += ';C:\Users\fac\openjdk'
$env:PATH += ';C:\Users\fac\bin'

# Holy bajeezuz is this important!
if ($env:VIRTUAL_ENV) { $env:PATH = $env:VIRTUAL_ENV + '\Scripts;' + $env:PATH}


# }}}

# Beginning of me reworking this: {{{
$env:HOME = 'C:\Users\fac'

(Get-PSProvider 'function').home = 'C:\Users\fac'

# The profiles root directory.
Set-Item -force -path "env:ProfileRoot" -value "$PSScriptRoot\.."

# C:\Windows\System32\chcp.com 65001
# Not supposed to actually do it that way
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Unix Utilities: {{{

if (Test-Path Alias:head) { Remove-Item Alias:head }
function head() { Get-Content -TotalCount 30 $args }

if (Test-Path Alias:tail) { Remove-Item Alias:tail }
function tail() { Get-Content -Tail 30 $args }

# Between you and I, i have no idea if thi is doing anything. oh well.
# Here's an example of how to pipe to /dev/null if nothing else
Out-Null -InputObject 'dircolors -c ~/.dircolors'
# }}}

# ------------------
# functions - start
# ------------------

# Path: {{{
# function description:
#    Allows an actual fucking human to parse the `$PATH`.
#
# Parameters:
#  none
#
# Return Value:
#  returns path split on the ;
#
function path() { Write-Output "($env:PATH)".Split(';') }

function psmodulepath() { Write-Output "($env:PSModulePATH)".Split(';') }
# }}}

###############################
### Set-WindowSize
###############################
Function Set-WindowSize {
Param([int]$x=$host.ui.rawui.windowsize.width,
      [int]$y=$host.ui.rawui.windowsize.heigth,
      [int]$buffer=$host.UI.RawUI.BufferSize.heigth)

    $buffersize = new-object System.Management.Automation.Host.Size($x,$buffer)
    $host.UI.RawUI.BufferSize = $buffersize
    $size = New-Object System.Management.Automation.Host.Size($x,$y)
    $host.ui.rawui.WindowSize = $size
}

$host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf

# Windows10 yelling at us with 150 40 6000
# no more needed ?
# Set-WindowSize 195 40 6000

### Colorize to distinguish
#$host.ui.RawUI.BackgroundColor = "DarkBlue"
$host.ui.RawUI.BackgroundColor = "Black"
$host.ui.RawUI.ForegroundColor = "White"

# Make: {{{
# So i accidentally backgrounded a command and then was trying to figure out how to `fg` it.
# wa reading output from (Get-Job).* and (Get-Job).Command outputs this
# which is crazy to me but also if we make it a function then we don't need the
# .\ prefix anymore i think

# Note: I think the right way to capture the jobs output would be somethin like
# $j = Get-Job
# $received = $j | Receive-Job
# function make() { Microsoft.PowerShell.Management\Set-Location -LiteralPath $using:pwd ; .\make $args }
# }}}

if ( Test-Path alias:sl ) { Remove-Item alias:sl -Force }
# FFS!
if ( Test-Path alias:echo ) { Remove-Item alias:echo -Force }

function Pro { C:\Neovim\bin\nvim.exe $Profile.CurrentUserCurrentHost }
function Reload { Import-Module $Profile.CurrentUserCurrentHost }

function nvim_init () { C:\Neovim\bin\nvim.exe C:\Users\faris\AppData\Local\nvim\init.vim }

# fuck this naming convention
function Get-Local-ChocoPackages() { choco list --local --pre $args }

if ( ! ( Test-Path alias:clist) ) { New-Alias clist Get-Local-ChocoPackages }

function Invoke-JQ() { jq -SMRr . $args }

# }}}

# Prompt: {{{
# This scriptblock runs every time the prompt is returned.

# Cmder PowerShell Prompt: {{{
$moduleInstallerAvailable = [bool](Get-Command -Name 'Install-Module' -ErrorAction SilentlyContinue | Out-Null)

# Compatibility with PS major versions <= 2
if(!$PSScriptRoot) {
    $PSScriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path
}

$Global:GitPromptSettings:EnableStashStatus = $True
$Global:GitPromptSettings:DefaultPromptWriteStatusFirst = $True
$Global:GitPromptSettings:DefaultPromptEnableTiming = $True

# Users should modify their user_profile.ps1 as it will be safe from updates.
$isGitLoaded = $false

#Anonymice Powerline
$arrowSymbol = [char]0xE0B0;
$branchSymbol = [char]0xE0A0;

# $defaultForeColor = "White"
# $defaultBackColor = "Black"
# $pathForeColor = "White"
# $pathBackColor = "DarkBlue"
# $gitCleanForeColor = "black"
# $gitCleanBackColor = "white"
# $gitDirtyForeColor = "black"
# $gitDirtyBackColor = "white"

function Write-GitPrompt() {
    $status = Get-GitStatus

    if ($status) {
        # assume git folder is clean
        $gitBackColor = $gitCleanBackColor
        $gitForeColor = $gitCleanForeColor
        if ($status.HasWorking -Or $status.HasIndex) {
        # but if it's dirty, change the back color
        $gitBackColor = $gitDirtyBackColor
        $gitForeColor = $gitDirtyForeColor
        }

        # Close path prompt
        Write-Host $arrowSymbol -NoNewLine -BackgroundColor $gitBackColor -ForegroundColor $pathBackColor
#
        # Write branch symbol and name
        Write-Host " " $branchSymbol " " $status.Branch " " -NoNewLine -BackgroundColor $gitBackColor -ForegroundColor $gitForeColor
        # close git prompt
        Write-Host $arrowSymbol -NoNewLine -BackgroundColor $defaultBackColor -ForegroundColor $gitBackColor
    }
}  # }}}

function getGitStatus($Path) {   # {{{

    if (!$Path) { return }
    if (Test-Path -Path (Join-Path $Path '.git') ) {
        Write-GitPrompt
        return
    }
    $SplitPath = split-path $path
    if ($SplitPath) {
        getGitStatus($SplitPath)
    }
    else{
        Write-Host $arrowSymbol -NoNewLine -ForegroundColor $pathBackColor
    }
}

function tildaPath($Path) {
    return $Path.replace($env:USERPROFILE, "~")
}

# Replace the cmder prompt entirely with this.
[ScriptBlock]$CmderPrompt = {
    $tp = tildaPath($pwd.ProviderPath)
    Microsoft.PowerShell.Utility\Write-Host "`n" $tp " " -NoNewLine -BackgroundColor $pathBackColor -ForegroundColor $pathForeColor

    getGitStatus($pwd.ProviderPath)
}

[ScriptBlock]$PostPrompt = {}
## <Continue to add your own>
# }}}

<# PoshGit Holy Hell: {{{
They fucking killed it dude. #>
function PrePrompt() {
$settings = $global:GitPromptSettings

if (!$settings) {
    return "<`$GitPromptSettings not found> "

# Most of this is raising an error so let's shuttle it inside of a function for now
    # Write default prompt prefix
    $prompt += Write-Prompt $settings.DefaultPromptPrefix.Expand()

    # Get the current path - formatted correctly
    $promptPath = $settings.DefaultPromptPath.Expand()

    # Write default prompt before suffix text
    $prompt += Write-Prompt $settings.DefaultPromptBeforeSuffix.Expand()

    # If stopped in the debugger, the prompt needs to indicate that by writing default propmt debug
    if ((Test-Path Variable:/PSDebugContext) -or [runspace]::DefaultRunspace.Debugger.InBreakpoint) {
        $prompt += Write-Prompt $settings.DefaultPromptDebug.Expand()
    }

    # Get the prompt suffix text
    $promptSuffix = $settings.DefaultPromptSuffix.Expand()

    # Interruptin realy quick
    # The following Prompt function displays the history ID of the next command. To
    # view the command history, use the Get-History cmdlet.
    # The at sign creates an array in case only one history item exists.
    $history = @(Get-History)
    if($history.Count -gt 0)
    {
        $lastItem = $history[$history.Count - 1]
        $lastId = $lastItem.Id
    }
    $nextCommand = $lastId + 1
    $currentDirectory = Get-Location
    Write-Prompt "PS: $nextCommand $currentDirectory >"

        # Back to poshgit
        # When using Write-Host, we return a single space from this function to prevent PowerShell from displaying "PS>"
        # So to avoid two spaces at the end of the suffix, remove one here if it exists
        if (!$settings.AnsiConsole -and $promptSuffix.Text.EndsWith(' ')) {
            $promptSuffix.Text = $promptSuffix.Text.Substring(0, $promptSuffix.Text.Length - 1)
        }
    }
}
# }}}

[ScriptBlock]$Prompt = {

    # {{{

# function prompt() {
#
    $realLASTEXITCODE = $LASTEXITCODE
    $host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf
    PrePrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
        else { '' }) + 'PS ' + $(Get-Location) +
    $(if ($NestedPromptLevel -ge 1) { '<Nested:>' }) + '> ' +
    '[' + $env:COMPUTERNAME + ']>' +
    "$(Get-Date)> "
    $realLASTEXITCODE = $LASTEXITCODE
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity

    if($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { "[ADMIN]: " }
    else { '' }
$origLastExitCode = $global:LASTEXITCODE

  if ($settings.SetEnvColumns) {
    # Set COLUMNS so git knows how wide the terminal is
    $Env:COLUMNS = $Host.UI.RawUI.WindowSize.Width
  }
}  # }}}

$prompt

# }}}

# Aliases: {{{

# Mar 14, 2020: Look what I found today!
function tree { Show-Tree -ShowLeaf -UseAsciiLineArt $args }

if (Test-Path alias:grep) { Remove-Item Alias:grep }

# function grep { C:\git\usr\bin\grep.exe $args }
function grep { "$env:GITDIR" + "\usr\bin\grep.exe" }

if (Test-Path alias:rm) { Remove-Item Alias:rm }
if (Test-Path alias:curl) { Remove-Item Alias:curl }

# ls aliases: {{{

# damn i love how every time i do this i use a slightly different syntax lol
if ( Test-Path alias:ls ) { Remove-Item alias:ls -Force }

# Okay so because we decided to make ls dependent on where git was installed lets try to be smarter about this
# fuck if we define it this way then `ls` doesn't accept args and this raises ughhhhh
# function ls() { Invoke-Expression "$env:GITDIR/usr/bin/ls.exe" -Fh --color=always $args }

# These don't take arguments correctly
# function InvokeLS {  Invoke-Expression -Command $env:GITDIR/usr/bin/ls.exe }
# function CloserToLs { InvokeLS  -Fh --color=always $args }
# function ls { CloserToLs $args }

function ls() { C:/Users/fac/scoop/apps/git-with-openssh/current/usr/bin/ls.exe -Fh --hide="NTUSER.*" --color=always $args }
function l() {  ls -Fh --hide=NTUSER.* --color=always $args }
function la() { ls -AFh --hide=NTUSER.* --color=always }
function ldir() { ls -Fhpo --hide="NTUSER.*" $args | grep /$ }
function lf() { ls -Foh --hide="NTUSER.*" $args | grep ^- }

# *sigh*
function ll { Get-ChildItem -Verbose -Force $args }
# function ll() { ls -FAgoh --hide="NTUSER.*" --color=always $args }
function lr() { ls -Altcr --hide="NTUSER.*" --color=always $args }
function lt() { ls -Altc --hide="NTUSER.*" --color=always $args }
function lx() { ls -Fo --color=always --hide=NTUSER.* $args | grep ^-..x }

if ( Test-Path alias:mkdir ) {
        Remove-Item alias:mkdir -Force;
        function mkdir() { C:\git\usr\bin\mkdir.exe $args }
}

# Huh how do we do this part right. maybe?
function mk() { mkdir -pv $args[0] ; cd $args[1] }

# }}}
#
# Wall of Git aliases: {{{

if ( Test-Path alias:gci ) {
    Remove-Item alias:gci -Force
}

# git commit
function gci() { git.exe commit --verbose $args }
# function amend() { git commit --verbose --amend --reuse-message=HEAD }
function gcim() { git.exe commit --verbose --message $args[0] }
# function gcima() { git commit --verbose --all --message }
function gcia() { git.exe commit --verbose --all $args }
# function gcia() { git commit --amend }

# git branch and remote
function gb() { git.exe branch --all $args }
function gbr() { git.exe branch $args }
function gbrv() { git.exe branch -a --verbose $args }

# Git remote
function gr() { git.exe remote $args }
function grv() { git.exe remote --verbose $args }
function gpub() { git.exe publish $args }

# git add
function ga() { git.exe add $args }
function gaa() { git.exe add --all $args }
function gai() { git.exe add --interactive $args }
function gap() { git.exe add --patch $args }
function gar() { git.exe add --renormalize --all $args }
function gau() { git.exe add --update $args }

# git checkout
function gco() { git.exe checkout $args[0] }
function gcob() { git.exe checkout -b $args[0] }

# git reset
# function grp() { git reset --patch $args }
function gunstage() { git.exe reset HEAD $args }

# git fetch
function gf() { git.exe fetch --all $args }

# git diff
function g() { git.exe diff --stat --staged -- $args }
function gd() { git.exe diff $args }
function gst() { git.exe diff --stat $args }
function gds() { git.exe diff --cached $args }
# This doesn't work
# function gds2() { 'git.exe diff --stat --staged -- ' }
function gdw() { git.exe diff --word-diff $args }
function gdsw() { git.exe diff --cached --word-diff $args }

# difftool
function gdt() { git.exe difftool $args }
function gdtc() { git.exe difftool --cached $args }
function gdtp() { git.exe difftool --tool=p4 $args }
function gdtcp() { git.exe difftool --cached --tool=p4 $args }

# git status
function gs() { git.exe status $args }
function gsb() { git.exe status -sb $args }

# git push
function gpu() { git.exe push $args }
function gpuf() { git.exe push --force $args }
function gpuo() { git.exe push origin $args }
function gpuof() { git.exe push origin --force $args }

if ( Test-Path alias:gp ) { Remove-Item alias:gp -Force }

# pull
function gp () { git.exe pull $args }
function gpa () { git.exe pull --all $args }

# Log
function gl() {
    git.exe log --graph --date-order -M --pretty=format:"<%h> %ad [%an] %Cgreen%d%Creset %s" --all --date=short --max-count=15 --date=iso $args
}

function glg() { git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative $args }

    # What the hell is error 8? This command keeps dying
function g_log() { git log --graph --decorate --abbrev-commit --branches --all --pretty=format:lg --oneline $args }

if ( Test-Path alias:gl ) { Remove-Item alias:gl -Force }
function glo() { git.exe log $args }

# Merges
function gmm() { git.exe merge master $args }
function gm() { git.exe merge --no-ff $args }

# mergetool
function gmt() { git.exe mergetool $args }
function gmtp() { git.exe mergetool --tool=p4 $args }

# stash
function gsh() { git.exe stash $args }
function gshl() { git.exe stash list $args }
function gshp() { git.exe stash pop $args }
function gshd() { git.exe stash drop $args }
function gsha() { git.exe stash apply $args }
function gshs() { git.exe stash show $args }
function gshsp() { git.exe stash show --patch $args }

# rebase
function gre() { git.exe rebase $args }
function grei() { git.exe rebase --interactive $args }
function grec() { git.exe rebase --continue $args }
function grea() { git.exe rebase --abort $args }

# }}}

# }}}

# Readline: {{{

# Basic Bindings: {{{
# https://github.com/PowerShell/PSReadLine#post-installation
# No just don't import it now that we have it in the using directives up top
# if ($host.Name -eq 'ConsoleHost') {
#     # TODO: this is raising. you were missing left {
#     Import-Module PSReadLine
# }

# I know I know. Hey at least the fucking tab key works now!
# I'm sorry because this shouldn't be true but a lot of these bindings
# depend on emacs mode being set. I can't wait to fix that but
Set-PSReadlineOption -EditMode emacs

# 06/11/201
Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -HistorySearchCursorMovesToEnd

# Let's setup better history searching:
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward

                         # Can only define description with scriptblocks
                         # -BriefDescription 'Search history' `
                         # -Description 'Complete the buffer with the currently entered text.'

Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
# Yo also Ctrl-Space never works for me. So I'm gonna put what Alt-= used to be
# Set-PSReadLineKeyHandler -Key Ctrl+SPACEBAR -Function PossibleCompletions
# I figured it out!
# Set-PSReadLineKeyHandler -Key [System.ConsoleKey]::Ctrl+Spacebar -Function Complete
Set-PSReadLineKeyHandler -Key "Ctrl+Spacebar" -Function Complete
Set-PSReadlineOption -ExtraPromptLineCount 1

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# This isn't a function???? fuck
# Set-PSReadlineKeyHandler -Key Tab -Function MenuCompleteBackward

# In Emacs mode - Tab acts like in bash, but the Windows style completion
# is still useful sometimes, so bind some keys so we can do both
Set-PSReadlineKeyHandler -Key "Ctrl+/" -Function TabCompleteNext
Set-PSReadlineKeyHandler -Key "Ctrl+Shift+/" -Function TabCompletePrevious

# Except for the fact that it raises an error all the time
# Oh my god this works SO much better
Set-PSReadlineKeyHandler -Key "Alt+/" -Function PossibleCompletions
Set-PSReadlineKeyHandler -Key "Alt+=" -Function PossibleCompletions

Set-PSReadlineKeyHandler -Key "Alt+?" -Function ShowKeyBindings

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# }}}

# From the author of PSReadline himself: {{{

# Show Command History: {{{
# This key handler shows the entire or filtered history using Out-GridView. The
# typed text is used as the substring pattern for filtering. A selected command
# is inserted to the command line without invoking. Multiple command selection
# is supported, e.g. selected by Ctrl + Click.
Set-PSReadlineKeyHandler -Key F7 `
    -BriefDescription History `
    -LongDescription 'Show command history' `
    -ScriptBlock {
    $pattern = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
    if ($pattern) {
        $pattern = [regex]::Escape($pattern)
    }

    $history = [System.Collections.ArrayList]@(
        $last = ''
        $lines = ''
        foreach ($line in [System.IO.File]::ReadLines((Get-PSReadlineOption).HistorySavePath)) {
            if ($line.EndsWith('`')) {
                $line = $line.Substring(0, $line.Length - 1)
                $lines = if ($lines) {
                    "$lines`n$line"
                }
                else {
                    $line
                }
                continue
            }

            if ($lines) {
                $line = "$lines`n$line"
                $lines = ''
            }

            if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
                $last = $line
                $line
            }
        }
    )
    $history.Reverse()

    $command = $history | Out-GridView -Title History -PassThru
    if ($command) {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
    }
}  # }}}

# Build Current Directory: {{{
# This is an example of a macro that you might use to execute a command.
# This will add the command to history.
Set-PSReadlineKeyHandler -Key Ctrl+B `
    -BriefDescription BuildCurrentDirectory `
    -LongDescription "Build the current directory" `
    -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("msbuild")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
# }}}

# A few simple bindings: {{{

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
# wt handles this for us
# Set-PSReadlineKeyHandler -Key Shift+Ctrl+C -Function Copy
# Set-PSReadlineKeyHandler -Key Ctrl+V -Function Paste

# CaptureScreen is good for blog posts or email showing a transaction
# of what you did when asking for help or demonstrating a technique.
Set-PSReadlineKeyHandler -Chord 'Ctrl+X,Ctrl+P' -Function CaptureScreen

# The built-in word movement uses character delimiters, but token based word
# movement is also very useful - these are the bindings you'd use if you
# prefer the token based movements bound to the normal emacs word movement
# key bindings.
Set-PSReadlineKeyHandler -Key Alt+D -Function ShellKillWord
Set-PSReadlineKeyHandler -Key Alt+Backspace -Function ShellBackwardKillWord
Set-PSReadlineKeyHandler -Key Alt+B -Function ShellBackwardWord
Set-PSReadlineKeyHandler -Key Alt+F -Function ShellForwardWord
Set-PSReadlineKeyHandler -Key Shift+Alt+B -Function SelectShellBackwardWord
Set-PSReadlineKeyHandler -Key Shift+Alt+F -Function SelectShellForwardWord

# }}}

# region Smart Insert/Delete: {{{

# The next four key handlers are designed to make entering matched quotes
# parens, and braces a nicer experience.  I'd like to include functions
# in the module that do this, but this implementation still isn't as smart
# as ReSharper, so I'm just providing it as a sample.

# Smart \": {{{

Set-PSReadlineKeyHandler -Key '"', "'" `
    -BriefDescription SmartInsertQuote `
    -LongDescription "Insert paired quotes if not already on a quote" `
    -ScriptBlock {
    param($key, $arg)

    $quote = $key.KeyChar

    $selectionStart = $null
    $selectionLength = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # If text is selected, just quote it without any smarts
    if ($selectionStart -ne -1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
        return
    }

    $ast = $null
    $tokens = $null
    $parseErrors = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)

    function FindToken {
        param($tokens, $cursor)

        foreach ($token in $tokens) {
            if ($cursor -lt $token.Extent.StartOffset) { continue }
            if ($cursor -lt $token.Extent.EndOffset) {
                $result = $token
                $token = $token -as [StringExpandableToken]
                if ($token) {
                    $nested = FindToken $token.NestedTokens $cursor
                    if ($nested) { $result = $nested }
                }

                return $result
            }
        }
        return $null
    }

    $token = FindToken $tokens $cursor

    # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
    if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic) {
        # If we're at the start of the string, assume we're inserting a new string
        if ($token.Extent.StartOffset -eq $cursor) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
            return
        }

        # If we're at the end of the string, move over the closing quote if present.
        if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote) {
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
            return
        }
    }

    if ($null -eq $token) {
        if ($line[0..$cursor].Where{ $_ -eq $quote }.Count % 2 -eq 1) {
            # Odd number of quotes before the cursor, insert a single quote
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
        }
        else {
            # Insert matching quotes, move cursor to be in between the quotes
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
        }
        return
    }

    if ($token.Extent.StartOffset -eq $cursor) {
        if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier) {
            $end = $token.Extent.EndOffset
            $len = $end - $cursor
            [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
        }
        return
    }

    # We failed to be smart, so just insert a single quote
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
}  # }}}

# InsertPairedBraces: {{{
Set-PSReadlineKeyHandler -Key '(', '{', '[' `
    -BriefDescription InsertPairedBraces `
    -LongDescription "Insert matching braces" `
    -ScriptBlock {
    param($key, $arg)

    $closeChar = switch ($key.KeyChar) {
        <#case#> '(' { [char]')'; break }
        <#case#> '{' { [char]'}'; break }
        <#case#> '[' { [char]']'; break }
    }

    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
}  # }}}

# SmartCloseBraces: {{{
Set-PSReadlineKeyHandler -Key ')', ']', '}' `
    -BriefDescription SmartCloseBraces `
    -LongDescription "Insert closing brace or skip" `
    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($line[$cursor] -eq $key.KeyChar) {
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
    }
}  # }}}

# SmartBackspace: {{{
Set-PSReadlineKeyHandler -Key Backspace `
    -BriefDescription SmartBackspace `
    -LongDescription "Delete previous character or matching quotes/parens/braces" `
    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -gt 0) {
        $toMatch = $null
        if ($cursor -lt $line.Length) {
            switch ($line[$cursor]) {
                <#case#> '"' { $toMatch = '"'; break }
                <#case#> "'" { $toMatch = "'"; break }
                <#case#> ')' { $toMatch = '('; break }
                <#case#> ']' { $toMatch = '['; break }
                <#case#> '}' { $toMatch = '{'; break }
            }
        }

        if ($toMatch -ne $null -and $line[$cursor - 1] -eq $toMatch) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
        }
        else {
            [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
        }
    }
}  # }}}

#endregion Smart Insert/Delete  # }}}

# SaveInHistory: {{{
# Sometimes you enter a command but realize you forgot to do something else first.
# This binding will let you save that command in the history so you can recall it,
# but it doesn't actually execute.  It also clears the line with RevertLine so the
# undo stack is reset - though redo will still reconstruct the command line.
Set-PSReadlineKeyHandler -Key Alt+w `
    -BriefDescription SaveInHistory `
    -LongDescription "Save current line in history but do not execute" `
    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}  # }}}

# Insert text from the clipboard as a here string: {{{
Set-PSReadlineKeyHandler -Key Alt+v `
    -BriefDescription PasteAsHereString `
    -LongDescription "Paste the clipboard text as a here string" `
    -ScriptBlock {
    param($key, $arg)

    Add-Type -Assembly PresentationCore
    if ([System.Windows.Clipboard]::ContainsText()) {
        # Get clipboard text - remove trailing spaces, convert \r\n to \n, and remove the final \n.
        $text = ([System.Windows.Clipboard]::GetText() -replace "\p{Zs}*`r?`n", "`n").TrimEnd()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("@'`n$text`n'@")
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
    }
}  # }}}

# ParenthesizeSelection: {{{
# Sometimes you want to get a property of invoke a member on what you've entered so far
# but you need parens to do that.  This binding will help by putting parens around the current selection,
# or if nothing is selected, the whole line.
Set-PSReadlineKeyHandler -Key 'Alt+(' `
    -BriefDescription ParenthesizeSelection `
    -LongDescription "Put parenthesis around the selection or entire line and move the cursor to after the closing parenthesis" `
    -ScriptBlock {
    param($key, $arg)

    $selectionStart = $null
    $selectionLength = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    if ($selectionStart -ne -1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, '(' + $line.SubString($selectionStart, $selectionLength) + ')')
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
        [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
    }
}  # }}}

# ToggleQuoteArgument: {{{
# Each time you press Alt+', this key handler will change the token
# under or before the cursor.  It will cycle through single quotes, double quotes, or
# no quotes each time it is invoked.
Set-PSReadlineKeyHandler -Key "Alt+'" `
    -BriefDescription ToggleQuoteArgument `
    -LongDescription "Toggle quotes on the argument under the cursor" `
    -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $tokenToChange = $null
    foreach ($token in $tokens) {
        $extent = $token.Extent
        if ($extent.StartOffset -le $cursor -and $extent.EndOffset -ge $cursor) {
            $tokenToChange = $token

            # If the cursor is at the end (it's really 1 past the end) of the previous token,
            # we only want to change the previous token if there is no token under the cursor
            if ($extent.EndOffset -eq $cursor -and $foreach.MoveNext()) {
                $nextToken = $foreach.Current
                if ($nextToken.Extent.StartOffset -eq $cursor) {
                    $tokenToChange = $nextToken
                }
            }
            break
        }
    }

    if ($tokenToChange -ne $null) {
        $extent = $tokenToChange.Extent
        $tokenText = $extent.Text
        if ($tokenText[0] -eq '"' -and $tokenText[-1] -eq '"') {
            # Switch to no quotes
            $replacement = $tokenText.Substring(1, $tokenText.Length - 2)
        }
        elseif ($tokenText[0] -eq "'" -and $tokenText[-1] -eq "'") {
            # Switch to double quotes
            $replacement = '"' + $tokenText.Substring(1, $tokenText.Length - 2) + '"'
        }
        else {
            # Add single quotes
            $replacement = "'" + $tokenText + "'"
        }

        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
            $extent.StartOffset,
            $tokenText.Length,
            $replacement)
    }
}   # }}}

# ExpandAliases: {{{
# This example will replace any aliases on the command line with the resolved commands.
Set-PSReadlineKeyHandler -Key "Alt+%" `
    -BriefDescription ExpandAliases `
    -LongDescription "Replace all aliases with the full command" `
    -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $startAdjustment = 0
    foreach ($token in $tokens) {
        if ($token.TokenFlags -band [TokenFlags]::CommandName) {
            $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
            if ($alias -ne $null) {
                $resolvedCommand = $alias.ResolvedCommandName
                if ($resolvedCommand -ne $null) {
                    $extent = $token.Extent
                    $length = $extent.EndOffset - $extent.StartOffset
                    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
                        $extent.StartOffset + $startAdjustment,
                        $length,
                        $resolvedCommand)

                    # Our copy of the tokens won't have been updated, so we need to
                    # adjust by the difference in length
                    $startAdjustment += ($resolvedCommand.Length - $length)
                }
            }
        }
    }
}   # }}}

# F1 for help on the command line - naturally: {{{
Set-PSReadlineKeyHandler -Key F1 `
    -BriefDescription CommandHelp `
    -LongDescription "Open the help window for the current command" `
    -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $commandAst = $ast.FindAll( {
            $node = $args[0]
            $node -is [CommandAst] -and
            $node.Extent.StartOffset -le $cursor -and
            $node.Extent.EndOffset -ge $cursor
        }, $true) | Select-Object -Last 1

    if ($commandAst -ne $null) {
        $commandName = $commandAst.GetCommandName()
        if ($commandName -ne $null) {
            $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
            if ($command -is [AliasInfo]) {
                $commandName = $command.ResolvedCommandName
            }

            if ($commandName -ne $null) {
                Get-Help $commandName -ShowWindow
            }
        }
    }
}  # }}}

$global:PSReadLineMarks = @{ }

# Ctrl+Shift+j then type a key to mark the current directory.: {{{
Set-PSReadlineKeyHandler -Key Ctrl+Shift+j `
    -BriefDescription MarkDirectory `
    -LongDescription "Mark the current directory" `
    -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey($true)
    $global:PSReadLineMarks[$key.KeyChar] = $pwd
}  # }}}

# Jump to marked directory: {{{
# Ctrj+j then the same key will change back to that directory without
# needing to type cd and won't change the command line.
Set-PSReadlineKeyHandler -Key Ctrl+j `
    -BriefDescription JumpDirectory `
    -LongDescription "Goto the marked directory" `
    -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey()
    $dir = $global:PSReadLineMarks[$key.KeyChar]
    if ($dir) {
        cd $dir
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }
}   # }}}

# ShowDirectoryMarks: {{{
Set-PSReadlineKeyHandler -Key Alt+j `
    -BriefDescription ShowDirectoryMarks `
    -LongDescription "Show the currently marked directories" `
    -ScriptBlock {
    param($key, $arg)

    $global:PSReadLineMarks.GetEnumerator() | % {
        [PSCustomObject]@{Key = $_.Key; Dir = $_.Value } } |
    Format-Table -AutoSize | Out-Host

    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}  # }}}

# CommandValidationHandler: {{{
# So wait is the point of this that it fixes cmt to commit
Set-PSReadlineOption -CommandValidationHandler {
    param([CommandAst]$CommandAst)

    switch ($CommandAst.GetCommandName()) {
        'git' {
            $gitCmd = $CommandAst.CommandElements[1].Extent
            switch ($gitCmd.Text) {
                'cmt' {
                    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
                        $gitCmd.StartOffset, $gitCmd.EndOffset - $gitCmd.StartOffset, 'commit')
                }
            }
        }
    }
} # }}}

# }}}

# }}}

# FZF:  {{{
if (Test-Path $env\FZF_DEFAULT_COMMAND -IsValid){  # {{{FZF Env vars

    # $env:FZF_DEFAULT_COMMAND = 'rg --hidden --color=ansi --follow --no-messages --no-heading --smart-case --no-filename --glob "!.git/*" -g "!**node_modules/**" --passthru --max-depth 10 --max-count 2 --max-columns 200 -C 0 --files '
    $env:FZF_DEFAULT_COMMAND = 'fd -d 6 -t f --exclude "node_modules" --exclude "*.dll" --exclude "*.mui" '

    $env:FZF_DEFAULT_OPTS = ' --multi --cycle --reverse --prompt "Query: " --tiebreak begin,length,index --ansi --filepath-word --border --header "FZF: File Browser"+"Press ? to toggle preview"'

    # $env:FZF_CTRL_T_COMMAND = 'rg --hidden --color=ansi  --follow --no-messages --no-heading --smart-case --files --passthru --max-depth 10 --max-count 20 --max-columns 200 -C 0 --glob "!.git/* -g "!**node_modules/**" . '
    $env:FZF_CTRL_T_COMMAND = 'fd --follow -d 6 -t f --hidden --exclude "node_modules" --exclude "*.dll" --exclude "*.mui" '
    $env:FZF_CTRL_T_OPTS = ' --tiebreak begin,length,index --filepath-word --multi --cycle --border --reverse --preview-window=right:60%:wrap --preview "less -RrFJKLMN {}" --ansi --header "FZF: File Browser: Press ? to toggle preview.  Alt-n to launch nvim. " --bind "alt-n:execute(nvim {}) " '

    # $env:FZF_CTRL_R_COMMAND = "rg --hidden --color=ansi --no-heading --smart-case --no-filename --no-messages "
    $env:FZF_CTRL_R_COMMAND = 'fd --hidden '
    $env:FZF_CTRL_R_OPTS = " --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --preview 'cat {}' --preview-window=down:wrap --header 'Press ? to toggle preview' "

    $env:FZF_ALT_C_COMMAND = "fd --type d --hidden --follow --exclude .git --color always --ignore-file $HOME/.ignore "
    $env:FZF_ALT_C_OPTS = " --cycle --ansi --tiebreak begin,length,index --no-multi --filepath-wor' --header 'Press ? to toggle preview' --border --prompt 'FZF Dir Finder' --preview 'ls -lRhF --color=always {}' | head -n 200 "


} # }}}

# Colorscheme: {{{

function _gen_fzf_default_opts() {
    $color00='#1d2021'
    $color01='#3c3836'
    # $color02='#504945'
    # $color03='#665c54'
    $color04='#bdae93'
    # $color05='#d5c4a1'
    $color06='#ebdbb2'
    # $color07='#fbf1c7'
    $color08='#fb4934'
    $color09='#fe8019'
    $color0A='#fabd2f'
    # $color0B='#b8bb26'
    $color0C='#8ec07c'
    $color0D='#83a598'
    $color0E='#d3869b'
    $color0F='#d65d0e'

    $env:FZF_COLORSCHEME=" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0A --color=fg:$color06,header:$color09,info:$color0E,pointer:$color0F --color=marker:$color0D,fg+:$color06,prompt:$color08,hl+:$color04 "

# Also I'm gonna tack on the binds that I want everywhere
$env:FZF_COLORSCHEME += "--bind 'ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-v:preview-page-up,alt-v:preview-page-down,alt-j:preview-down,alt-k:preview-up,?:toggle-preview,ctrl-k:kill-line,change:top'"
}
_gen_fzf_default_opts  # }}}

$env:FZF_DEFAULT_OPTS = $env:FZF_DEFAULT_OPTS + $env:FZF_COLORSCHEME
$env:FZF_CTRL_R_OPTS = $env:FZF_CTRL_R_OPTS + $env:FZF_COLORSCHEME
$env:FZF_CTRL_T_OPTS = $env:FZF_CTRL_T_OPTS + $env:FZF_COLORSCHEME
$env:FZF_ALT_C_OPTS = $env:FZF_ALT_C_OPTS + $env:FZF_COLORSCHEME

# Utilizing the PSFzf API: {{{

# this is needed because he aliases fzf to fd but i have fd-find
if ( Test-Path alias:fd ) { Remove-Item alias:fd -Force }

# I guess this depends on importing PsFzf succesfully lol
function fcd() { cd (gci -Recurse | where {$_.PSIsContainer} | Invoke-FuzzySetLocation) }

# Yo don't use his argument list let's just utilize a little powershell and we'll get there
Remove-PSReadlineKeyHandler Ctrl-t
Remove-PSReadlineKeyHandler -Chord 'Ctrl-r'
# }}}

# Invoke-FuzzyEdit: {{{

# TODO: Doesn't work
Set-PSReadlineKeyHandler -Key "Alt+t" `
                    -BriefDescription Invoke-FuzzyEdit `
                    -LongDescription "Use FZF to preview files and edit with nvim." `
                    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadline]::Insert("cd $(gci -Recurse | where {$_.PSIsContainer} | Invoke-Fzf)")
    [Microsoft.PowerShell.PSConsoleReadline]::AcceptLine()
    } # }}}

# ReverseSearchHistory: {{{
Set-PSReadlineKeyHandler -Chord 'Alt+r' `
                         -BriefDescription "ReverseSearchHistory"  `
                         -Description "Search the user's command history using FZF." `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadline]::Insert("$(Get-History | ForEach-Object { $_.CommandLine } | fzf.exe)")
    [Microsoft.PowerShell.PSConsoleReadline]::AcceptLine()
}  # }}}

Set-PSReadlineKeyHandler -Chord 'Ctrl+x,Ctrl+g' -ScriptBlock {  # {{{
  [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadline]::Insert("cd $(ghq list -p | fzf)")
  [Microsoft.PowerShell.PSConsoleReadline]::AcceptLine()
}  # }}}

# {{{
Set-PSReadlineKeyHandler -Key 'Ctrl+l' -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadline]::AcceptLine()
  Clear-Host
}  # }}}

# TODO: Doesn't work but most of the idea is right
Set-PSReadLineKeyHandler -Key "Alt+Shift+c"  `
                         -BriefDescription 'InvokeFuzzySetLocation' `
                         -Description 'Set the location using fd and fzf' `
                         -ScriptBlock {
      [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()
      # [Microsoft.PowerShell.PSConsoleReadline]::Insert("cd $(fd -t d -H  | Invoke-Fzf)")
      [Microsoft.PowerShell.PSConsoleReadline]::Insert("Invoke-FuzzySetLocation -Directory $env:HOME")
      [Microsoft.PowerShell.PSConsoleReadline]::AcceptLine()
      Clear-Host
 }

# Not allowed to do it this way
# Set-PSReadLineKeyHandler -Key "Alt+c" -Function fcd
# how to do if not loaded
Import-Module PSFzf -ArgumentList "Ctrl+t","Alt+c","Alt+a","Ctrl+r"

# Idk how to check that there's a handler
# if get-psreadlinekeyhandler is none....
# Set-PSReadLineKeyHandler  -Key "Ctrl-t" `
#                           -BriefDescription "FZF File widget" `
#                           -ScriptBlock { Invoke-Fzf -Preview "bat --color=always {}" }

# }}}

### WinPython_PS_Prompt.ps1 ###  {{{
###############################

$0 = $myInvocation.MyCommand.Definition
$dp0 = [System.IO.Path]::GetDirectoryName($0)

$env:WINPYDIRBASE = "$dp0\.."
# get a normalize path
# http://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name
$env:WINPYDIRBASE = [System.IO.Path]::GetFullPath( $env:WINPYDIRBASE )

# So that's a neat way of doing this however it won't be right.
$env:WINPYDIRBASE = 'C:\Users\fac\scoop\apps\winpython\current'
#
# avoid double_init (will only resize screen)
if (-not ($env:WINPYDIR -eq [System.IO.Path]::GetFullPath( $env:WINPYDIRBASE+"\python-3.8.1.amd64")) ) {

$env:WINPYDIR = $env:WINPYDIRBASE+"\python-3.8.1.amd64"
# 2019-08-25 pyjulia needs absolutely a variable PYTHON=%WINPYDIR%python.exe
# $env:PYTHON = "%WINPYDIR%\python.exe"

$env:WINPYVER = '3.8.1.0'
# Stop fucking overwriting this jesus
# $env:HOME = "$env:WINPYDIRBASE\settings"
# $env:WINPYDIRBASE = ""
# $env:JUPYTER_DATA_DIR = "$env:HOME"
$env:WINPYARCH = 'WIN32'
if ($env:WINPYARCH.subString($env:WINPYARCH.length-5, 5) -eq 'amd64')  {
   $env:WINPYARCH = 'WIN-AMD64' }


# if (-not $env:PATH.ToLower().Contains(";"+ $env:WINPYDIR.ToLower()+ ";"))  {

#  $env:PATH = "$env:WINPYDIR\Lib\site-packages\PyQt5;$env:WINPYDIR\Lib\site-packages\PySide2;$env:WINPYDIR\;$env:WINPYDIR\DLLs;$env:WINPYDIR\Scripts;$env:WINPYDIR\..\t;$env:WINPYDIR\..\t\mingw32\bin;$env:WINPYDIR\..\t\R\bin\x64;$env:WINPYDIR\..\t\Julia\bin;$env:WINPYDIR\..\n;$env:path;" }

#rem force default pyqt5 kit for Spyder if PyQt5 module is there
if (Test-Path "$env:WINPYDIR\Lib\site-packages\PyQt5\__init__.py") { $env:QT_API = "pyqt5" }

#####################
### handle R if included
#####################
if (Test-Path "$env:WINPYDIR\..\t\R\bin") {
    $env:R_HOME = "$env:WINPYDIR\..\t\R"
    $env:R_HOMEbin = "$env:R_HOME\bin\x64"
    if ("$env:WINPYARCH" -eq "WIN32") {
        $env:R_HOMEbin = "$env:R_HOME\bin\i386"
    }
}

#####################
### handle Julia if included
#####################
if (Test-Path "$env:WINPYDIR\..\t\Julia\bin") {
    $env:JULIA_HOME = "$env:WINPYDIR\..\t\Julia\bin\"
    $env:JULIA_EXE = "julia.exe"
    $env:JULIA = "$env:JULIA_HOME$env:JULIA_EXE"
    $env:JULIA_PKGDIR = "$env:WINPYDIR\..\settings\.julia"
}

#####################
### handle PySide2 if included
#####################

$env:tmp_pyz = "$env:WINPYDIR\Lib\site-packages\PySide2"
if (Test-Path "$env:tmp_pyz") {
   $env:tmp_pyz = "$env:tmp_pyz\qt.conf"
   if (-not (Test-Path "$env:tmp_pyz")) {
      "[Paths]"| Add-Content -Path $env:tmp_pyz
      "Prefix = ."| Add-Content -Path $env:tmp_pyz
      "Binaries = ."| Add-Content -Path $env:tmp_pyz
   }
}

#####################
### handle PyQt5 if included
#####################
$env:tmp_pyz = "$env:WINPYDIR\Lib\site-packages\PyQt5"
if (Test-Path "$env:tmp_pyz") {
   $env:tmp_pyz = "$env:tmp_pyz\qt.conf"
   if (-not (Test-Path "$env:tmp_pyz")) {
      "[Paths]"| Add-Content -Path $env:tmp_pyz
      "Prefix = ."| Add-Content -Path $env:tmp_pyz
      "Binaries = ."| Add-Content -Path $env:tmp_pyz
   }
}


#####################
### WinPython.ini part (removed from nsis)
#####################
if (-not (Test-Path "$env:WINPYDIR\..\settings")) { md -Path "$env:WINPYDIR\..\settings" }
$env:winpython_ini = "$env:WINPYDIR\..\settings\winpython.ini"
if (-not (Test-Path $env:winpython_ini)) {
    "[debug]" | Add-Content -Path $env:winpython_ini
    "state = disabled" | Add-Content -Path $env:winpython_ini
    "[environment]" | Add-Content -Path $env:winpython_ini
    "## <?> Uncomment lines to override environment variables" | Add-Content -Path $env:winpython_ini
    # "#HOME = %%HOMEDRIVE%%%%HOMEPATH%%\Documents\WinPython%%WINPYVER%%" | Add-Content -Path $env:winpython_ini
    # "#JUPYTER_DATA_DIR = %%HOME%%" | Add-Content -Path $env:winpython_ini
    "#WINPYWORKDIR = %%HOMEDRIVE%%%%HOMEPATH%%" | Add-Content -Path $env:winpython_ini
    }
}

# Python Env vars:
$env:PYTHONASYNCIODEBUG=0
$env:PYTHONCASEOK=1
$env:PYTHONCOERCECLOCALE="warn"
$env:PYTHONDEVMODE=1
$env:PYTHONDOCS="$env:HOME/python/official-python-docs/3.7/library/build/html"
$env:PYTHONDONTWRITEBYTECODE=1
$env:PYTHONDUMPREFS=1
$env:PYTHONIOENCODING='utf-8:surrogateescape'
$env:PYTHONMALLOC="debug"
# $env:PYTHONMALLOCSTATS="nonemptystring"
$env:PYTHONTHREADDEBUG=1
# $env:PYTHONTRACEMALLOC=1
$env:PYTHONUTF8=1

$env:IPYTHONDIR="$env:HOME\.ipython"
# }}}

# Set-MsbuildDevEnvironment: {{{
#.SYNOPSIS
# Grabs all environment variable set after vcvarsall.bat is called and pulls
# them into the Powershell environment.
# From: https://github.com/microsoft/terminal/blob/v0.5.2762.0/tools/OpenConsole.psm1
function Set-MsbuildDevEnvironment
{
    [CmdletBinding()]
    param(
        [switch]$Prerelease
    )
    $ErrorActionPreference = 'Stop'
    Import-LocalModule -Name 'VSSetup'
    Write-Verbose 'Searching for VC++ instances'
    $vsinfo = `
        Get-VSSetupInstance  -All -Prerelease:$Prerelease `
        | Select-VSSetupInstance `
            -Latest -Product * `
            -Require 'Microsoft.VisualStudio.Component.VC.Tools.x86.x64'

    $vspath = $vsinfo.InstallationPath
    switch ($env:PROCESSOR_ARCHITECTURE) {
        "amd64" { $arch = "x64" }
        "x86" { $arch = "x86" }
        default { throw "Unknown architecture: $switch" }
    }

    $vcvarsall = "$vspath\VC\Auxiliary\Build\vcvarsall.bat"
    Write-Verbose 'Setting up environment variables'
    cmd /c ("`"$vcvarsall`" $arch & set") | ForEach-Object {
        if ($_ -match '=')
        {
            $s = $_.Split("=");
            Set-Item -force -path "env:\$($s[0])" -value "$($s[1])"
        }
    }
    Write-Host "Dev environment variables set" -ForegroundColor Green
}
# }}}

# Other: {{{
$env:CFLAGS="-Wno-unused-value -Wno-empty-body -Qunused-arguments -no-integrated-as -fstack-protector-strong -O3 "
$env:CC="clang"
$env:CXX="clang++"
$env:XDG_CACHE_HOME="$env:HOME\.cache"
$env:XDG_DATA_HOME='C:\Users\fac\.local\share'
$env:XDG_CONFIG_HOME='C:\Users\fac\.config'
# $env:LANG='en_US.UTF-8'
# $env:LANGUAGE='en_US.UTF-8'
# vim starts up so much faster that you HAVE to keep this set to this
$env:LC_ALL="C"
$env:LC_COLLATE="C.UTF-8"
$env:LANG="C"
$env:LANGUAGE="C"
# $env:LANG="en_US.UTF-8"

# Holy cow do i need more. I realize that i typically set these in the GUI
# but none of these were set!
# $env:TERM='cygwin'
$env:EDITOR='nvim'
$env:VISUAL='nvim-qt'
$env:PAGER="less -JRrKMNLigeF"
$env:MANPAGER=$env:PAGER
# Also seemingly don't set $TERM to xterm256-color. i lost the changes you get
# to the cursor in nvim
$env:LESSHISTSIZE=5000  # default is 100
$env:POWERSHELL_TELEMETRY_OPTOUT=1
$env:DOTNET_CLI_TELEMETRY_OPTOUT=1
$env:NPY_DISTUTILS_APPEND_FLAGS=1
$env:DISTUTILS_DEBUG=1

$env:SHELLCHECKOPTS='--shell=bash -X --exclude=SC2016'
$env:RIPGREP_CONFIG_PATH="$env:HOME\.ripgreprc"
$env:LESSHISTSIZE=5000
$env:LESSCOLORIZER="pygmentize"

$env:NODE_PRESERVE_SYMLINKS=1
$env:NODE_REPL_HISTORY="$env:HOME/AppData/Local/node_log.js"
$env:NVIM_NODE_LOG_FILE = "$env:HOME\AppData\Local\nvim-data\nvim_node.log"
$env:NVIM_NODE_LOG_LEVEL = "WARNING"
$env:NVIM_PYTHON_LOG_FILE = "$env:HOME\AppData\Local\nvim-data\nvim_python.log"
$env:NVIM_PYTHON_LOG_LEVEL = "logging.DEBUG"

Write-Output "Success: Sourced Documents/PowerShell/profile.ps1"

# }}}

# Cleanup: {{{
if ( $sw.IsRunning ) {
    write-host $sw.ElapsedMilliseconds
    $sw.Stop()
}
# }}}
