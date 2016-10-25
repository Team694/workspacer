if [ -z $1 ]; then
    echo "No arguments given. First argument must be path to the edu-workspace directory to be created and populated"
    exit 1
fi
if [ -z $2 ]; then
    echo "Only one argument given. Second argument must be username"
    exit 1
fi

cp -r ./workspace-template $1

ln -s /var/tmp/workspacer/lib $1/lib