extension IntExtension on int {
  String getExcelColumn() {
    var columnNumber = this;
    String result = '';
    while (columnNumber > 0) {
      columnNumber--;
      result = String.fromCharCode(columnNumber % 26 + 65) + result;
      columnNumber ~/= 26;
    }
    return result;
  }
}
