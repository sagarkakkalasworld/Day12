#!/bin/bash
cd /home/ubuntu/bashscripts/Day12/react-helmcharts/
aws s3 cp s3://gitcommittagbucket/old_value.txt .
aws s3 cp s3://gitcommittagbucket/new_value.txt .
old_value=$(cat old_value.txt)
new_value=$(cat new_value.txt)
sed -i "s/${old_value}/${new_value}/g" values.yaml
git add .
git commit -m "${new_value} is updated"
git push https://$GIT_TOKEN@github.com/sagarkakkalasworld/Day12.git
aws s3 rm s3://gitcommittagbucket/old_value.txt
echo $new_value > old_value.txt
aws s3 cp old_value.txt s3://gitcommittagbucket/
rm old_value.txt new_value.txt
helm upgrade react-helmcharts .

