# keyvalue-swift
A TableViewController that can display a dictionary of keys and values

Initializing an instance
```swift 
let vc =  KeyValueViewer();
```

Setting Dictionary and localizing
```swift
//set a dictionary of keys and values
vc.setDictionary([
  "name" : "Hello World",
  "version" : "1.0",
  "users_registered" : "2343",
  "users_active" : "100",
  "other_metric" : "false"
])

//localize keys with values
statsview.localizeKeys([
  "name" : "Application name",
  "version" : "Application version",
  "registered_users : "Registered Users",
  "users_active" : "Active Users",
  "other_metric" : "Something else"
])


//Sort by keys, creating table view sections. All items will be present in an "All Items" section at the bottom.
statsview.sortBySections([
  "App" : ["name", "version"],
  "Users" : ["users_.*"],
  "Other" : ["other_.*"]
])

```

Then, present it like a normal view controller.
