import Testing
@testable import Day11

let exampleInput =
"""
aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
"""

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite struct `to get the first star on day 11` {
    @Test func `the number of paths from you to out for the example input should be 5`() {
        #expect(part1(exampleInput) == 5)
    }
}
