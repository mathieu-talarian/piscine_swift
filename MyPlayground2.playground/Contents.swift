import UIKit

var str = "Hello, playground"

let q = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
print(q)
