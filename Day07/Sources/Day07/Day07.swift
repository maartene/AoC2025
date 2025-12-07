import Shared

func splitCount(in input: String) -> Int {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    
    var splitCount = 0
    let start = matrix[0].firstIndex { $0 == "S" }!
    
    var beams: Set<Int> = [start]
    
    for y in 0 ..< matrix.height {
        var updatedBeams = beams
        for beam in beams {
            if matrix[y][beam] == "^" {
                updatedBeams.remove(beam)
                splitCount += 1
                
                if updatedBeams.contains(beam - 1) == false {
                    updatedBeams.insert(beam - 1)
                }
                
                if updatedBeams.contains(beam + 1) == false {
                    updatedBeams.insert(beam + 1)
                }
            }
        }
        beams = updatedBeams
    }
    
    return splitCount
}
