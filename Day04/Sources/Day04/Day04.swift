import Shared

func numberOfAccessibleRolls(in input: String) -> Int {
    let rolls = getRollsFromInput(input)
    
    var count = 0
    for roll in rolls {
        let neighbours = roll.neighbours8
        let neighbourCount = neighbours.count(where: { rolls.contains($0) })
        
        if neighbourCount < 4 {
            count += 1
        }
    }
    
    return count
}

private func getRollsFromInput(_ input: String) -> Set<Vector> {
    var rolls = Set<Vector>()
    let matrix = convertInputToMatrixOfCharacters(input)
    for row in 0 ..< matrix.count {
        for column in 0 ..< matrix[row].count {
            if matrix[row][column] == "@" {
                rolls.insert(Vector(x: column, y: row))
            }
        }
    }
    return rolls
}
