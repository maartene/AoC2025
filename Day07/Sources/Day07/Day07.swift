import Shared

func pathAndSplitCount(in input: String) -> (pathCount: Int, splitCount: Int) {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    let startPosition = matrix[0].firstIndex { $0 == "S" }!
    
    var beamPositionsAndStrength: [Int: Int] = [startPosition: 1]
    var splitCount = 0
    
    for y in 0 ..< matrix.height {
        // zero out the updatedBeams
        var updatedBeams = beamPositionsAndStrength.reduce(into: [Int:Int]()) { partialResult, beam in
            partialResult[beam.key] = 0
        }
        
        // check what happens for each beam
        for beam in beamPositionsAndStrength {
            if matrix[y][beam.key] == "^" {
                splitCount += 1
                updatedBeams.removeValue(forKey: beam.key)
                
                updatedBeams[beam.key - 1, default: 0] += beam.value
                updatedBeams[beam.key + 1, default: 0] += beam.value
            } else {
                updatedBeams[beam.key, default: 0] += beam.value
            }
        }
        beamPositionsAndStrength = updatedBeams
    }
    
    let pathCount = beamPositionsAndStrength
        .values
        .reduce(0, +)
    
    return (pathCount, splitCount)
}
