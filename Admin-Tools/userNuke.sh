#/bin/bash
while read p; do
  passwd $p -l # lock the users password
  usermod --expiredate 1 $p # expire the users password
  deluser $p sudo # remove the user from the sudo group (if in that group)
  deluser $p root # remove the user from the root group (if in that group)
done < users.txt