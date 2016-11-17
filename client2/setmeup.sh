# Give them today's ssh keys
rm -rf ~/.ssh.bak
if [[ -d ~/.ssh ]]; then
    mv ~/.ssh ~/.ssh.bak
fi
cp -r /var/tmp/robo/.ssh ~/.ssh
chmod go-r ~/.ssh/id_rsa

# Mwa ha haa! No this is just so we can save their work later:
chmod o+rx ~


echo "alias make-user='/var/tmp/robo/make-user.sh'" >> ~/.bash_aliases
echo "alias save='/var/tmp/robo/save.sh'" >> ~/.bash_aliases
echo "alias login='/var/tmp/robo/restore.sh'" >> ~/.bash_aliases

round2path=/home/students/2019/robotics/round2
ssh robotics-entry@localhost "ls $round2path/their-work" > ~/.robo-user-list
