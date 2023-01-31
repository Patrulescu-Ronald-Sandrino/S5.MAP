!!! remember to update the database password in appsettings.json

```
dotnet ef migrations add InitialMigration
git update-index --assume-unchanged appsettings.json
# put password
dotnet ef database update
```
