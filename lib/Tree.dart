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
      throw DoubleAssignException();
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
    if (_right == null) {
      _right = Tree._(val: val, prev: this);
    } else {
      throw DoubleAssignException();
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
    Tree<T> current = this;
    List<String> address = ["this"];
    List<int> hashes = [];
    print("------------------- NODE TREE --------------------");
    while (true) {
      if (!hashes.contains(current.hashCode)) {
        _showNode(current, address, hashes);
      }
      if (current.left != null && !hashes.contains(current.left!.hashCode)) {
        current = current.left!;
        address.add("Left");
      } else if (current.right != null &&
          !hashes.contains(current.right!.hashCode)) {
        current = current.right!;
        address.add("Right");
      } else if (current.prev != null) {
        current = current.prev!;
        address.removeLast();
      } else {
        break;
      }
    }
    if (this.prev != null) {
      print("** This is not root node. **");
    }
    print("--------------------------------------------------");
  }

  void _showNode(Tree<T> node, List<String> address, List<int> hashes) {
    String addressString = "";
    for (String value in address) {
      addressString += value + '/';
    }
    print("$addressString -> ${node.val}");
    hashes.add(node.hashCode);
  }

  @override
  String toString() {
    return "Value: ${val.toString()}, LeftNode: ${left?.val}, RightNode: ${right?.val}, Parent: ${prev?.val}";
  }

  Tree<T>? get prev => _prev;
  Tree<T>? get left => _left;
  Tree<T>? get right => _right;
}

class DoubleAssignException implements Exception {
  @override
  String toString() =>
      "DoubleAssignException: The variable you are about to assign a value to has already have a value."
      "\nYou can assign a value to the variable after you delete its value by using delLeft() or delRight() function.";
}
