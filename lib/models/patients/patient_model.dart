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
  final String? birthPlace;
  final String diabetesDiagnosedSince;

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
    required this.birthPlace,
    required this.diabetesDiagnosedSince,
  });

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
      birthPlace: json['birth_place'] ?? '-',
      diabetesDiagnosedSince: json['diabetes_diagnosed_since'] ?? '-',
    );
  }
}
