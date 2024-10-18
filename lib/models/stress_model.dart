class StressModel {
  int? id;
  String stressFactor;
  String copingStrategy;
  int stressLevel;

  StressModel({this.id, required this.stressFactor, required this.copingStrategy, required this.stressLevel});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stress_factor': stressFactor,
      'coping_strategy': copingStrategy,
      'stress_level': stressLevel,
    };
  }
}