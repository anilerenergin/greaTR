import 'dart:convert';

class Education {
  int year;
  String university;
  String field;
  int? secondYear;
  String? secondUniversity;
  String? secondField;
  Education({
    required this.year,
    required this.university,
    required this.field,
    this.secondYear,this.secondUniversity,this.secondField
  });

  Education copyWith({
    int? year,
    String? university,
    String? field,
     int? secondYear,
  String? secondUniversity,
  String? secondField,
  }) {
    return Education(
      year: year ?? this.year,
      university: university ?? this.university,
      field: field ?? this.field,
      secondYear: secondYear ?? this.secondYear,
      secondUniversity: secondUniversity ?? this.secondUniversity,
      secondField: secondField ?? this.secondField,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'university': university,
      'field': field,
      'secondYear': secondYear,
      'secondUniversity': secondUniversity,
      'secondField': secondField,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      year: map['year'],
      university: map['university'],
      field: map['field'],
      secondYear: map['secondYear'],
      secondUniversity: map['secondUniversity'],
      secondField: map['secondField'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Education.fromJson(String source) =>
      Education.fromMap(json.decode(source));

  @override
  String toString() =>
      'Education(year: $year, university: $university, field: $field,secondYear: $secondYear, secondUniversity: $secondUniversity, secondField: $secondField)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Education &&
        other.year == year &&
        other.university == university &&
        other.field == field&&
        other.secondYear == secondYear &&
        other.secondUniversity == secondUniversity &&
        other.secondField == secondField;
  }

  @override
  int get hashCode => year.hashCode ^ university.hashCode ^ field.hashCode ^ secondYear.hashCode ^ secondUniversity.hashCode ^ secondField.hashCode;
}
