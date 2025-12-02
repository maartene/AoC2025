import Foundation

func sumOfInvalidIdsIn(_ input: String, using checker: (ClosedRange<Int>) -> [Int]) -> Int {
    let invalidIDs = inputToRanges(input)
        .map {
            checker($0)
        }
    
    return invalidIDs
        .flatMap { $0 }
        .reduce(0, +)
}

func part1(_ input: String) -> Int {
    sumOfInvalidIdsIn(input, using: invalidIDsInOneRepeatOnly)
}

func invalidIDsInOneRepeatOnly(_ range: ClosedRange<Int>) -> [Int] {
    var result = [Int]()
    for number in range.lowerBound ... range.upperBound {
        let numberString = String(number)
        
        if numberString.count % 2 > 0 {
            continue
        }
        
        let subsequence = numberString.dropLast(numberString.count / 2)
        
        if numberString.replacingOccurrences(of: subsequence, with: "aa") == "aaaa" {
            result.append(number)
        }
    }
    return result
}

// MARK: Part 2
func part2(_ input: String) -> Int {
    sumOfInvalidIdsIn(input, using: invalidIDsAllowingMultipleRepeats)
}

func invalidIDsAllowingMultipleRepeats(_ range: ClosedRange<Int>) -> [Int] {
    var result = [Int]()
    for number in range.lowerBound ... range.upperBound {
        result.append(contentsOf: invalidIDsInNumber(number))
    }
    return result
}

private func invalidIDsInNumber(_ number: Int) -> Set<Int> {
    let numberString = String(number)
    guard numberString.count > 1 else {
        return []
    }
    
    var result = Set<Int>()
    let maxSubSequenceLength = numberString.count / 2
    
    for subSequenceLength in 1...maxSubSequenceLength {
        if numberString.count % subSequenceLength > 0 {
            continue
        }
        
        let subsequence = String(numberString.prefix(subSequenceLength))
        
        let matches = numberString.replacingOccurrences(of: subsequence, with: "a")
        
        if matches == String(repeating: "a", count: numberString.count / subSequenceLength) {
            result.insert(number)
        }
    }
    
    return result
}

// MARK: Utils
private func inputToRanges(_ input: String) -> [ClosedRange<Int>] {
    let rangeStrings = input.split(separator: ",")
    var ranges: [ClosedRange<Int>] = []
    for rangeString in rangeStrings {
        let lowerBoundString = rangeString.split(separator: "-")[0]
        let upperBoundString = rangeString.split(separator: "-")[1]
        ranges.append(Int(lowerBoundString)! ... Int(upperBoundString)!)
    }
    return ranges
}
