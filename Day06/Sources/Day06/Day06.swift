// The Swift Programming Language
// https://docs.swift.org/swift-book

func sumOfMathProblems(in input: String) -> Int {
    let problems = stringToColumns(input)
    
    let answersToProblems = problems.map {
        calculateProblem($0)
    }
    
//    let answersToProblems = [
//        calculateProblem(["123", "45", "6", "*"]),
//        calculateProblem(["328", "64", "98", "+"]),
//        calculateProblem(["51", "387", "215", "*"]),
//        calculateProblem(["64", "23", "314", "+"])
//    ]
    
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

func stringToStringMatrix(_ input: String) -> [[String]] {
    let lines = input.split(separator: "\n")
    
    var result = [[String]]()
    
    for line in lines {
        let row = line.split(separator: " ")
            .map { String($0) }
        result.append(row)
    }
    
    return result
}

func stringToColumns(_ input: String) -> [[String]] {
    let stringMatrix = stringToStringMatrix(input)
    
    var result = [[String]]()
    
    for columnIndex in 0..<stringMatrix[0].count {
        var column: [String] = []
        for row in stringMatrix {
            column.append(row[columnIndex])
        }
        result.append(column)
    }
    
    print(result)
    return result
}
