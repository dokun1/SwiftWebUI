import XCTest
import Vaux
@testable import SwiftWebUI

final class SwiftWebUITests: XCTestCase, TableDataSource {
  func testTable() {
    createTable()
    XCTAssert(1 == 1)
  }
  
  func createTable() {
    let table = SwiftWebUI.Table()
    table.datasource = self
    table.numberOfRows = 7
    table.numberOfColumns = 6
    table.headerTitle = "Sample Title"
    do {
      try table.render()
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func valueForIndex(row: Int, column: Int) -> HTML? {
    return "(\(row + 1), \(column + 1))"
  }
  
  static var allTests = [
    ("testTable", testTable)
  ]
}
