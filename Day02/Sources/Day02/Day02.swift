import Foundation

// MARK: Part 1
func part1(_ input: String) -> Int {
    sumOfInvalidIdsIn(input, using: invalidIDsOneRepeatOnly)
}

func invalidIDsOneRepeatOnly(in range: ClosedRange<Int>) -> [Int] {
    return range.filter {
        checkNumber($0)
    }
    
    func checkNumber(_ number: Int) -> Bool {
        let numberString = String(number)
        
        guard numberString.count.isMultiple(of: 2) else {
            return false
        }
        
        let subsequence = numberString.dropLast(numberString.count / 2)
        
        return numberString.replacingOccurrences(of: subsequence, with: "aa") == "aaaa"
    }
}

// MARK: Part 2
func part2(_ input: String) -> Int {
    sumOfInvalidIdsIn(input, using: invalidIDsAllowingMultipleRepeats)
}

func invalidIDsAllowingMultipleRepeats(in range: ClosedRange<Int>) -> [Int] {
    return range.reduce(into: [Int]()) { result, number in
        result.append(contentsOf: invalidIDsInNumber(number))
    }
    
    func invalidIDsInNumber(_ number: Int) -> Set<Int> {
        let numberString = String(number)
        let maxSubSequenceLength = numberString.count / 2
        
        guard numberString.count > 1 else {
            return []
        }
        
        return (1 ... maxSubSequenceLength).reduce(into: Set<Int>()) { result, subSequenceLength in
            if checkNumberString(numberString, subSequenceLength: subSequenceLength) {
                result.insert(number)
            }
        }
    }
    
    func checkNumberString(_ numberString: String, subSequenceLength: Int) -> Bool {
        guard numberString.count.isMultiple(of: subSequenceLength) else {
            return false
        }
        
        let subsequence = String(numberString.prefix(subSequenceLength))
        
        let matches = numberString.replacingOccurrences(of: subsequence, with: "a")
        
        return matches == String(repeating: "a", count: numberString.count / subSequenceLength)
    }
}

// MARK: Common
private func sumOfInvalidIdsIn(_ input: String, using checker: (ClosedRange<Int>) -> [Int]) -> Int {
    let invalidIDs = inputToRanges(input)
        .map {
            checker($0)
        }
    
    return invalidIDs
        .flatMap { $0 }
        .reduce(0, +)
}

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
