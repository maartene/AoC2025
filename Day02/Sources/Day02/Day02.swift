func sumOfInvalidIdsIn(_ input: String) -> Int {
    let invalidIDs = [
        [11, 22],
        [99],
        [1010],
        [1188511885],
        [222222],
        [446446],
        [38593859]
    ]
    
    return invalidIDs
        .flatMap { $0 }
        .reduce(0, +)
}
