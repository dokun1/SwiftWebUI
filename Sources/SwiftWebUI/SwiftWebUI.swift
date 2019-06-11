import Vaux

public protocol TableDataSource: class {
  func valueForIndex(row: Int, column: Int) -> HTML?
}

struct SwiftWebUI {

  class Table {
    var datasource: TableDataSource? = nil
    var numberOfRows: Int = 0
    var numberOfColumns: Int = 0
    var rows: [Int: [HTML]] = [0: [""]]
    var headerTitle: String = ""
    var filename: String = "testing"
    var fileLocation: String = "/tmp/"
    var cellAlignment: Alignment = .center
    var border: Int = 2
    var cellSpacing: Int = 1
    var cellPadding: Int = 4
    
    init() {}
    
    public func render() throws {
      
      func renderRows() -> HTML {
        forEach(0..<self.numberOfRows) { index in
          renderTableRow(rowIndex: index)
        }
      }
      
      func renderHeaderRow() -> HTML {
        if self.headerTitle.isEmpty {
          return ""
        } else {
          return renderedHeaderRow()
        }
      }
      
      func renderedHeaderRow() -> HTML {
        tableHeadData {
          self.headerTitle
          }.scope(.columnGroup).columnSpan(self.numberOfRows)
      }
      
      func renderTableRow(rowIndex: Int) -> HTML {
        tableRow {
          forEach(0..<self.numberOfColumns) { columnIndex in
            renderTableElement(content: self.datasource?.valueForIndex(row: rowIndex, column: columnIndex) ?? "")
          }
        }
      }
      
      func renderTableElement(content: HTML) -> HTML {
        tableData {
          content
        }.alignment(self.cellAlignment)
      }
      
      func topTable() -> HTML {
        html {
          body {
            tableGrid {
              renderHeaderRow()
              renderRows()
            }.attr("border", String(self.border)).attr("cellspacing", String(self.cellSpacing)).attr("cellpadding", String(self.cellPadding))
          }
        }
      }
      
      let vaux = Vaux()
      vaux.outputLocation = .file(name: self.filename, path: self.fileLocation)
      do {
        try vaux.render(topTable())
      } catch let error {
        throw error
      }
    }
  }
}
