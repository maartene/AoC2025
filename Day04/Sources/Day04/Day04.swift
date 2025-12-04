import Shared

func numberOfAccessibleRolls(in input: String) -> Int {
    var rolls = Set<Vector>()
    let matrix = convertInputToMatrixOfCharacters(input)
    for row in 0 ..< matrix.count {
        for column in 0 ..< matrix[row].count {
            if matrix[row][column] == "@" {
                rolls.insert(Vector(x: column, y: row))
            }
        }
    }
    
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

extension Vector {
    static var neighbours8: [Vector] {
        [
            Vector(x: 0, y: 1),
            Vector(x: 1, y: 0),
            Vector(x: -1, y: 0),
            Vector(x: 0, y: -1),
            Vector(x: 1, y: 1),
            Vector(x: -1, y: -1),
            Vector(x: -1, y: 1),
            Vector(x: 1, y: -1),
        ]
    }
    
    var neighbours8: [Vector] {
        Vector.neighbours8.map {
            $0 + self
        }
    }
}
