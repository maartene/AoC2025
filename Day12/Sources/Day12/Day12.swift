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
    let situations = input.split(separator: "\n")
        .filter { $0.contains("x") }
        .map { String($0) }
    
    var result = 0
    for situation in situations {
        var ints = extractIntsFromString(situation)
        let size = ints[0] * ints[1]
        
        ints = Array(ints.dropFirst(2))
        let presentCount = ints.reduce(0, +)
        
        if presentCount * 9 <= size {
            result += 1
        }
    }
    
    return result
    
}
