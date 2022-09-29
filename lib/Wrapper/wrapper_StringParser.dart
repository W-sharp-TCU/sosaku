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
    Tree<String> latest = tree; // note: 常に次に値を入れる参照先を持っている(val='')
    for (int i = 0; i < infixNotation.length; i++) {
      String c = infixNotation[i];
      // note: 最初は何もない
      if (operators.contains(c)) {
        // todo: cが演算子の時
      } else {
        switch (isBracket(c, brackets)) {
          case 1:
            // todo: 開きかっこの時
            break;
          case 2:
            // todo: 閉じかっこの時
            break;
          default:
            // todo: 被演算子(数)の時
            break;
        }
      }
      tree.show();
    }
    return tree;
  }
}

class Tree<T> {
  T val;
  Tree<T>? _prev;
  Tree<T>? _left;
  Tree<T>? _right;

  factory Tree.root({required val}) => Tree._(val: val);
  Tree._({required this.val, Tree<T>? prev}) {
    _prev = prev;
  }

  Tree<T> addLeft(T val) {
    if (_left == null) {
      _left = Tree._(val: val, prev: this);
    } else {
      throw DuplicateException();
    }
    return _left!;
  }

  Tree<T>? delLeft() {
    Tree<T>? ret = _left;
    if (ret != null) {
      ret._prev = null;
    }
    _left = null;
    return ret;
  }

  Tree<T> addRight(T val) {
    if (_left == null) {
      _right = Tree._(val: val, prev: this);
    } else {
      throw DuplicateException();
    }
    return _right!;
  }

  Tree<T>? delRight() {
    Tree<T>? ret = _right;
    if (ret != null) {
      ret._prev = null;
    }
    _right = null;
    return ret;
  }

  void show() {
    print("$val");
    if (_left != null) {
      print("<- left: ");
      _left!.show();
    }
    if (_right != null) {
      print("-> Right: ");
    }
  }

  get prev => _prev;
  get left => _left;
  get right => _right;
}

class DuplicateException implements Exception {
  @override
  String toString() =>
      'DuplicateException: The variant you are about to insert a value has already have a value.';
}
