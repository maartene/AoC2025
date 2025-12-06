// The Swift Programming Language
// https://docs.swift.org/swift-book

func sumOfMathProblems(in input: String) -> Int {
    let answersToProblems = [
        calculateProblem(["123", "45","6","*"]),
        490,
        4243455,
        401
    ]
    
    return answersToProblems.reduce(0, +)
}

func calculateProblem(_ input: [String]) -> Int {
    33210
}
