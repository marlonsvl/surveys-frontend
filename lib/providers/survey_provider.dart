import 'package:flutter/foundation.dart';
import '../models/survey_models.dart';
import '../services/api_service.dart';

class SurveyProvider with ChangeNotifier {
  final SurveyResponse _response = SurveyResponse();
  final ApiService _apiService = ApiService();
  
  int _currentPage = 0;
  bool _isLoading = false;
  String? _errorMessage;
  
  SurveyResponse get response => _response;
  int get currentPage => _currentPage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  void setEmail(String email) {
    _response.email = email;
    notifyListeners();
  }
  
  void setLocation(String location) {
    _response.location = location;
    notifyListeners();
  }
  
  void setConsent(bool accepted) {
    _response.consentAccepted = accepted;
    notifyListeners();
  }

  // Sociodemographic setters
  void setSociodemographicData(SociodemographicData data) {
    _response.sociodemographicData = data;
    notifyListeners();
  }
  
  
  void setAge(int age) {
    _response.sociodemographicData.age = age;
    notifyListeners();
  }
  
  void setGender(String gender) {
    _response.sociodemographicData.gender = gender;
    notifyListeners();
  }
  
  void setGenderOther(String genderOther) {
    _response.sociodemographicData.genderOther = genderOther;
    notifyListeners();
  }
  
  void setLivingWith(String livingWith) {
    _response.sociodemographicData.livingWith = livingWith;
    notifyListeners();
  }
  
  void setLivingWithOther(String livingWithOther) {
    _response.sociodemographicData.livingWithOther = livingWithOther;
    notifyListeners();
  }
  
  void setUniversity(String university) {
    _response.sociodemographicData.university = university;
    notifyListeners();
  }
  
  void setCareer(String career) {
    _response.sociodemographicData.career = career;
    notifyListeners();
  }
  
  void setCurrentSemester(String semester) {
    _response.sociodemographicData.currentSemester = semester;
    notifyListeners();
  }
  
  void setMaritalStatus(String status) {
    _response.sociodemographicData.maritalStatus = status;
    notifyListeners();
  }
  
  void setMotherEducationLevel(String level) {
    _response.sociodemographicData.motherEducationLevel = level;
    notifyListeners();
  }
  
  void setFatherEducationLevel(String level) {
    _response.sociodemographicData.fatherEducationLevel = level;
    notifyListeners();
  }
  
  void setMotherAge(int age) {
    _response.sociodemographicData.motherAge = age;
    notifyListeners();
  }
  
  void setFatherAge(int age) {
    _response.sociodemographicData.fatherAge = age;
    notifyListeners();
  }
  
  void setGpaLastSemester(double gpa) {
    _response.sociodemographicData.gpaLastSemester = gpa;
    notifyListeners();
  }
  
  void setRepeatedCycles(bool repeated) {
    _response.sociodemographicData.repeatedCycles = repeated;
    notifyListeners();
  }
  
  void setRepeatedCyclesCount(int count) {
    _response.sociodemographicData.repeatedCyclesCount = count;
    notifyListeners();
  }
  
  void setResidenceSector(String sector) {
    _response.sociodemographicData.residenceSector = sector;
    notifyListeners();
  }
  
  void setSocioeconomicLevel(String level) {
    _response.sociodemographicData.socioeconomicLevel = level;
    notifyListeners();
  }
  
  void setIncomeSources(List<String> sources) {
    _response.sociodemographicData.incomeSources = sources;
    notifyListeners();
  }

  
  void setAnswer(String instrument, String questionId, int value) {
    switch (instrument) {
      case 'bergen_tiktok':
        _response.bergenTikTok[questionId] = value;
        break;
      case 'bergen_instagram':
        _response.bergenInstagram[questionId] = value;
        break;
      case 'ucla_loneliness':
        _response.uclaLoneliness[questionId] = value;
        break;
      case 'prefrontal_symptoms':
        _response.prefrontalSymptoms[questionId] = value;
        break;
      case 'caids':
        _response.caids[questionId] = value;
        break;
    }
    notifyListeners();
  }
  
  int? getAnswer(String instrument, String questionId) {
    switch (instrument) {
      case 'bergen_tiktok':
        return _response.bergenTikTok[questionId];
      case 'bergen_instagram':
        return _response.bergenInstagram[questionId];
      case 'ucla_loneliness':
        return _response.uclaLoneliness[questionId];
      case 'prefrontal_symptoms':
        return _response.prefrontalSymptoms[questionId];
      case 'caids':
        return _response.caids[questionId];
      default:
        return null;
    }
  }
  
  void nextPage() {
    _currentPage++;
    notifyListeners();
  }
  
  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }
  
  Future<bool> submitSurvey() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      await _apiService.submitSurvey(_response);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void reset() {
    _currentPage = 0;
    _response.email = null;
    _response.location = null;
    _response.consentAccepted = false;
    _response.bergenTikTok.clear();
    _response.bergenInstagram.clear();
    _response.uclaLoneliness.clear();
    _response.prefrontalSymptoms.clear();
    _response.caids.clear();
    _errorMessage = null;
    notifyListeners();
  }
}