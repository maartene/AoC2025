import Testing
@testable import Shared

@Suite struct `Matrix should` {
    @Test func `when transposed return the transposed matrix`() {
        let matrix = Matrix([
            [1, 2, 3],
            [4, 5, 6],
        ])
        
        let expectedTransposedMatrix = Matrix([
            [1, 4],
            [2, 5],
            [3, 6]
        ])
        
        #expect(matrix.transposed() == expectedTransposedMatrix)
    }
}
