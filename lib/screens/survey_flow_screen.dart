import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_tics/screens/sociodemographic_screen.dart';
import '../providers/survey_provider.dart';
import '../data/questions_data.dart';
import '../models/question.dart';
import 'question_screen.dart';
import 'completion_screen.dart';


class SurveyFlowScreen extends StatefulWidget {
  const SurveyFlowScreen({super.key});

  

  @override
  State<SurveyFlowScreen> createState() => _SurveyFlowScreenState();
}

class _SurveyFlowScreenState extends State<SurveyFlowScreen> {
  final PageController _pageController = PageController();
  int _currentInstrumentIndex = 0;
  int _currentQuestionIndex = 0;

  // Add this screen to the list before instruments
final sociodemographicScreen = InstrumentData(
  name: 'Datos Demográficos',
  description: 'Información Personal',
  icon: Icons.person_outline,
  color: Colors.indigo,
  questions: [], // No questions, uses custom UI
  instrumentKey: 'sociodemographic',
);



  late final List<InstrumentData> _instruments = [
    sociodemographicScreen, 
    
    InstrumentData(
      name: 'Bergen TikTok',
      description: 'Escala de Adicción a TikTok',
      icon: Icons.video_library,
      color: Colors.pink,
      questions: QuestionsData.bergenTikTokQuestions,
      instrumentKey: 'bergen_tiktok',
    ),
    InstrumentData(
      name: 'Bergen Instagram',
      description: 'Escala de Adicción a Instagram',
      icon: Icons.photo_camera,
      color: Colors.purple,
      questions: QuestionsData.bergenInstagramQuestions,
      instrumentKey: 'bergen_instagram',
    ),
    InstrumentData(
      name: 'UCLA',
      description: 'Escala de Soledad',
      icon: Icons.people_outline,
      color: Colors.blue,
      questions: QuestionsData.uclaLonelinessQuestions,
      instrumentKey: 'ucla_loneliness',
    ),
    InstrumentData(
      name: 'Síntomas Prefrontales',
      description: 'Inventario Abreviado',
      icon: Icons.psychology_outlined,
      color: Colors.orange,
      questions: QuestionsData.prefrontalSymptomsQuestions,
      instrumentKey: 'prefrontal_symptoms',
    ),
    InstrumentData(
      name: 'CAIDS',
      description: 'Dependencia de IA Conversacional',
      icon: Icons.smart_toy,
      color: Colors.teal,
      questions: QuestionsData.caidsQuestions,
      instrumentKey: 'caids',
    ),
  ];

  int get _totalQuestions {
    return _instruments.fold(0, (sum, inst) => sum + inst.questions.length);
  }

  int get _completedQuestions {
    int completed = 0;
    for (int i = 0; i < _currentInstrumentIndex; i++) {
      completed += _instruments[i].questions.length;
    }
    completed += _currentQuestionIndex;
    return completed;
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _instruments[_currentInstrumentIndex].questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentInstrumentIndex < _instruments.length - 1) {
      setState(() {
        _currentInstrumentIndex++;
        _currentQuestionIndex = 0;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitSurvey();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentInstrumentIndex > 0) {
      setState(() {
        _currentInstrumentIndex--;
        _currentQuestionIndex = _instruments[_currentInstrumentIndex].questions.length - 1;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitSurvey() async {
    final provider = Provider.of<SurveyProvider>(context, listen: false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Enviando respuestas...'),
              ],
            ),
          ),
        ),
      ),
    );

    final success = await provider.submitSurvey();
    
    if (mounted) {
      Navigator.of(context).pop(); // Close loading dialog
      
      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const CompletionScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Error al enviar la encuesta'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show sociodemographic screen if index 0
      if (_currentInstrumentIndex == 0) {
      return SociodemographicScreen(
        onCompleted: () {
          setState(() {
            _currentInstrumentIndex = 1; // Move to Bergen TikTok
            _currentQuestionIndex = 0;
          });
        },
      );
    }

    final instrument = _instruments[_currentInstrumentIndex];
    final question = instrument.questions[_currentQuestionIndex];
    final progress = (_completedQuestions + 1) / _totalQuestions;

    return WillPopScope(
      onWillPop: () async {
        if (_completedQuestions > 0) {
          _previousQuestion();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: _completedQuestions > 0 ? _previousQuestion : null,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                instrument.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                instrument.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: instrument.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_completedQuestions + 1}/$_totalQuestions',
                            style: TextStyle(
                              color: instrument.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(instrument.color),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _totalQuestions,
                  itemBuilder: (context, index) {
                    return QuestionScreen(
                      question: question,
                      instrument: instrument,
                      onAnswer: (value) {
                        Provider.of<SurveyProvider>(context, listen: false)
                            .setAnswer(instrument.instrumentKey, question.id, value);
                        Future.delayed(const Duration(milliseconds: 400), () {
                          _nextQuestion();
                        });
                      },
                      currentAnswer: Provider.of<SurveyProvider>(context)
                          .getAnswer(instrument.instrumentKey, question.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstrumentData {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<Question> questions;
  final String instrumentKey;

  InstrumentData({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.questions,
    required this.instrumentKey,
  });
}