#!/bin/bash
mapfile -t lines < <(git ls-files --others --exclude-standard)
untracked_files=$(git ls-files --others --exclude-standard | wc -l)
sleep_seconds=5
stage_size=500
commit_batch_counter=1
while [ $untracked_files -gt 0 ]
do
   echo "number of untracked files remaining...${untracked_files}"
   echo "staging ${commit_size} files"
   git add "${lines[@]:0:${stage_size}}"
   
   echo "comitting batch ${commit_batch_counter}"
   git commit -m "initial commit batch ${commit_batch_counter}"
   
   echo "pusing commit batch ${commit_batch_counter}"
   
   git push --no-verify origin main
   
   
   
   commit_batch_counter=$(( $commit_batch_counter + 1 ))
   mapfile -t lines < <(git ls-files --others --exclude-standard)
   
   echo "Sleeping for ${sleep_seconds}"
   sleep $sleep_seconds
done
echo "$factorial"