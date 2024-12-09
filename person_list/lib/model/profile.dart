class Profile {
  final int? id;
  final String name;
  final String email;
  final String phoneNumber;
  final bool maritalStatus;

  Profile({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.maritalStatus,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'maritalStatus': maritalStatus
          ? 1
          : 0,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      maritalStatus: json['maritalStatus'] as int == 1,
    );
  }
}