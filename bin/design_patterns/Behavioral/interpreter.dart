/*
Pattern using :  
Representation grammar for a language (music m Formulas , ,mathematical expressions, etc.).
Domain specific languages like SQL, Regex, etc.
in dart we can use RegExp class to implement the interpreter pattern
*/

import 'package:string_tokenizer_1/string_tokenizer_1.dart';

abstract class Expression {
  bool interpret();
}

class TerminalExpression implements Expression {
  final String data;

  TerminalExpression(this.data);

  @override
  bool interpret() {
    StringTokenizer tokens = StringTokenizer(data);
    while (tokens.hasMoreTokens()) {
      final String test = tokens.nextToken();
      if (test == data) {
        return true;
      }
    }
    return false;
  }
}

class AndExpression implements Expression {
  final Expression expr1;
  final Expression expr2;

  AndExpression(this.expr1, this.expr2);

  @override
  bool interpret() {
    return expr1.interpret() && expr2.interpret();
  }
}

class OrExpression implements Expression {
  final Expression expr1;
  final Expression expr2;

  OrExpression(this.expr1, this.expr2);

  @override
  bool interpret() {
    return expr1.interpret() || expr2.interpret();
  }
}

void main() {
  // Example usage:
  Expression expr1 = TerminalExpression('A');
  Expression expr2 = TerminalExpression('B');
  Expression andExpr = AndExpression(expr1, expr2);
  Expression orExpr = OrExpression(expr1, expr2);

  print('AND Expression Result: ${andExpr.interpret()}');
  print('OR Expression Result: ${orExpr.interpret()}');

  // example
  final input = 'Lion , and tigers , and bears , oh my!';
  final regex = RegExp(r'lion|cat|dog|wolf|bear|human|tiger|lion');
  final Iterable<RegExpMatch> matches = regex.allMatches(input.toLowerCase());
  for (final match in matches) {
    print('fount match: ${match.group(0)}');
  }
}
