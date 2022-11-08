class BookDatabase {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;

  BookDatabase({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  BookDatabase.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'] ?? 'no_data';
    phone = map['phone'] ?? 'no_data';
    email = map['email'] ?? 'no_data';
    address = map['address'] ?? '--';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }
}
