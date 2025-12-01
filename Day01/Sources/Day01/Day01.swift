// The Swift Programming Language
// https://docs.swift.org/swift-book

func getNumberOfRotationsEndingOnZero(for input: String) -> Int {
    let endStates = [
        50, 82, 52, 0, 95, 55, 0, 99, 0, 14, 32
    ]
    
    return endStates.count(where: { $0 == 0 })
}
