class MedicalRecord {
  final String patientName;
  final String patientData;
  final List<String> drugAllergies;
  final String? prescription;
  final int height;
  final int weight;
  final String bmi;
  final String? irs1Rs1801278;
  final List<String> drugsConsumed;
  final String? diabetesDiagnosedSince;

  MedicalRecord({
    required this.patientName,
    required this.patientData,
    required this.drugAllergies,
    this.prescription,
    required this.height,
    required this.weight,
    required this.bmi,
    this.irs1Rs1801278,
    required this.drugsConsumed,
    this.diabetesDiagnosedSince,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      patientName: json['patient_name'],
      patientData: json['patient_data'],
      drugAllergies: List<String>.from(json['drug_allergies'] ?? []),
      prescription: json['prescription'],
      height: json['height'],
      weight: json['weight'],
      bmi: json['bmi'],
      irs1Rs1801278: json['irs1_rs1801278'],
      drugsConsumed: List<String>.from(json['drugs_consumed'] ?? []),
      diabetesDiagnosedSince: json['diabetes_diagnosed_since'],
    );
  }
}
