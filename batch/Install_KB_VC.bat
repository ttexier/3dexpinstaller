:: install KB & VC
echo Windows update required KB installation
wusa.exe %app%\Prereqs\WinKB\Windows8.1-KB2919355-x64.msu /quiet /norestart
wusa.exe %app%\Prereqs\WinKB\Windows8.1-KB2919442-x64.msu /quiet /norestart
wusa.exe %app%\Prereqs\WinKB\Windows8.1-KB2932046-x64.msu /quiet /norestart
wusa.exe %app%\Prereqs\WinKB\Windows8.1-KB2934018-x64.msu /quiet /norestart
wusa.exe %app%\Prereqs\WinKB\Windows8.1-KB2937592-x64.msu /quiet /norestart
wusa.exe %app%\Prereqs\WinKB\Windows8.1-KB2938439-x64.msu /quiet /norestart
%app%\Prereqs\vcredist_x64.exe /q /norestart - quiet mode
%app%\Prereqs\vcredist_x86.exe /q /norestart - quiet mode
%app%\Prereqs\vc_redist.x64.exe /install /passive /norestart