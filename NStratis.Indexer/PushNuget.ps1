del *.nupkg 
nuGet pack NStratis.Indexer.csproj -Build -Properties Configuration=Release -Properties GitLink=True -includereferencedprojects
forfiles /m *.nupkg /c "cmd /c NuGet.exe push @FILE -source https://api.nuget.org/v3/index.json"
(((dir *.nupkg).Name) -match "[0-9]+?\.[0-9]+?\.[0-9]+?\.[0-9]+")
$ver = $Matches.Item(0)
git tag -a "v$ver" -m "$ver"
git push --tags

#msbuild.exe ../Build/Build.csproj /p:Configuration=Release
#msbuild.exe ../NStratis.Indexer.Console/NStratis.Indexer.Console.csproj /p:Configuration=Release
#xcopy /Y ..\NStratis.Indexer.Console\EmptyLocalSettings.config ..\NStratis.Indexer.Console\bin\Release\LocalSettings.config
#msbuild.exe ../Build/DeployClient.proj
#xcopy /Y ..\NStratis.Indexer.Console\LocalSettings.config ..\NStratis.Indexer.Console\bin\Release\LocalSettings.config