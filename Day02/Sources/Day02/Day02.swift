import Foundation

func sumOfInvalidIdsIn(_ input: String) -> Int {
    let rangeStrings = input.split(separator: ",")
    var ranges: [(lowerBound: Int, upperBound: Int)] = []
    for rangeString in rangeStrings {
        let lowerBoundString = rangeString.split(separator: "-")[0]
        let upperBoundString = rangeString.split(separator: "-")[1]
        ranges.append((Int(lowerBoundString)!, Int(upperBoundString)!))
    }
    
    let invalidIDs = ranges.map {
        invalidIDsIn($0.lowerBound ... $0.upperBound)
    }
    
    return invalidIDs
        .flatMap { $0 }
        .reduce(0, +)
}

func invalidIDsIn(_ range: ClosedRange<Int>) -> [Int] {
    var result = [Int]()
    for number in range.lowerBound ... range.upperBound {
        let numberString = String(number)
        
        let subsequence = numberString.dropLast(numberString.count / 2)
        
        if numberString.replacingOccurrences(of: subsequence, with: "aa") == "aaaa" {
            result.append(number)
        }
    }
    return result
}

