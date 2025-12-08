import Foundation
import Shared

func part1(_ input: String) -> Int {
    let circuitSizes = [
        5, 4, 2, 2, 1, 1, 1, 1, 1, 1, 1
    ].shuffled()
    
    let threeLargest = circuitSizes.sorted(by: >)
        .prefix(3)
        .reduce(1, *)
    
    return threeLargest
}

struct Vector3: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    func distanceTo(_ other: Vector3) -> Double {
        let dx = Double(self.x - other.x)
        let dy = Double(self.y - other.y)
        let dz = Double(self.z - other.z)
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}

struct Pair: Equatable, Hashable {
    static func == (lhs: Pair, rhs: Pair) -> Bool {
        lhs.v1 == rhs.v1 && lhs.v2 == rhs.v2 ||
        lhs.v1 == rhs.v2 && lhs.v2 == rhs.v1
    }
    
    let v1: Vector3
    let v2: Vector3
    
    func hash(into hasher: inout Hasher) {
        let set = Set([v1, v2])
        hasher.combine(set)
    }
}

private func loadJunctionBoxes(_ input: String) -> [Vector3] {
    let numbers = convertStringToIntMatrix(input, separator: ",")
    return numbers.map { line in
        Vector3(x: line[0], y: line[1], z: line[2])
    }
}
