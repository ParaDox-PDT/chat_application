class MathState {
  final double firstNum;
  final double secondNum;
  final String answer;

  MathState({
    this.firstNum = 0,
    this.secondNum = 0,
    this.answer = "0",
  });

  MathState copyWith({
    double? firstNum,
    double? secondNum,
    String? answer,
  }) =>
      MathState(
        firstNum: firstNum ?? this.firstNum,
        secondNum: secondNum ?? this.secondNum,
        answer: answer ?? this.answer,
      );

  factory MathState.fromJson(Map<String, dynamic> json) => MathState(
    firstNum: json["firstNum"] as double? ?? 0,
    secondNum: json["secondNum"] as double? ?? 0,
    answer: json["answer"] as String? ?? "0",
  );

  @override
  String toString() {
    return '''
    FirstNum: $firstNum
    SecondNum:$secondNum
    answer:$answer
    ''';
  }
}