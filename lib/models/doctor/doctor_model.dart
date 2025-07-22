class Doctor {
  final int id;
  final String fullName;
  final String specialization;
  final String strId;
  final String practiceLocation;
  final String image; // tambahkan field gambar dummy
  final double rating;
  final int reviews;

  Doctor({
    required this.id,
    required this.fullName,
    required this.specialization,
    required this.strId,
    required this.practiceLocation,
    required this.image,
    required this.rating,
    required this.reviews,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fullName: json['full_name'],
      specialization: json['specialization'],
      strId: json['str_id'],
      practiceLocation: json['practice_location'],
      image: json['image'] ?? 'assets/images/drg_rahma.png', // placeholder
      rating: (json['rating'] ?? 4.5).toDouble(), //ganti kalau udah ga dummy
      reviews: (json['review'] ?? 120), //ganti kalau udah ga dummy
    );
  }
}
