//Delete this file if not using SwiftyJSON
import SwiftyJSON

extension KeyValueViewer {
    ///Replaces keys with specified values in a SwiftyJSON dictionary.
    ///Can be used to localize data structures.
    func localizeKeys(json: JSON){
        for (key,value):(String, JSON) in json {
            for item in data {
                if item.key == key {
                    item.key = value.stringValue
                }
            }
        }
        self.sort()
    }

    ///Sets the keys using a SwiftyJSON dictionary.
    ///Orders them alphabetically by key.
    func setDictionary(json: JSON){
        for (key,value):(String, JSON) in json {
            data.append(KeyValuePair(key: key, value: value.stringValue))
        }
        self.sort()
    }

}
