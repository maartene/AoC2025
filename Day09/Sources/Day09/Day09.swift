import Shared

@main
struct Day09 {
    static func main() {
        let redCarpetTiles = parseInput(input)
        let greenCarpetTiles = getGreenCarpetPositions(from: redCarpetTiles, startPoint: Vector(x: 80000, y: 40000))
        print(greenCarpetTiles.count)
    }
}

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

func parseInput(_ input: String) -> [Vector] {
    let matrix = convertStringToIntMatrix(input, separator: ",")
    
    return matrix.map { row in
        Vector(x: row[0], y: row[1])
    }
}

func part2(in input: String, startPoint: Vector) -> Int {
    let redCarpetPositions = parseInput(input)
    let greenCarpetPositions = getGreenCarpetPositions(from: redCarpetPositions, startPoint: startPoint)
    
    var maxArea = 0
    for p1 in redCarpetPositions {
        for p2 in redCarpetPositions {
            if testInnerRectangleArea(p1: p1, p2: p2, redCarpetPositions: redCarpetPositions, greenCarpetPositions: greenCarpetPositions) {
                let area = abs(1 + p1.x - p2.x) * abs(1 + p1.y - p2.y)
                if area > maxArea {
                    maxArea = area
                    print("New maximum: \(maxArea) for coordinated: \(p1) and \(p2)")
                }
            }
        }
    }
    
    return maxArea
}

func testInnerRectangleArea(p1: Vector, p2: Vector, redCarpetPositions: [Vector], greenCarpetPositions: Set<Vector>) -> Bool {
    
    var rectangeCoordinates = Set<Vector>()
    for row in min(p1.y, p2.y) ... max(p1.y, p2.y) {
        for col in min(p1.x, p2.x) ... max(p1.x, p2.x) {
            rectangeCoordinates.insert(Vector(x: col, y: row))
        }
    }
    
    // all the other ones should be fully red or fully green. i.e. don't overlap
    return rectangeCoordinates.allSatisfy { coordinate in
        redCarpetPositions.contains(coordinate) || greenCarpetPositions.contains(coordinate)
    }
}

func getGreenCarpetPositions(from redCarpetPositions: [Vector], startPoint: Vector) -> Set<Vector> {
    var result = Set<Vector>()
    for i in 0 ..< redCarpetPositions.count {
        let p1 = redCarpetPositions[i]
        let p2 = redCarpetPositions[(i + 1) % redCarpetPositions.count]
        
        if p1.x == p2.x {
            // connect horizontally
            for y in min(p1.y, p2.y) ... max(p1.y, p2.y) {
                result.insert(Vector(x: p1.x, y: y))
            }
        } else {
            // connect vertically
            for x in min(p1.x, p2.x) ... max(p1.x, p2.x) {
                result.insert(Vector(x: x, y: p1.y))
            }
        }
    }
    
    // find point within polygon
    let minX = redCarpetPositions.map { $0.x }.min()!
    let minY = redCarpetPositions.map { $0.y }.min()!
    let maxX = redCarpetPositions.map { $0.x }.max()!
    let maxY = redCarpetPositions.map { $0.y }.max()!
    
    // flood fill rest of polygon
    var fill: Set = [startPoint]
    while let point = fill.popFirst() {
        result.insert(point)
        let neighbours = point.neighbours
            .filter {
                $0.x >= minX && $0.x <= maxX && $0.y >= minY && $0.y <= maxY
            }
            .filter { result.contains($0) == false }
        
        fill = fill.union(neighbours)
    }
    printCarpets(carpetPositions: result)
        
    return result
}

func isWithinPolygon(_ testPoint: Vector, polygon: [Vector], maxX: Int) -> Bool {
    var count = 0
    for _ in testPoint.x ... maxX {
        if polygon.contains(testPoint) {
            count += 1
        }
    }
    return count.isMultiple(of: 2) == false
}

func printCarpets(carpetPositions: Set<Vector>) {
    for y in 0 ..< 16 {
        var line = ""
        for x in 0 ..< 24 {
            line += carpetPositions.contains(Vector(x: x, y: y)) ? "#" : "."
        }
        print(line)
    }
}
