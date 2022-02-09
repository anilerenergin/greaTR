import 'dart:convert';

class Location {
  String country;
  String city;
  Location({
    required this.country,
    required this.city,
  });

  Location copyWith({
    String? country,
    String? city,
  }) {
    return Location(
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'city': city,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      country: map['country'],
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() => 'Location(country: $country, city: $city)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location && other.country == country && other.city == city;
  }

  @override
  int get hashCode => country.hashCode ^ city.hashCode;
}
