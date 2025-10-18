void main() {
  // Example
  final inputs = [
    '{what is (42)}?',
    '[text}',
    '{[[(a)b]c]d}',
  ];

  for (var input in inputs) {
    if (isBalanced(input)) {
      print('$input → Balanced');
    } else {
      print('$input → Not balanced');
    }
  }
}

bool isBalanced(String input) {
  List<String> stack = [];

  const pair = {
    ')': '(',
    ']': '[',
    '}': '{',
  };

  for (var char in input.split('')) {

    if (char == '(' || char == '[' || char == '{') {
      stack.add(char);
    }

    else if (char == ')' || char == ']' || char == '}') {
      if (stack.isEmpty || stack.removeLast() != pair[char]) {
        return false; 
      }
    }
  }

  return stack.isEmpty;
}
