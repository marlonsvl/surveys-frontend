import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/survey_provider.dart';

class SociodemographicScreen extends StatefulWidget {
  final VoidCallback onCompleted;
  
  const SociodemographicScreen({super.key, required this.onCompleted});

  @override
  State<SociodemographicScreen> createState() => _SociodemographicScreenState();
}

class _SociodemographicScreenState extends State<SociodemographicScreen> {
  final _formKey = GlobalKey<FormState>();
  late PageController _pageController;
  int _currentQuestion = 0;

  final List<String> questions = [
    'País',
    'Edad',
    'Género',
    'Con quién vive',
    'Universidad',
    'Carrera y Ciclo',
    'Estado civil',
    'Educación de la madre',
    'Educación del padre',
    'Edad de la madre',
    'Edad del padre',
    'Promedio académico',
    'Ha repetido ciclos',
    'Sector de residencia',
    'Nivel socioeconómico',
    'Fuentes de ingreso',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    if (!_validateCurrentQuestion()) {
    _showValidationError();
    return;
  }
    
    
    if (_currentQuestion < questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showValidationError() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Por favor completa la pregunta antes de continuar."),
      backgroundColor: Colors.red,
    ),
  );
}


  void _previousQuestion() {
    if (_currentQuestion > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentQuestion() {
  final provider = Provider.of<SurveyProvider>(context, listen: false);
  print('current question: $_currentQuestion'); // DEBUG
  switch (_currentQuestion) {
    
    case 0: // Edad
      final age = provider.response.sociodemographicData.age;
      return age != null && age > 0 && age < 120; // VALIDATE HERE

    case 1: // Género
      return provider.response.sociodemographicData.gender?.isNotEmpty ?? false;

    case 2: // Con quién vive
      return provider.response.sociodemographicData.livingWith?.isNotEmpty ?? false;

    case 3: // Universidad
      return provider.response.sociodemographicData.university?.isNotEmpty ?? false;

    case 4: // Carrera y ciclo
      return provider.response.sociodemographicData.career?.isNotEmpty == true &&
             provider.response.sociodemographicData.currentSemester?.isNotEmpty == true;

    case 5: // Estado civil
      return provider.response.sociodemographicData.maritalStatus?.isNotEmpty ?? false;

    case 6: // Educación madre
      return provider.response.sociodemographicData.motherEducationLevel?.isNotEmpty == true;
    case 7: // Educación padre
      return provider.response.sociodemographicData.fatherEducationLevel?.isNotEmpty == true;
      
    case 8: // Edad madre
      final motherAge = provider.response.sociodemographicData.motherAge;
      return motherAge != null && motherAge > 10 && motherAge < 120;
    case 9: // Edad padre
      final fatherAge = provider.response.sociodemographicData.fatherAge;
      return fatherAge != null && fatherAge > 10 && fatherAge < 120;
    case 10: // Promedio académico
      final gpa = provider.response.sociodemographicData.gpaLastSemester;
      return gpa != null && gpa >= 0.0 && gpa <= 10.0;
    case 11: // Ha repetido ciclos
      return 
             (provider.response.sociodemographicData.repeatedCycles == false ||
              (provider.response.sociodemographicData.repeatedCycles == true &&
               (provider.response.sociodemographicData.repeatedCyclesCount != null &&
                provider.response.sociodemographicData.repeatedCyclesCount! > 0)));
    case 12: // Sector de residencia
      return provider.response.sociodemographicData.residenceSector?.isNotEmpty ?? true;
    case 13: // Nivel socioeconómico
      return provider.response.sociodemographicData.socioeconomicLevel?.isNotEmpty ?? true;
    case 14: // Fuentes de ingreso
      final sources = provider.response.sociodemographicData.incomeSources;
      return sources != null && sources.isNotEmpty;

    default:
      return true;
  }
}


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SurveyProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: _currentQuestion > 0 ? _previousQuestion : null,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Datos Demográficos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Pregunta ${_currentQuestion + 1} de ${questions.length}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (_currentQuestion + 1) / questions.length,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentQuestion = index;
                  });
                },
                children: [
                  //_buildQuestion1(), // País
                  _buildQuestion2(), // Edad
                  _buildQuestion3(), // Género
                  _buildQuestion4(), // Con quién vive
                  _buildQuestion5(), // Universidad
                  _buildQuestion6(), // Carrera y Ciclo
                  _buildQuestion7(), // Estado civil
                  _buildQuestion8(), // Educación madre
                  _buildQuestion9(), // Educación padre
                  _buildQuestion10(), // Edad madre
                  _buildQuestion11(), // Edad padre
                  _buildQuestion12(), // Promedio
                  _buildQuestion13(), // Ciclos repetidos
                  _buildQuestion14(), // Sector residencia
                  _buildQuestion15(), // Nivel socioeconómico
                  _buildQuestion16(), // Fuentes ingreso
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual question widgets
  /*Widget _buildQuestion1() => _buildChoiceQuestion(
    'País',
    ['Ecuador', 'Chile'],
    //(value) => Provider.of<SurveyProvider>(context, listen: false).setCountry(value),
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = const {'Ecuador': 'EC', 'Chile': 'CL'}[selected];
      provider.setGender(code!);
    },
  );*/

  /*
  Widget _buildQuestion2() => _buildNumberQuestion(
    'Edad',
    'Ingresa tu edad',
    (value) => Provider.of<SurveyProvider>(context, listen: false).setAge(int.parse(value)),
  );*/

  Widget _buildQuestion2() {
    final provider = Provider.of<SurveyProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edad',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          DropdownButtonFormField<int>(
            value: provider.response.sociodemographicData.age,
            decoration: InputDecoration(
              labelText: 'Selecciona tu edad',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: List.generate(
              83, // 18 to 100 inclusive
              (i) => DropdownMenuItem(
                value: 18 + i,
                child: Text((18 + i).toString()),
              ),
            ),
            onChanged: (value) {
              provider.setAge(value!);
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildQuestion3() => _buildChoiceQuestion(
    'Género',
    ['Masculino', 'Femenino', 'Otro'],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = const {'Masculino': 'M', 'Femenino': 'F', 'Otro': 'O'}[selected];
      provider.setGender(code!);
      if (selected == 'Otro') {
        _showOtherDialog('Especifica tu género', 'gender');
      }
    },
  );

  Widget _buildQuestion4() => _buildChoiceQuestion(
    'Con quién vives',
    [
      'Solo/a',
      'Con mamá',
      'Con papá',
      'Con ambos padres',
      'Con padres y hermanos',
      'Con padres, hermanos y abuelos',
      'Con padres, hermanos, abuelos y tíos',
      'Otros',
    ],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = {
        'Solo/a': 'alone',
        'Con mamá': 'mother',
        'Con papá': 'father',
        'Con ambos padres': 'both_parents',
        'Con padres y hermanos': 'parents_siblings',
        'Con padres, hermanos y abuelos': 'parents_siblings_grandparents',
        'Con padres, hermanos, abuelos y tíos': 'extended_family',
        'Otros': 'other',
      }[selected];
      provider.setLivingWith(code!);
      if (selected == 'Otros') {
        _showOtherDialog('Especifica tu situación', 'livingWith');
      }
    },
  );

  Widget _buildQuestion5() => _buildTextQuestion(
    'Universidad',
    'Nombre de la universidad',
    (value) => Provider.of<SurveyProvider>(context, listen: false).setUniversity(value),
  );
  /*
  Widget _buildQuestion6() {
    final provider = Provider.of<SurveyProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Carrera y Ciclo/Semestre',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Carrera',
              labelText: 'Carrera',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) => provider.setCareer(value),
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: 'Ciclo/Semestre',
              labelText: 'Ciclo/Semestre',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) => provider.setCurrentSemester(value),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _buildQuestion6() {
  final provider = Provider.of<SurveyProvider>(context);

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Carrera y Ciclo/Semestre',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // Carrera TextField
        TextField(
          decoration: InputDecoration(
            hintText: 'Carrera',
            labelText: 'Carrera',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (value) => provider.setCareer(value),
        ),

        const SizedBox(height: 15),

        // Semestre Dropdown (1–12)
        DropdownButtonFormField<String>(
          initialValue: provider.response.sociodemographicData.currentSemester?.isNotEmpty == true
              ? provider.response.sociodemographicData.currentSemester
              : null,
          decoration: InputDecoration(
            labelText: 'Ciclo/Semestre',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: List.generate(
            12,
            (i) => DropdownMenuItem<String>(
              value: (i + 1).toString(),
              child: Text('Semestre ${i + 1}'),
            ),
          ),
          onChanged: (value) {
            provider.setCurrentSemester(value ?? '');
          },
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Continuar'),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildQuestion7() => _buildChoiceQuestion(
    'Estado civil',
    ['Soltero/a', 'Casado/a', 'Unión libre', 'Divorciado/a', 'Viudo/a', 'Separado/a'],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = {
        'Soltero/a': 'single',
        'Casado/a': 'married',
        'Unión libre': 'free_union',
        'Divorciado/a': 'divorced',
        'Viudo/a': 'widowed',
        'Separado/a': 'separated',
      }[selected];
      provider.setMaritalStatus(code!);
    },
  );

  
  Widget _buildQuestion8() => _buildChoiceQuestion(
    'Nivel de estudios de la madre',
    ['Ninguno', 'Primaria', 'Secundaria', 'Superior', 'Postgrado'],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = {
        'Ninguno': 'none',
        'Primaria': 'primary',
        'Secundaria': 'secondary',
        'Superior': 'college',
        'Postgrado': 'postgraduate',
      }[selected];
      provider.setMotherEducationLevel(code!);
    },
  );

  Widget _buildQuestion9() => _buildChoiceQuestion(
    'Nivel de estudios del padre',
    ['Ninguno', 'Primaria', 'Secundaria', 'Superior', 'Postgrado'],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = {
        'Ninguno': 'none',
        'Primaria': 'primary',
        'Secundaria': 'secondary',
        'Superior': 'college',
        'Postgrado': 'postgraduate',
      }[selected];
      provider.setFatherEducationLevel(code!);
    },
  );

  /*Widget _buildQuestion10() => _buildNumberQuestion(
    'Edad de la madre',
    'Ingresa la edad',
    (value) => Provider.of<SurveyProvider>(context, listen: false).setMotherAge(int.parse(value)),
  );*/

  Widget _buildQuestion10() {
  final provider = Provider.of<SurveyProvider>(context);

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edad de la madre',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        DropdownButtonFormField<int>(
          value: provider.response.sociodemographicData.motherAge,
          decoration: InputDecoration(
            labelText: 'Selecciona la edad',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: List.generate(
            83, // 18 to 100 inclusive
            (i) => DropdownMenuItem(
              value: 18 + i,
              child: Text((18 + i).toString()),
            ),
          ),
          onChanged: (value) {
            provider.setMotherAge(value!);
          },
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Continuar'),
          ),
        ),
      ],
    ),
  );
}




  /*Widget _buildQuestion11() => _buildNumberQuestion(
    'Edad del padre',
    'Ingresa la edad',
    (value) => Provider.of<SurveyProvider>(context, listen: false).setFatherAge(int.parse(value)),
  );*/
  Widget _buildQuestion11() {
  final provider = Provider.of<SurveyProvider>(context);

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edad del padre',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        DropdownButtonFormField<int>(
          value: provider.response.sociodemographicData.fatherAge,
          decoration: InputDecoration(
            labelText: 'Selecciona la edad',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: List.generate(
            83, // 18 to 100 inclusive
            (i) => DropdownMenuItem(
              value: 18 + i,
              child: Text((18 + i).toString()),
            ),
          ),
          onChanged: (value) {
            provider.setFatherAge(value!);
          },
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Continuar'),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildQuestion12() => _buildNumberQuestion(
    'Promedio general del último semestre/ciclo',
    'Ingresa el promedio',
    (value) => Provider.of<SurveyProvider>(context, listen: false)
        .setGpaLastSemester(double.parse(value)),
    isDecimal: true,
  );


/*
  Widget _buildQuestion13() {
    final provider = Provider.of<SurveyProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¿Ha repetido algún semestre/ciclo?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              
              Expanded( 
                child: 
                CheckboxListTile( 
                  title: const Text('Sí'), 
                  value: provider.response.sociodemographicData.repeatedCycles ?? false, 
                  onChanged: (value) { 
                    provider.setRepeatedCycles(value ?? false); 
                  }, 
                ), 
              ), 
              Expanded( 
                child: CheckboxListTile( 
                  title: const Text('No'), 
                  value: !(provider.response.sociodemographicData.repeatedCycles ?? false), 
                  onChanged: (value) { 
                    provider.setRepeatedCycles(!(value ?? false));
                    
                    }, 
                  ), 
              ),
            ],
          ),
          if (provider.response.sociodemographicData.repeatedCycles ?? false) ...[
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: 'Número de ciclos',
                labelText: 'Cuántos ciclos repetidos',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  provider.setRepeatedCyclesCount(int.parse(value));
                }
              },
            ),
          ],
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }
  */
  Widget _buildQuestion13() {
  final provider = Provider.of<SurveyProvider>(context);
  final repeatedCycles = provider.response.sociodemographicData.repeatedCycles;
  
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Ha repetido algún semestre/ciclo?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: const Text('Sí'),
                value: true,
                groupValue: repeatedCycles,
                onChanged: (value) {
                  provider.setRepeatedCycles(value ?? false);
                },
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: const Text('No'),
                value: false,
                groupValue: repeatedCycles,
                onChanged: (value) {
                  provider.setRepeatedCycles(value ?? false);
                },
              ),
            ),
          ],
        ),
        if (repeatedCycles == true) ...[
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: 'Número de ciclos',
              labelText: 'Cuántos ciclos repetidos',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                provider.setRepeatedCyclesCount(int.parse(value));
              }
            },
          ),
        ],
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Continuar'),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildQuestion14() => _buildChoiceQuestion(
    'Sector de residencia',
    ['Urbano', 'Rural'],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = {'Urbano': 'urban', 'Rural': 'rural'}[selected];
      provider.setResidenceSector(code!);
    },
  );

  Widget _buildQuestion15() => _buildChoiceQuestion(
    'Nivel socioeconómico percibido',
    ['Alto', 'Medio', 'Bajo'],
    (selected) {
      final provider = Provider.of<SurveyProvider>(context, listen: false);
      final code = {'Alto': 'high', 'Medio': 'medium', 'Bajo': 'low'}[selected];
      provider.setSocioeconomicLevel(code!);
    },
  );

  Widget _buildQuestion16() {
    final provider = Provider.of<SurveyProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fuentes principales de ingreso económico',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text('Trabajo'),
            value: provider.response.sociodemographicData.incomeSources?.contains('Trabajo') ?? false,
            onChanged: (value) {
              final sources = provider.response.sociodemographicData.incomeSources ?? [];
              if (value ?? false) {
                sources.add('Trabajo');
              } else {
                sources.remove('Trabajo');
              }
              provider.setIncomeSources(sources);
            },
          ),
          CheckboxListTile(
            title: const Text('Apoyo familiar'),
            value: provider.response.sociodemographicData.incomeSources?.contains('Apoyo familiar') ?? false,
            onChanged: (value) {
              final sources = provider.response.sociodemographicData.incomeSources ?? [];
              if (value ?? false) {
                sources.add('Apoyo familiar');
              } else {
                sources.remove('Apoyo familiar');
              }
              provider.setIncomeSources(sources);
            },
          ),
          CheckboxListTile(
            title: const Text('Beca'),
            value: provider.response.sociodemographicData.incomeSources?.contains('Beca') ?? false,
            onChanged: (value) {
              final sources = provider.response.sociodemographicData.incomeSources ?? [];
              if (value ?? false) {
                sources.add('Beca');
              } else {
                sources.remove('Beca');
              }
              provider.setIncomeSources(sources);
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
                widget.onCompleted();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildTextQuestion(String title, String hint, Function(String) onChanged) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: onChanged,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberQuestion(String title, String hint, Function(String) onChanged,
      {bool isDecimal = false}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            keyboardType: isDecimal ? TextInputType.number : TextInputType.number,
            onChanged: onChanged,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceQuestion(String title, List<String> options, Function(String) onSelected) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onSelected(option);
                    _nextQuestion();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(option),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOtherDialog(String title, String field) {
    showDialog(
      context: context,
      builder: (context) {
        String? value;
        return AlertDialog(
          title: Text(title),
          content: TextField(
            onChanged: (v) => value = v,
            decoration: InputDecoration(
              hintText: 'Especifica',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (field == 'gender') {
                  Provider.of<SurveyProvider>(context, listen: false)
                      .setGenderOther(value ?? '');
                } else if (field == 'livingWith') {
                  Provider.of<SurveyProvider>(context, listen: false)
                      .setLivingWithOther(value ?? '');
                }
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}