echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
git add .
git commit -m "Cambios"
git push origin master
#aws s3 sync . s3://ecs-templates-elmer
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"