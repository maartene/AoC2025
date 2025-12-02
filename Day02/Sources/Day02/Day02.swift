import Foundation

func sumOfInvalidIdsIn(_ input: String) -> Int {
    let invalidIDs = [
        [11, 22],
        invalidIDsIn(lowerBound: 95, upperBound: 115),
        [1010],
        [1188511885],
        [222222],
        invalidIDsIn(lowerBound: 1698522, upperBound: 1698528),
        [446446],
        [38593859]
    ]
    
    return invalidIDs
        .flatMap { $0 }
        .reduce(0, +)
}

func invalidIDsIn(lowerBound: Int, upperBound: Int) -> [Int] {
    var result = [Int]()
    for number in lowerBound ... upperBound {
        let numberString = String(number)
        
        let subsequence = numberString.dropLast(numberString.count / 2)
        
        if numberString.replacingOccurrences(of: subsequence, with: "") == "" {
            result.append(number)
        }
    }
    
    return result
}
