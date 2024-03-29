import 'package:sosaku/Tree.dart';

class FormulaParser {
  /// ****************************** Config ***********************************/
  static const Map<String, String> brackets = {
    // '<begin symbol>': '<end symbol>'
    '[': ']',
    '(': ')',
  };

  static const Map<String, List> operators = {
    // '<symbol>': [<function>, <priority>]
    '+': [FormulaParser._add, 100],
    '-': [FormulaParser._sub, 100],
    '*': [FormulaParser._mul, 150],
    '/': [FormulaParser._div, 150],
    '==': [FormulaParser._equal, 100],
    '>>': [FormulaParser._greater, 100],
    '<<': [FormulaParser._less, 100],
    '>=': [FormulaParser._geq, 100],
    '<=': [FormulaParser._leq, 100],
    '&&': [FormulaParser._and, 50],
    '||': [FormulaParser._or, 50],
  };

  /// Operating functions
  static double _add(double a, double b) => a + b;
  static double _sub(double a, double b) => a - b;
  static double _mul(double a, double b) => a * b;
  static double _div(double a, double b) => a / b;

  static bool _equal(double a, double b) => a == b;
  static bool _greater(double a, double b) => a > b;
  static bool _geq(double a, double b) => a >= b;
  static bool _less(double a, double b) => a < b;
  static bool _leq(double a, double b) => a <= b;

  static bool _and(bool a, bool b) => (a == true && b == true) ? true : false;
  static bool _or(bool a, bool b) => (a == false && b == false) ? false : true;

  /// *************************************************************************/

  String target;

  FormulaParser({this.target = "0"});

  bool isSatisfied() {
    return false;
  }

  String? toPrefixNotation({String? infixNotation}) {
    infixNotation ??= target;
    String? prefixNotation;
    makeSyntaxTree(infixNotation);
    return prefixNotation;
  }

  String? toPostfixNotation({String? infixNotation}) {
    infixNotation ??= target;
    return null;
  }

  Tree<String>? makeSyntaxTree(String infixNotation) {
    Tree<String> tree = Tree<String>.root(val: '');
    Tree<String> cur = tree; // note: 常に次に値を入れる参照先を持っている(val='')
    String operand = ''; // 被演算子1つの文字列
    List<Tree<String>> topStack = []; // 演算子がトップのノードのスタック
    for (int i = 0; i < infixNotation.length; i++) {
      String c = infixNotation[i];
      // note: 最初は何もない
      if (operators.containsKey(c)) {
        // todo: cが演算子の時
        // note: ノードのvalに入れて、Leftに今のoperand、右に空ノードを作ってnextをずらす
        // todo: 演算子の優先順位を見て、適切な木を作る
        cur.val = c;
        cur.addLeft(operand);
        operand = '';
        cur = cur.addRight('');
      } else if (brackets.containsKey(c)) {
        // todo: 開きかっこの時
        // note: 新しいノードの最上位演算子を軸に枝を作る
        // note: 開いた時のノードを(right)を記録しておく

        print("開きかっこ$c");
      } else if (brackets.containsValue(c)) {
        // todo: 閉じかっこの時
        // note: 閉じて、次に演算子が来たら記録しておいたところに挿入する
        print("閉じかっこ$c");
      } else {
        // todo: 被演算子(数)の時
        // note: operandに追加してきちんとした数にする
        operand += c;
      }
      tree.show();
    }
    if (operand != '') {
      cur.val = operand; // 最後まで残った被演算子を葉にする
    }
    return tree;
  }
}
