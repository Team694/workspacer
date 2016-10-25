# Runs as guest user

echo "Hello! You will be making a new user."

echo "Hit Ctrl-C at any point to exit."

echo -n "Username: "

read uname

HOSTNAME=localhost
sshcmd="ssh robotics-entry@${HOSTNAME}"

round2path="/home/students/2019/robotics/round2"

if [[ $($sshcmd $round2path/isUserTaken) == "taken" ]]; then
    echo "That username is taken!"
    exit 1
fi

echo -n "Password: "

read -s pass1

echo ""

echo -n "Confirm password: "

read -s pass2

echo ""

if [[ "$pass1" == "$pass2" ]]; then
    if [[ $($sshcmd "cd $round2path; ./addUser \"$uname\" \"$pass1\"") == failure ]]; then
        echo "User creation failed! Try again"
    else
        echo "Created your user!"

	# Copy default workspace to home directory:
        ssh "robotics-entry@${HOSTNAME}" "cd $round2path; tar cf - workspace-template" | tar xf -
        mv workspace-template workspace
        chmod +r ~/workspace

	# Save default workspace to their-work:
        ssh "robotics-entry@${HOSTNAME}" "cd $round2path && cp -r workspace-template their-work/$uname"

        echo -e "Type\n  cd workspace\nto enter your workspace"
    fi
else
    echo "Passwords did not match! Try again. You can press up arrow to repeat the last command."
fi