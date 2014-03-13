#enables color in the terminal bash shell export
CLICOLOR=1
#sets up the color scheme for list export
LSCOLORS=gxfxcxdxbxegedabagacad
#sets up the prompt color (currently a green similar to linux terminal)
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
#enables color for iTerm
#export TERM=xterm-color
export ANDROID_HOME=~/android/android-sdk-macosx
export ANDROID_SDK_HOME=~/android/android-sdk-macosx
export PATH=/usr/local/bin:$ANDROID_SDK_HOME/platform-tools:~/bin:$PATH

#sets up proper alias commands when called
alias ls='ls -G'
alias ll='ls -ahGl'

echo Ctrl-a    Move to \<Start\> of the line
echo Ctrl-e    Move to \<End\> of the line
echo Ctrl-k    Delete from cursor to \<End\> of line \(vim D\)
echo Ctrl-u    Delete from cursor to \<Start\> of line
echo Meta-f    Jump forward 1 word
echo Meta-b    Jump backward 1 word
echo Ctrl-d    Delete char
echo Meta-d    Delete next word
echo Meta-DEL  Delete previous word

function mountAndroid { hdiutil attach ~/android.dmg -mountpoint /Volumes/android; }
ulimit -S -n 1024

function title {
    if [ -z "$1" ]; then
        echo "No parameter given"
    else
        echo -n -e "\033];$1\007"
    fi
}

# API Helpers
alias jr='curl -s -k -X POST --data-urlencode'
alias pt='python -mjson.tool'
# Example 
# jr "json={'username'='a', 'password'='b'}" http://127.0.0.1/getJsonValue

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

. ~/.bash_aliases
. ~/.bashmc
