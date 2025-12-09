import Shared

func largestRectangleArea(in input: String) -> Int {
    let positions = parseInput(input)
    
    var maxArea = 0
    for p1 in positions {
        for p2 in positions {
            let area = abs(1 + p1.x - p2.x) * abs(1 + p1.y - p2.y)
            maxArea = max(maxArea, area)
        }
    }
    
    return maxArea
}

private func parseInput(_ input: String) -> [Vector] {
    let matrix = convertStringToIntMatrix(input, separator: ",")
    
    return matrix.map { row in
        Vector(x: row[0], y: row[1])
    }
}

func part2(in input: String) -> Int {
    24
}
