class CSVParser {
  // note:最終的なOUTPUTは、
  // out = [
  //  {
  //    "comment" : "COMMENT",
  //    "code" : "CODE",
  //    etc...
  //  }, // One Line
  //  {
  //    etc...
  //  }
  // ]
  CSVParser(String csv, {String split = ',', String rowSplit = '\n'}) {
    List<String> lines = csv.split(rowSplit);
    // Erase rows that actual value is not written in.
    String explanation = lines[0];
    lines.removeAt(0); // remove explanation line.
    List<String> culMeanings = explanation.split(split);
    List<Map<String, String>> ret = [];
    // get value
    for (String line in lines) {
      List<String> elements = line.split(split);
      ret.add({}); // initialize
      List<String> fixedCulMeanings = List.of(culMeanings); // copy culMeanings.
      fixedCulMeanings.removeRange(elements.length, fixedCulMeanings.length);
      // todo: 続き
    }
  }
}
