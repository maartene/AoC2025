import Testing
@testable import Day09
import Shared

let exampleInput =
"""
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
"""

@Suite struct `to get the first star on day 09` {
    @Test func `the largest rectangle area for the example input should be 50`() {
        #expect(largestRectangleArea(in: exampleInput) == 50)
    }
    
    @Test func `the largest rectangle area for the actual input should be 4755429952`() {
        #expect(largestRectangleArea(in: input) == 4755429952)
    }
}

@Suite struct `to get the second star on day 09` {
    @Test func `the largest rectangle area for the example input should be 24`() {
        #expect(part2(in: exampleInput) == 24)
    }

    // 1432297642
    // 1383178986
    // 1383178986
    // 2939369478
    // 1383390016 not correct
    // 1173523000 too low
    // 668574442 too low
    // 2323640150 too high
    @Test func `the largest rectangle area for the actual input should be 24`() {
        #expect(part2(in: input) == 24)
    }
    
    @Test func `elipse data`() {
        let positions = parseInput(input)
        let minX = positions.map { $0.x }.min()!
        let minY = positions.map { $0.y }.min()!
        let maxX = positions.map { $0.x }.max()!
        let maxY = positions.map { $0.y }.max()!
        
        print(minX, minY)
        
        let horizontalRadius = (maxX - minX) / 2
        let verticalRadius = (maxY - minY) / 2
        
        print("horizontalRadius: \(horizontalRadius) \nverticalRadius: \(verticalRadius)")
        
    }
    
//    @Test func `greentile count`() {
//        let redCarpetTiles = parseInput(input)
//        let greenCarpetTiles = getGreenCarpetPositions(from: redCarpetTiles, startPodxint: Vector(x: 10000, y: 60000))
//        print(greenCarpetTiles.count)
//        
//    }
}
