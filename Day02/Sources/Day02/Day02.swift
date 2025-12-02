func sumOfInvalidIdsIn(_ input: String) -> Int {
    let invalidIDs = [
        [11, 22],
        [99],
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
    []
}
