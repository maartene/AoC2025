// The Swift Programming Language
// https://docs.swift.org/swift-book

func sumOfMathProblems(in input: String) -> Int {
    let answersToProblems = [
        calculateProblem(["123", "45", "6", "*"]),
        calculateProblem(["328", "64", "98", "+"]),
        calculateProblem(["51", "387", "215", "*"]),
        calculateProblem(["64", "23", "314", "+"])
    ]
    
    return answersToProblems.reduce(0, +)
}

func calculateProblem(_ input: [String]) -> Int {
    var input = input
    
    guard let operation = input.popLast(), ["*", "+"].contains(operation) else {
        fatalError("Received unexpected operation: \(input[input.count - 1])")
    }
    
    var result = operation == "*" ? 1 : 0
    for numberString in input {
        let number = Int(numberString)!
        
        if operation == "+" {
            result += number
        } else {
            result *= number
        }
    }
    
    return result
}
