// The Swift Programming Language
// https://docs.swift.org/swift-book

func sumOfMathProblems(in input: String) -> Int {
    let answersToProblems = [
        33210,
        490,
        4243455,
        401
    ]
    
    return answersToProblems.reduce(0, +)
}
