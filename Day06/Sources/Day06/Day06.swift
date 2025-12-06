import Shared

func sumOfMathProblems(in input: String) -> Int {
    Matrix<String>.makeStringMatrix(from: input)
        .transposed()
        .rows
        .map {
            calculateProblem($0)
        }
        .reduce(0, +)
}

func sumOfMathProblemsRightToLeft(in input: String) -> Int {
    readProblemsRightToLeft(input)
        .map {
            calculateProblem($0)
        }
        .reduce(0, +)
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

func readProblemsRightToLeft(_ input: String) -> [[String]] {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    
    var problems = [[String]]()
    var problem = [String]()
    for columnIndexReversed in 0..<matrix.width {
        let columnIndex = matrix.width - 1 - columnIndexReversed
        var column = ""
        for rowIndex in 0..<matrix.height {
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
        .map { problem in
            problem.filter { $0 != "" }
        }
}
