class ImpactMeasurement {
  final String solutionId;
  final String metricName;
  final int value;

  ImpactMeasurement({
    required this.solutionId,
    required this.metricName,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'solutionId': solutionId,
      'metricName': metricName,
      'value': value,
    };
  }
}
