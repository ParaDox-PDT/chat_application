class MathState {
  final int firstNum;
  final int secondNum;
  final int answer;

  MathState({
    this.firstNum = 0,
    this.secondNum = 0,
    this.answer = 0,
  });

  MathState copyWith({
    int? firstNum,
    int? secondNum,
    int? answer,
  }) =>
      MathState(
        firstNum: firstNum ?? this.firstNum,
        secondNum: secondNum ?? this.secondNum,
        answer: answer ?? this.answer,
      );

  factory MathState.fromJson(Map<String, dynamic> json) => MathState(
    firstNum: json["firstNum"] as int? ?? 0,
    secondNum: json["secondNum"] as int? ?? 0,
    answer: json["answer"] as int? ?? 0,
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