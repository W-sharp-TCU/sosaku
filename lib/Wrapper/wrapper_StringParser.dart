import 'package:sosaku/Tree.dart';

enum _TextType { formula, general }

class StringParser {
  // Configurations
  static const List<List<String>> brackets = [
    ['[', ']'],
    ['{'],
    ['}'],
    ['(', ')']
  ];
  static const List<String> operators = ['+', '-', '*', '/', '&&', '||'];

  _TextType type;
  String target;

  StringParser({required this.type, required this.target});
  factory StringParser.parseFormula(String target) =>
      StringParser(type: _TextType.formula, target: target);

  String? toPrefixNotation({String? formula}) {
    formula ??= target;
    String? prefixNotation;
    makeSyntaxTree(formula);
    return prefixNotation;
  }

  int isBracket(String c, List<List<String>> bracket) {
    for (int i = 0; i < bracket.length; i++) {
      for (int j = 0; j < bracket[i].length; j++) {
        if (c == bracket[i][j]) {
          return j;
        }
      }
    }
    return -1;
  }

  Tree<String>? makeSyntaxTree(String infixNotation) {
    Tree<String> tree = Tree<String>.root(val: '');
    Tree<String> cur = tree; // note: 常に次に値を入れる参照先を持っている(val='')
    String operand = ''; // 被演算子1つの文字列
    List<Tree<String>> topStack = []; // 演算子がトップのノードのスタック
    for (int i = 0; i < infixNotation.length; i++) {
      String c = infixNotation[i];
      // note: 最初は何もない
      if (operators.contains(c)) {
        // todo: cが演算子の時
        // note: ノードのvalに入れて、Leftに今のoperand、右に空ノードを作ってnextをずらす
        // todo: 演算子の優先順位を見て、適切な木を作る
        cur.val = c;
        cur.addLeft(operand);
        operand = '';
        cur = cur.addRight('');
      } else {
        switch (isBracket(c, brackets)) {
          case 0:
            // todo: 開きかっこの時
            // note: 新しいノードの最上位演算子を軸に枝を作る
            // note: 開いた時のノードを(right)を記録しておく
            break;
          case 1:
            // todo: 閉じかっこの時
            // note: 閉じて、次に演算子が来たら記録しておいたところに挿入する
            break;
          default:
            // todo: 被演算子(数)の時
            // note: operandに追加してきちんとした数にする
            operand += c;
            break;
        }
      }
      tree.show();
    }
    if (operand != '') {
      cur.val = operand; // 最後まで残った被演算子を葉にする
    }
    return tree;
  }
}
