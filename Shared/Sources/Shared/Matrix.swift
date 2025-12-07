//
//  Matrix.swift
//  Shared
//
//  Created by Maarten Engels on 06/12/2025.
//

public struct Matrix<T> {
    public let width: Int
    public let height: Int
    private var cells: [[T]]
    
    public init(_ cells: [[T]]) {
        self.cells = cells
        width = cells.first?.count ?? 0
        height = cells.count
        
    }
    
    public subscript(rowIndex: Int) -> [T] {
        cells[rowIndex]
    }
    
    public subscript(columnIndex: Int, rowIndex: Int) -> T {
        cells[rowIndex][columnIndex]
    }
    
    public subscript(coord: Vector) -> T {
        self[coord.x, coord.y]
    }
    
    public func transposed() -> Matrix<T> {
        var transposedCells: [[T?]] = Array(repeating: Array(repeating: nil, count: height), count: width)
        
        for row in 0 ..< height {
            for column in 0 ..< width {
                transposedCells[column][row] = self[column, row]
            }
        }
        
        let newCells = transposedCells.map { row in
            row.compactMap { $0 }
        }
        
        return Matrix(newCells)
    }
    
    public init(cells: () -> [[T]]) {
        self.cells = cells()
        width = self.cells.first?.count ?? 0
        height = self.cells.count
    }
    
    public var rows: [[T]] {
        cells
    }
    
    public mutating func changeValue(at coord: Vector, to newValue: T) {
        cells[coord.y][coord.x] = newValue
    }
}

extension Matrix: Equatable where T: Equatable {
    public static func == (lhs: Matrix<T>, rhs: Matrix<T>) -> Bool where T: Equatable {
        guard type(of: lhs) == type(of: rhs) else { return false
        }
        
        return lhs.cells == rhs.cells
    }
}

extension Matrix {
    public func map<S>(_ transform: (T) -> S) -> Matrix<S> {
        let newCells = cells.map { row in
            row.map { cell in
                transform(cell)
            }
        }
        
        return Matrix<S>(newCells)
    }
    
    public func map<S>(_ transform: ([T]) -> S) -> [S] {
        let newRows = cells.map { row in
            transform(row)
        }
        
        return newRows
    }
}

extension Matrix {
    public static func makeStringMatrix(from string: String) -> Matrix<String> {
        let lines = string.split(separator: "\n")
        
        var result = [[String]]()
        
        for line in lines {
            let row = line.split(separator: " ")
                .map { String($0) }
            result.append(row)
        }
        
        return Matrix<String>(result)
    }
    
    public static func makeCharacterMatrix(from string: String) -> Matrix<Character> {
        let cells = convertInputToMatrixOfCharacters(string)
        return Matrix<Character>(cells)
    }
}
