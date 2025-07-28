class Patient {
  final int patientId;
  final String medicalRecordNumber;
  final String fullName;
  final String nationalId;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String phoneNumber;
  final String religion;
  final String occupation;
  final String education;
  final String maritalStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? birthPlace;
  final String diabetesDiagnosedSince;
  // final int height;
  // final double weight;
  // final String bmi;
  // // ignore: non_constant_identifier_names
  // final String GENIRS1;
  Patient({
    required this.patientId,
    required this.medicalRecordNumber,
    required this.fullName,
    required this.nationalId,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.religion,
    required this.occupation,
    required this.education,
    required this.maritalStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.birthPlace,
    required this.diabetesDiagnosedSince,
    // required this.height,
    // required this.weight,
    // required this.bmi,
    // required this.GENIRS1,
  });

  // Factory untuk mengubah JSON menjadi instance Patient
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'],
      medicalRecordNumber: json['medical_record_number'],
      fullName: json['full_name'],
      nationalId: json['national_id'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      religion: json['religion'],
      occupation: json['occupation'],
      education: json['education'],
      maritalStatus: json['marital_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      birthPlace: json['birth_place'] ?? '-',
      diabetesDiagnosedSince: json['diabetes_diagnosed_since'] ?? '-',
      // // Mengatasi kemungkinan 'height' berbentuk String atau null
      // height: json['height'] is String
      //     ? int.parse(json['height'])
      //     : (json['height'] ?? 170),
      // // Mengatasi kemungkinan 'weight' berbentuk String atau null
      // weight: json['weight'] is String
      //     ? double.parse(json['weight'])
      //     : (json['weight'] ?? 80),
      // bmi: json['bmi'] ?? '27.68',
      // GENIRS1: json['GENIRS1'] ?? 'CC',
    );
  }

  get allergies => null;

  get treatmentHistory => null;
}
