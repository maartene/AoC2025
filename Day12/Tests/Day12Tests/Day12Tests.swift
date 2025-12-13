import Testing
@testable import Day12

let exampleInput =
"""
0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2
"""

@Test func `the number of fitting configurations for the example input should be 2`() async throws {
    #expect(numberOfFittingConfigurations(in: exampleInput) == 2)
}

@Test func `the number of fitting configurations for the actual input should be 403`() async throws {
    #expect(numberOfFittingConfigurations(in: input) == 403)
}
