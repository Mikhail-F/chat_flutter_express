class UserProfileModel {
  final int id;
  final String name;

  UserProfileModel({
    required this.id,
    required this.name,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
