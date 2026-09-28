import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final int height; // cm
  final int weight; // kg

  // BMI = kg / (m)^2
  double get _bmi => weight / pow(height / 100, 2);

  String calculateBMI() => _bmi.toStringAsFixed(1);

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'Chỉ số BMI cao hơn mức bình thường. Hãy thử tăng cường vận động và điều chỉnh chế độ ăn.';
    } else if (_bmi >= 18.5) {
      return 'Chỉ số BMI bình thường. Hãy tiếp tục duy trì lối sống lành mạnh!';
    } else {
      return 'Chỉ số BMI thấp hơn mức bình thường. Bạn nên ăn uống đầy đủ hơn.';
    }
  }
}