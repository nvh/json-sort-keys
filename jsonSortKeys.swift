import Foundation
import Files // marathon:https://github.com/JohnSundell/Files.git

let arguments = CommandLine.arguments

let name = "jsonSortKeys"


guard #available(OSX 10.13, *) else {
    print("\(name) only works on macOS 10.13")
    exit(1)
}

guard arguments.count > 1 else {
    print("Usage: \(name) [filename ...]")
    exit(1)
}


if #available(OSX 10.13, *) {
    for filename in arguments[1...] {
        let file = try FileSystem().currentFolder.file(atPath: filename)
        let data = try file.read()
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        let sortedData = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .sortedKeys])
        try file.write(data: sortedData)
    }
}
