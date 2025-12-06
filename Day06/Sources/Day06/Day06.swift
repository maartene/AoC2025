import Shared

func sumOfMathProblems(in input: String) -> Int {
    let problems = stringToColumns(input)
    
    let answersToProblems = problems.map {
        calculateProblem($0)
    }
    
    return answersToProblems.reduce(0, +)
}

func sumOfMathProblemsRightToLeft(in input: String) -> Int {
    let problems = readProblemsRightToLeft(input)
    
    let answersToProblems = problems.map {
        calculateProblem($0)
    }
    
    return answersToProblems.reduce(0, +)
}

func calculateProblem(_ input: [String]) -> Int {
    var input = input
    
    guard let operation = input.popLast(), ["*", "+"].contains(operation) else {
        fatalError("Received unexpected operation: \(input[input.count - 1])")
    }
    
    var result = operation == "*" ? 1 : 0
    for numberString in input where numberString != "" {
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
    
    return result
}

func readProblemsRightToLeft(_ input: String) -> [[String]] {
    let matrix = convertInputToMatrixOfCharacters(input)
    
    var problems = [[String]]()
    var problem = [String]()
    for columnIndexReversed in 0..<matrix[0].count {
        let columnIndex = matrix[0].count - 1 - columnIndexReversed
        var column = ""
        for rowIndex in 0..<matrix.count {
            let character = String(matrix[rowIndex][columnIndex])
            switch character {
            case " ":
                problem.append(column)
                column = ""
            case "*":
                problem.append(column)
                column = ""
                problem.append(character)
                problems.append(problem)
                problem = []
            case "+":
                problem.append(column)
                column = ""
                problem.append(character)
                problems.append(problem)
                problem = []
            default:
                column += character
            }
        }
    }
    
    return problems
}
