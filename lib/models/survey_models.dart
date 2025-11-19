class SurveyResponse {
  String? email;
  String? location;
  bool consentAccepted = false;
  
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