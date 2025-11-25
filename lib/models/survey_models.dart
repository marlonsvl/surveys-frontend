class SurveyResponse {
  String? email;
  String? location;
  bool consentAccepted = false;

  SociodemographicData sociodemographicData = SociodemographicData();
  
  // Bergen TikTok (6 items, 1-5)
  Map<String, int> bergenTikTok = {};
  
  // Bergen Instagram (6 items, 1-5)
  Map<String, int> bergenInstagram = {};
  
  // UCLA Loneliness (20 items, 1-4)
  Map<String, int> uclaLoneliness = {};
  
  // Prefrontal Symptoms (20 items, 0-4)
  Map<String, int> prefrontalSymptoms = {};
  
  // CAIDS (13 items, 1-5)
  Map<String, int> caids = {};
  
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'location': location,
      'consent_accepted': consentAccepted,
      if (bergenTikTok.isNotEmpty) 'bergen_tiktok': bergenTikTok,
      if (bergenInstagram.isNotEmpty) 'bergen_instagram': bergenInstagram,
      if (uclaLoneliness.isNotEmpty) 'ucla_loneliness': uclaLoneliness,
      if (prefrontalSymptoms.isNotEmpty) 'prefrontal_symptoms': prefrontalSymptoms,
      if (caids.isNotEmpty) 'caids': caids,

      'sociodemographic_data': sociodemographicData.toJson(),
    };
  }
}

class Question {
  final String id;
  final String text;
  final int minValue;
  final int maxValue;
  final List<String> labels; // Changed to list of labels for all values
  
  const Question({
    required this.id,
    required this.text,
    required this.minValue,
    required this.maxValue,
    required this.labels, // Now required
  });
}

class Edad {
  final String id;
  final String text;
  final int value;

  const Edad({
    required this.id,
    required this.text,
    required this.value,
  });
}

class Gender {
  final String id;
  final String text;
  final String value; // 'M', 'F', 'O'
  final String? otherText;
  final List<String> labels; // If 'O', specify other text 
  const Gender({
    required this.id,
    required this.text,
    required this.value,
    this.otherText,
    required this.labels,
  });
}

class LivingWith {
  final String id;
  final String text;
  final String value; // 'alone', 'mother', 'father', etc.
  final String? otherText; // If 'other', specify other text 
  final List<String> labels;
  const LivingWith({
    required this.id,
    required this.text,
    required this.value,
    this.otherText,
    required this.labels,
  });
}

class University {
  final String id;
  final String text;
  final String value;

  const University({
    required this.id,
    required this.text,
    required this.value,
  });
}

class Career {
  final String id;
  final String text;
  final String value;

  const Career({
    required this.id,
    required this.text,
    required this.value,
  });
}

class CurrentSemester {
  final String id;
  final String text;
  final String value;
  const CurrentSemester({
    required this.id,
    required this.text,
    required this.value,
  });
}

class MaritalStatus {
  final String id;
  final String text;
  final String value; // 'single', 'married', etc.
  final List<String> labels;
  const MaritalStatus({
    required this.id,
    required this.text,
    required this.value, 
    required this.labels,
  });
}

class MotherEducationLevel {
  final String id;
  final String text;
  final String value;
  const MotherEducationLevel({
    required this.id,
    required this.text,
    required this.value,
  });
}

class FatherEducationLevel {
  final String id;
  final String text;
  final String value;

  const FatherEducationLevel({
    required this.id,
    required this.text,
    required this.value,
  });
} 

class MotherAge {
  final String id;
  final String text;
  final int value;

  const MotherAge({
    required this.id,
    required this.text,
    required this.value,
  });
}

class FatherAge {
  final String id;
  final String text;
  final int value;

  const FatherAge({
    required this.id,
    required this.text,
    required this.value,
  });
}

class GpaLastSemester {
  final String id;
  final String text;
  final double value;

  const GpaLastSemester({
    required this.id,
    required this.text,
    required this.value,
  });
}

class RepeatedCycles {
  final String id;
  final String text;
  final bool value;

  const RepeatedCycles({
    required this.id,
    required this.text,
    required this.value,
  });

}
class RepeatedCyclesCount {
  final String id;
  final String text;
  final int value;

  const RepeatedCyclesCount({
    required this.id,
    required this.text,
    required this.value,
  });
}

class ResidenceSector {
  final String id;
  final String text;
  final String value; // 'urban', 'rural'

  const ResidenceSector({
    required this.id,
    required this.text,
    required this.value,
  });
}

class SocioeconomicLevel {
  final String id;
  final String text;
  final String value; // 'high', 'medium', 'low'
  final List<String> labels;
  const SocioeconomicLevel({
    required this.id,
    required this.text,
    required this.value,
    required this.labels,
  });
}

class IncomeSources {
  final String id;
  final String text;
  final List<String> values;

  const IncomeSources({
    required this.id,
    required this.text,
    required this.values,
  });
}


class SociodemographicData {
  //String? country;
  int? age;
  String? gender; // 'M', 'F', 'O'
  String? genderOther;
  String? livingWith; // 'alone', 'mother', 'father', etc.
  String? livingWithOther;
  String? university;
  String? career;
  String? currentSemester;
  String? maritalStatus; // 'single', 'married', etc.
  String? motherEducationLevel;
  String? fatherEducationLevel;
  int? motherAge;
  int? fatherAge;
  double? gpaLastSemester;
  bool? repeatedCycles;
  int? repeatedCyclesCount;
  String? residenceSector; // 'urban', 'rural'
  String? socioeconomicLevel; // 'high', 'medium', 'low'
  List<String>? incomeSources;

  Map<String, dynamic> toJson() {
    return {
      //'country': country,
      'age': age,
      'gender': gender,
      'gender_other': genderOther ?? '',
      'living_with': livingWith,
      'living_with_other': livingWithOther ?? '',
      'university': university,
      'career': career,
      'current_semester': currentSemester,
      'marital_status': maritalStatus,
      'mother_education_level': motherEducationLevel,
      'father_education_level': fatherEducationLevel,
      'mother_age': motherAge,
      'father_age': fatherAge,
      'gpa_last_semester': gpaLastSemester,
      'repeated_cycles': repeatedCycles ?? false,
      'repeated_cycles_count': repeatedCyclesCount ?? 0,
      'residence_sector': residenceSector,
      'socioeconomic_level': socioeconomicLevel,
      'income_sources': incomeSources?.join(', '),
    };
  }
}