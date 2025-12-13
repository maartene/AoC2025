import Foundation
import Shared

@main
struct Day12 {
    static func main() {
        let result = numberOfFittingConfigurations(in: input)
        print(result)
    }
}


func numberOfFittingConfigurations(in input: String) -> Int {
    let lines = input.split(separator: "\n")
    
    let situations = lines.filter { $0.contains("x") }
    
    var result = 0
    for situation in situations {
        let parts = situation.split(separator: ":")
        let sizeStrings = parts[0].split(separator: "x")
        let size1 = Int(sizeStrings[0])!
        let size2 = Int(sizeStrings[1])!
        
        let presentsStrings = parts[1].split(separator: " ")
        let presentCounts = presentsStrings.compactMap {
            Int(String($0))
        }
        let presentCount = presentCounts.reduce(0, +)
        
        if presentCount * 9 <= size1 * size2 {
            result += 1
        }
    }
    
    return result
    
}
