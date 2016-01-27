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
  "registered_users" : "2343"
])

//localize keys with values
statsview.localizeKeys([
  "name" : "Application name",
  "registered_users : "Registered Users"
])
```

Then, present it like a normal view controller.
