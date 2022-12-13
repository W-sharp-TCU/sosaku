import 'package:csv/csv.dart';

/// Convert CSV strings into Map<String, dynamic> in List.
///
/// The keys of Map depends on values header. The keys of Map is always String.
///
/// @param csv : CSV Strings
///
/// @param split : Character that splits each value of a line. Defaults to ','.
///
/// @param eol : Character of end of line. Defaults to '\n'.
///
/// @param headerRow : The row number of header. This is 1-based indexing.
///   Defaults to 1.
///
/// @param dataStartRow : The number of row that value starts with. This is 1-based indexing.
///   Defaults to 2.
///
/// ### Example
/// Input CSV =
/// ```csv
/// header1, header2, 3,
/// "value1", true, 0,
/// "value2", false, 1
/// ```
/// Output List<Map<String, dynamic>> =
/// ```dart
///   [
///     "header1" : "value1", // String, String
///     "header2" : true, // String, bool
///     "3" : 0, // String, int
///   ],
///   [
///     "header1" : "value1", // String, String
///     "header2" : true, // String, bool
///     "3" : 0, // String, int
///   ]
/// ```
List<Map<String, dynamic>> convertCSV(String csv,
    {String split = ',',
    String eol = '\n',
    int headerRow = 1,
    int dataStartRow = 2}) {
  final List<Map<String, dynamic>> ret = [];
  final List<List<dynamic>> csvList = CsvToListConverter(eol: eol).convert(csv);
  final List<dynamic> headerLine = csvList[headerRow - 1];
  final List<String> header = [];
  for (dynamic e in headerLine) {
    header.add(e.toString());
  }
  csvList.removeRange(0, dataStartRow - 1);
  for (List line in csvList) {
    Map<String, dynamic> lineMap = {};
    for (dynamic val in line) {
      lineMap[header[line.indexOf(val)]] = val;
    }
    ret.add(lineMap);
  }
  return ret;
}
