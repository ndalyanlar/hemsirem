import 'dart:convert';

class Disease {
  String name;
  Disease(this.name);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Disease.fromJson(String source) =>
      Disease.fromMap(json.decode(source));
}
