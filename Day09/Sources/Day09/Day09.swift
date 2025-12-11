import Shared

@main
struct Day09 {
    static func main() {
        let area = part2(in: input)
        print(area)
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

struct Square {
    let minX: Int
    let maxX: Int
    let minY: Int
    let maxY: Int
    
    func isLineCrossing(_ line: Square) -> Bool {
        if line.maxX - line.minX == 0 {
            if minX < line.minX && line.maxX < maxX {
                // check if the x coordinate is between the bounds of the square
                return minY < line.maxY && maxY > line.minY
                // does the line cross the square on the y?
            }
        } else {
            if minY < line.minY && line.maxY < maxY {
                // check if the y coordinate is between the bounds of the square
                return minX < line.maxX && maxX > line.minX
                // does the line cross the square on the x?
            }
        }
        return false
    }
    
    var area: Int {
        (maxX - minX + 1) * (maxY - minY + 1)
    }
}

extension Square: CustomStringConvertible {
    var description: String {
        "(\(minX),\(minY)):(\(maxX),\(maxY))"
    }
}

public func part2(in input: String) -> Int {
    let points = parseInput(input)
    
    var allLines = [Square]()
    
    for i in 0 ..< points.count {
        let minX = min(points[i].x, points[(i+1)%points.count].x)
        let maxX = max(points[i].x, points[(i+1)%points.count].x)
        let minY = min(points[i].y, points[(i+1)%points.count].y)
        let maxY = max(points[i].y, points[(i+1)%points.count].y)
        
        allLines.append(Square(minX: minX, maxX: maxX, minY: minY, maxY: maxY))
    }
    
    var result = 0
    
    for i in 0 ..< points.count {
        next: for j in i + 1 ..< points.count {
            let minX = min(points[i].x, points[j].x)
            let maxX = max(points[i].x, points[j].x)
            let minY = min(points[i].y, points[j].y)
            let maxY = max(points[i].y, points[j].y)
            
            let square = Square(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
            
            for line in allLines {
                if square.isLineCrossing(line) {
                    continue next
                }
            }
            
            result = max(result, square.area)
        }
    }
    
    return result
}
