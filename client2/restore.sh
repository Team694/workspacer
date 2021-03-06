# Runs as guest user

sshcmd="ssh robotics-entry@localhost"
round2path="/home/students/2019/robotics/round2"

echo "Hello! You will be logging in and getting you work from last time."

echo "Hit Ctrl-C at any point to exit."

existing_users=$(cat ~/.robo-user-list)

tab(){
    if [[ -n $READLINE_LINE ]]; then
        options=$(compgen -W "${existing_users}" -- ${READLINE_LINE} | tr "\n" " " | sed "s/\s\+$//")
        if [[ $(echo "$options" | wc -w) -eq 1 ]]; then
            READLINE_LINE=$options
            READLINE_POINT="${#READLINE_LINE}"
        else
            echo -ne "Suggestions: $options\n"
        fi
    fi
}
# Bind tab to tab-complete, and space to no-op
set -o emacs
nospaces="No spaces in username\n"
bind -x "\" \":'echo -en \"$nospaces\"'"
bind -x '"\t":"tab"' # Tab-complete
bind -r "\C-V" # By default, C-V allows literal insertion of chars
read -rep "Username: " uname # -e means use GNU Readline

uname=$(echo "$uname" | tr '[:upper:]' '[:lower:]')

if [[ $($sshcmd $round2path/isUserTaken) -ne "taken" ]]; then
    echo "There is no user named \"$uname\"."
    exit 1
fi

read -rsp "Password: " pass

echo ""

workspacedir="$HOME/workspace"

output=$($sshcmd "cd $round2path && ./checkCredentials \"$uname\" \"$pass\"")

if [[ "$output" == invalid ]]; then
    echo "Username and password did not match."
elif [[ "$output" == success ]]; then
    $sshcmd "cd $round2path/their-work && tar cf - $uname" | tar xf -

    mv $uname workspace

    # Update `/var/tmp/robo-user-homedir`. Note: this must be done
    # as user robotics-entry so the file isn't owned by old guest sessions.
    $sshcmd "echo $HOME > /var/tmp/robo-user-homedir"

    echo "Logged you in!"
    echo -e "\nType\n  cd workspace\nto enter your workspace"
else
    echo "An unknown error has occured. Try again, or ask an older member for help."
fi
