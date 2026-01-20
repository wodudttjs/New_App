class CommunityDetail {
  const CommunityDetail({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;

  factory CommunityDetail.fromJson(Map<String, dynamic> json) {
    return CommunityDetail(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }
}
