# Is run by saveWork through bash, so euid is reset to uid
workspacedir=$1
uname=$2

#if [ ! -d "$workspacedir" ]; then
#    echo "First argument is not a directory: $workspacedir"
#    exit 1
#fi

rm -rf "their-work/$uname"
cp -r $1 "their-work/$uname"
chmod -R g+rw "their-work/$uname"
chown -R :robogroup "their-work/$uname"
