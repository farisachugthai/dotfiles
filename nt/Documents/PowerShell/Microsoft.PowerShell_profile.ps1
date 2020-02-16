<# The basics to not go insane --- Module Docstring: {{{
Jun 17, 2019: Basically wiped the computer and am starting again sorta
from scratch.

Notes:

#) You ran the following.:

    C:\Users\faris\Dropbox\git
    »  Set-PSRepository -InstallationPolicy Trusted PSGallery

#) KEEP POWERSHELLGET ABOVE INVOCATION OF FIND-COMMAND DUDE!

The FZF section used to slow down the profile dramatically

#) DON'T EVER INSTALL the FASDR module it stole your tab expansion!

#) Try-catch


# try {
    # Don't forget to add the word scripts so we get the actual binaries
        # if ( Test-Path $env:VIRTUAL_ENV ){$env:PATH = $env:VIRTUAL_ENV + '\Scripts;' + $env:PATH}
# }

# Test path raises this
# +      ~~~~~~~~~~~~~~~~~~~~~~~~~~
# + CategoryInfo          : InvalidArgument: (:) [Test-Path], ArgumentNullException
# + FullyQualifiedErrorId : NullPathNotPermitted,Microsoft.PowerShell.Commands.TestPathCommand

# Fuck this still doesn't catch right!
# catch  [InvalidArgument],[NullPathNotPermitted],[ArgumentNullException] { continue }


}}} #>

# Path and `using`: {{{

using module PSFzf
using module PSReadline
using module posh-sshell
using module posh-git

using namespace Console
using namespace Microsoft.PowerShell.PSConsoleReadline
using namespace System.Windows.Clipboard
using namespace System.Windows.Forms
using namespace System.Management.Automation
using namespace System.Management.Automation.Language
using namespace System.ConsoleKey

# in case those didn't work

# Import-Module posh-git
# nope! actually it raises an error because using must be at the top
# using module posh-git

# Only here for readability.
$Not_the_real_PATH = 'C:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x64',
';C:\Program Files (x86)\Windows Kits\10\bin\x64',
';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin',
';C:\Windows\Microsoft.NET\Framework64\v4.0.30319',
';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\IDE',
';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools',
';C:\Windows',
';C:\Windows\System32',
';C:\Windows\System32\wbem',
';C:\Windows\Syswow64',
';C:\Windows\ImmersiveControlPanel',  # dude cpanel!
';C:\ProgramData\chocolatey\bin',
';C:\Program Files\Firefox Nightly',
';C:\Neovim\bin',
';C:\Windows\System32\WindowsPowerShell\v1.0',
';C:\Program Files\PowerShell\6',
';C:\Program Files\Racket',
';C:\Python38',
';C:\Program Files\KeePassXC',
';C:\git\bin',
';C:\git\usr\bin',
';C:\git\cmd',
';C:\Users\fac\scoop\apps\nvm\current\v13.7.0',
';C:\Users\fac\scoop\shims',
';C:\Users\fac\AppData\Roaming\Python\Python38\Scripts',
';C:\Users\fac\src\ctags',
';C:\Users\fac\AppData\Local\Programs\Microsoft\VS Code,
;C:\Users\fac\AppData\Local\Yarn\bin'


# Broken up because it actually exceeds the max column for syntax highlighting
# in Vim and fucks the whole file up.

# Start with C:\Windows
$env:PATH = 'C:\Windows;C:\Windows\System32;C:\Windows\System32\wbem;C:\Windows\Syswow64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;C:\Windows\Microsoft.NET\Framework\v4.0.30319;C:\Windows\ImmersiveControlPanel'

# Get the visual studio stuff
$env:PATH = $env:PATH + ';C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\IDE;C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools'

$env:PATH = $env:PATH + ';C:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x64;C:\Program Files (x86)\Windows Kits\10\bin\x64;C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin'

# Don't add too many from scoop shims should take care of most except nvm
$env:PATH = $env:PATH + ';C:\ProgramData\chocolatey\bin;C:\Program Files\Firefox Nightly;C:\Neovim\bin;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\PowerShell\6;C:\Program Files\Racket;C:\Python38;C:\Program Files\KeePassXC'

# Git
$env:PATH = $env:PATH + ';C:\git\bin;C:\git\usr\bin;C:\git\cmd'

# Your personal folders
$env:PATH = $env:PATH + ';C:\Users\fac\scoop\apps\nvm\current\v13.7.0;C:\Users\fac\scoop\shims;C:\Users\fac\AppData\Roaming\Python\Python38\Scripts;C:\Users\fac\src\ctags;C:\Users\fac\AppData\Local\Programs\Microsoft\VS Code;C:\Users\fac\AppData\Local\Yarn\bin'

# Holy bajeezuz is this important!
if ($env:VIRTUAL_ENV) { $env:PATH = $env:VIRTUAL_ENV + '\Scripts;' + $env:PATH}

# }}}

# Beginning of me reworking this: {{{

$env:HOME = 'C:\Users\fac'

C:\Windows\System32\chcp.com 65001

try { $null = Get-Command concfg -ea stop; concfg tokencolor -n disable } catch { }
;

#
# ------------------
# functions - start
# ------------------
#

#
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

if ( Test-Path alias:sl ) { Remove-Item alias:sl -Force }
# FFS!
if ( Test-Path alias:echo ) { Remove-Item alias:echo -Force }

function Pro () { C:\Neovim\bin\nvim.exe "$Profile" }
function Reload () { Invoke-Expression "$Profile" }

function nvim_init () { C:\Neovim\bin\nvim.exe C:\Users\faris\AppData\Local\nvim\init.vim }

# fuck this naming convention
function Get-Local-ChocoPackages() { choco list --local --pre $args }

if ( ! ( Test-Path alias:clist) ) { New-Alias clist Get-Local-ChocoPackages }

# }}}

# Cmder Contributions: {{{

# Compatibility with PS major versions <= 2
if(!$PSScriptRoot) {
    $PSScriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path
}

$gitLoaded = $false

function Import-Git($Loaded){
    if($Loaded) { return }
    $GitModule = Get-Module -Name Posh-Git -ListAvailable
    if($GitModule | select version | where version -le ([version]"0.6.1.20160330")){
        Import-Module Posh-Git > $null
    }
    if(-not ($GitModule) ) {
        # Write-Warning "Missing git support, install posh-git with 'Install-Module posh-git' and restart cmder."
        return $false
    }
    # Make sure we only run once by alawys returning true
    return $true
}

# Prompt Section: {{{
#   Users should modify their user_profile.ps1 as it will be safe from updates.
#

# Pre assign the hooks so the first run of cmder gets a working prompt.
[ScriptBlock]$PrePrompt = {}
[ScriptBlock]$PostPrompt = {}
[ScriptBlock]$CmderPrompt = {
    $Host.UI.RawUI.ForegroundColor = "White"
    Microsoft.PowerShell.Utility\Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Green
    checkGit($pwd.ProviderPath)
}

<#
This scriptblock runs every time the prompt is returned.
Explicitly use functions from MS namespace to protect from being overridden in the user session.
Custom prompt functions are loaded in as constants to get the same behaviour
#>
[ScriptBlock]$Prompt = {
    $realLASTEXITCODE = $LASTEXITCODE
    $host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf
    PrePrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    CmderPrompt
    Microsoft.PowerShell.Utility\Write-Host "`nÃƒÅ½Ã‚Â» " -NoNewLine -ForegroundColor "DarkGray"
    PostPrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}

# }}}

# }}}

# Aliases: {{{

if ($PSVersionTable.PSVersion.Major -gt 5) {
    # Fuckin raises an error otherwise
    if (Test-Path alias:grep) { Remove-Alias grep }
    if (Test-Path alias:rm) { Remove-Alias rm }
    function grep() { C:\git\usr\bin\grep.exe $args }
}


# ls aliases: {{{

# damn i love how every time i do this i use a slightly different syntax lol
if ( Test-Path alias:ls ) { Remove-Item alias:ls -Force }
function ls() { C:\git\usr\bin\ls.exe -Fh --color=always $args }

function l() {  ls -FC --color=always $args }
function la() { ls -AFh --color=always $args }
function ldir() { ls -Fhpo $args | grep /$ }
function lf() { ls -Foh $args | grep ^- }
function ll() { ls -FAgh --color=always $args }
function lr() { ls -Altcr --color=always $args }
function lt() { ls -Altc --color=always $args }
function lx() { ls -Fo --color=always $args | grep ^-..x }

if ( Test-Path alias:mkdir ) { Remove-Item alias:mkdir -Force }

function mkdir() { C:\git\usr\bin\mkdir.exe $args }
# Huh how do we do this part right
function mk() { mkdir -pv $args ; cd $args }

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
function gds2() { git.exe diff --stat --staged -- $args }
function gdw() { git.exe diff --word-diff -- $args }
function gdsw() { git.exe diff --cached --word-diff -- $args }

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

# Basic Options: {{{
# https://github.com/PowerShell/PSReadLine#post-installation
# According to MSFT themselves, use this syntax in profile.ps1 and you only
# need Import-Module PSReadLine in the Microsoft.Powershell.ps1 file

Import-Module PSReadline
# I know I know. Hey at least the fucking tab key works now!
Set-PSReadlineOption -EditMode Emacs

# 06/11/201
Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -HistorySearchCursorMovesToEnd

# Let's setup better history searching:
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
# Yo also Ctrl-Space never works for me. So I'm gonna put what Alt-= used to be
# Set-PSReadLineKeyHandler -Key Ctrl+SPACEBAR -Function PossibleCompletions

Set-PSReadlineOption -ExtraPromptLineCount 1

# To enable bash style completion without using Emacs mode, you can use::
# Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Except for the fact that it raises an error all the time
Set-PSReadlineKeyHandler -Key Tab -Function PossibleCompletions

# In Emacs mode - Tab acts like in bash, but the Windows style completion
# is still useful sometimes, so bind some keys so we can do both
Set-PSReadLineKeyHandler -Key Ctrl+Q -Function TabCompleteNext
Set-PSReadLineKeyHandler -Key Ctrl+Shift+Q -Function TabCompletePrevious

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
# In Emacs mode - Tab acts like in bash, but the Windows style completion
# is still useful sometimes, so bind some keys so we can do both
Set-PSReadlineKeyHandler -Key Ctrl+Q -Function TabCompleteNext
Set-PSReadlineKeyHandler -Key Ctrl+Shift+Q -Function TabCompletePrevious

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

#   NOTE: You can't combine --files and a regexp. Here's the old regexp
#
# -e ^.+$
# TODO: Binds really aren't working

if (Test-Path $env\FZF_DEFAULT_COMMAND -IsValid){  # {{{FZF Env vars

    # $env:FZF_DEFAULT_COMMAND = 'rg --hidden --color=ansi --follow --no-messages --no-heading --smart-case --no-filename --glob "!.git/*" -g "!**node_modules/**" --passthru --max-depth 10 --max-count 2 --max-columns 200 -C 0 --files '
    $env:FZF_DEFAULT_COMMAND = 'fd -d 6 -t f --exclude "node_modules" --exclude "*.dll" --exclude "*.mui" '

    $env:FZF_DEFAULT_OPTS = ' --multi --cycle --reverse --prompt "Query: " --tiebreak begin,length,index --ansi --filepath-word --border --header "FZF: File Browser"+"Press ? to toggle preview" --bind "?:toggle-preview" --bind "Ctrl-k:kill-line" '

# --bind change:reload 
#
    # $env:FZF_CTRL_T_COMMAND = 'rg --hidden --color=ansi  --follow --no-messages --no-heading --smart-case --files --passthru --max-depth 10 --max-count 20 --max-columns 200 -C 0 --glob "!.git/* -g "!**node_modules/**" . '
    $env:FZF_CTRL_T_COMMAND = 'fd --follow -d 6 -t f --hidden --exclude "node_modules" --exclude "*.dll" --exclude "*.mui" '
    $env:FZF_CTRL_T_OPTS = ' --tiebreak begin,length,index --filepath-word --multi --cycle --border --reverse --preview-window=right:60%:wrap --preview "less -RrFJKLMN {}" --ansi --bind "?:toggle-preview" --header "FZF: File Browser: Press ? to toggle preview.  Alt-n to launch nvim. " --bind "alt-n:execute(nvim {}) " --bind "Ctrl-k:kill-line" '

    # $env:FZF_CTRL_R_COMMAND = "rg --hidden --color=ansi --no-heading --smart-case --no-filename --no-messages "
    $env:FZF_CTRL_R_COMMAND = 'fd --hidden '
    $env:FZF_CTRL_R_OPTS = " --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --preview 'cat {}' --preview-window=down:hidden:wrap --bind '?:toggle-preview' --header 'Press ? to toggle preview' "

    $env:FZF_ALT_C_COMMAND = "fd --type d --hidden --follow --exclude .git --color always --ignore-file $HOME/.ignore "
    $env:FZF_ALT_C_OPTS = " --cycle --ansi --tiebreak begin,length,index --no-multi --filepath-word --bind '?:toggle-preview' --header 'Press ? to toggle preview' --border --prompt 'FZF Dir Finder' --preview 'ls -lRhF --color=always {}' | head -n 200 "


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

}
_gen_fzf_default_opts  # }}}

$env:FZF_DEFAULT_OPTS = $env:FZF_DEFAULT_OPTS + $env:FZF_COLORSCHEME
$env:FZF_CTRL_R_OPTS = $env:FZF_CTRL_R_OPTS + $env:FZF_COLORSCHEME
$env:FZF_CTRL_T_OPTS = $env:FZF_CTRL_T_OPTS + $env:FZF_COLORSCHEME
$env:FZF_ALT_C_OPTS = $env:FZF_ALT_C_OPTS + $env:FZF_COLORSCHEME

# Utilizing the PSFzf API: {{{

# Remove-PSReadlineKeyHandler Ctrl-r

# this is needed because he aliases fzf to fd but i have fd-find
if ( Test-Path alias:fd ) { Remove-Item alias:fd -Force }

# I guess this depends on importing PsFzf succesfully lol
function fcd() { cd (gci -Recurse | where {$_.PSIsContainer} | Invoke-FuzzySetLocation) }

# Yo don't use his argument list let's just utilize a little powershell and we'll get there
Remove-PSReadlineKeyHandler Ctrl-t
# }}}

# Invoke-FuzzyEdit: {{{
Set-PSReadlineKeyHandler -Key Ctrl-t `
                    -BriefDescription Invoke-FuzzyEdit `
                    -LongDescription "Use FZF to preview files and edit with nvim." `
                    -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadline]::cd (gci -Recurse | where {$_.PSIsContainer} | Invoke-Fzf)
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

# Btw what is ghq?: {{{
Set-PSReadlineKeyHandler -Chord 'Ctrl+x,p' `
-BriefDesription "fzf to...." `
-Description "Honestly don't know what ghq is" `
-ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadline]::Insert("cd $(ghq list -p | fzf.exe)")
    [Microsoft.PowerShell.PSConsoleReadline]::AcceptLine()
} # }}}

# }}}

# PSCX: {{{

# Dude holy fuck these are good
Import-Module pscx

# You now have shit like `get-clipboard` and other goodies. Also importing
# it add their dir to the path and they have less and lesskey inexplicably
# in their `Apps`
# }}}

# Env vars: {{{

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
}   # }}}

# Other: {{{

# Holy cow do i need more. I realize that i typically set these in the GUI
# but none of these were set!

$env:TERM='cygwin'

$env:EDITOR='nvim-qt'

$env:VISUAL='nvim-qt'

$env:PAGER='less -RfrJKLN'

$env:PYTHONASYNCIODEBUG=1
$env:PYTHONDONTWRITEBYTECODE=1
$env:NPY_DISTUTILS_APPEND_FLAGS=1
$env:PYTHONDOCS="$HOME/python/official-python-docs/3.7/library/build/html"
$env:PYTHONIOENCODING='utf-8:surrogateescape'
$env:IPYTHONDIR="$HOME/.ipython"
$env:PYTHONCOERCECLOCALE="warn"
$env:PYTHONUNBUFFERED=0
$env:SHELLCHECKOPTS='--shell=bash -X --exclude=SC2016'
$env:RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
$env:LESSHISTSIZE=5000
$env:LESSCOLORIZER="pygmentize"
$env:NODE_PRESERVE_SYMLINKS=1

$env:NODE_REPL_HISTORY="$HOME/AppData/Local/node_log.js"

 # $env:SHELL = 'pwsh'
$env:CONEMU_ANSI = 'ON'

Write-Output "Success: Sourced Documents/PowerShell/profile.ps1"
# }}}

# }}}

# Vim: set ff=dos fdls=0 fdm=marker: