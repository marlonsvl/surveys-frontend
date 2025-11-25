import '../models/question.dart';



class QuestionsData {
  static const String consentText = '''
CONSENTIMIENTO INFORMADO

Título del estudio: Evaluación de Factores Psicológicos y Uso de Redes Sociales

Estimado/a participante,

Le invitamos a participar en este estudio de investigación que tiene como objetivo evaluar diversos factores psicológicos relacionados con el uso de redes sociales y tecnología.

PROPÓSITO DEL ESTUDIO:
Esta investigación busca comprender la relación entre el uso de redes sociales, la soledad, los síntomas prefrontales y la dependencia de la inteligencia artificial conversacional.

PROCEDIMIENTO:
Su participación consistirá en responder a cinco instrumentos psicológicos validados. El tiempo estimado es de 20-30 minutos.

CONFIDENCIALIDAD:
Toda la información recopilada será tratada de manera confidencial. Los datos serán utilizados únicamente con fines de investigación y no se compartirán con terceros.

VOLUNTARIEDAD:
Su participación es completamente voluntaria. Puede retirarse del estudio en cualquier momento sin ninguna consecuencia.

BENEFICIOS:
Recibirá retroalimentación sobre sus resultados por correo electrónico.

CONTACTO:
Si tiene preguntas, puede contactarnos en: investigacion@example.com

Al continuar, usted declara que:
• Ha leído y comprendido la información proporcionada
• Acepta participar voluntariamente en este estudio
• Autoriza el uso de sus datos para fines de investigación
''';

  // 5-point scale labels for Bergen scales
  static const List<String> bergen5PointLabels = [
    'Muy raramente',
    'Raramente',
    'A veces',
    'Frecuentemente',
    'Muy frecuentemente',
  ];

  

  static List<Question> bergenTikTokQuestions = const [
    Question(
      id: 'q1_salience',
      text: 'Durante el último año, ¿con qué frecuencia has pasado mucho tiempo pensando en TikTok o planeando su uso?',
      minValue: 1, 
      maxValue: 5, 
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q2_tolerance',
      text: 'Durante el último año, ¿con qué frecuencia has sentido la necesidad de usar TikTok cada vez más?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q3_mood_modification',
      text: 'Durante el último año, ¿con qué frecuencia has usado TikTok para olvidar problemas personales?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q4_relapse',
      text: 'Durante el último año, ¿con qué frecuencia has intentado reducir el uso de TikTok sin éxito?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q5_withdrawal',
      text: 'Durante el último año, ¿con qué frecuencia te has sentido inquieto/a o molesto/a si no podías usar TikTok?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q6_conflict',
      text: 'Durante el último año, ¿con qué frecuencia el uso de TikTok ha impactado negativamente tu trabajo o estudios?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
  ];


  static List<Question> bergenInstagramQuestions = const [
    Question(
      id: 'q1_salience',
      text: 'Durante el último año, ¿con qué frecuencia has pasado mucho tiempo pensando en Instagram o planeando su uso?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q2_tolerance',
      text: 'Durante el último año, ¿con qué frecuencia has sentido la necesidad de usar Instagram cada vez más?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q3_mood_modification',
      text: 'Durante el último año, ¿con qué frecuencia has usado Instagram para olvidar problemas personales?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q4_relapse',
      text: 'Durante el último año, ¿con qué frecuencia has intentado reducir el uso de Instagram sin éxito?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q5_withdrawal',
      text: 'Durante el último año, ¿con qué frecuencia te has sentido inquieto/a o molesto/a si no podías usar Instagram?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
    Question(
      id: 'q6_conflict',
      text: 'Durante el último año, ¿con qué frecuencia el uso de Instagram ha impactado negativamente tu trabajo o estudios?',
      minValue: 1,
      maxValue: 5,
      labels: bergen5PointLabels,
    ),
  ];

  // 4-point scale labels for UCLA Loneliness
  static const List<String> ucla4PointLabels = [
    'Nunca',
    'Raramente',
    'A veces',
    'Siempre',
  ];

  static List<Question> uclaLonelinessQuestions = const [
    Question(id: 'q1', text: '¿Con qué frecuencia sientes que te falta compañía?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q2', text: '¿Con qué frecuencia te sientes excluido/a?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q3', text: '¿Con qué frecuencia te sientes aislado/a de los demás?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q4', text: '¿Con qué frecuencia te sientes solo/a?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q5', text: '¿Con qué frecuencia sientes que eres parte de un grupo de amigos?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q6', text: '¿Con qué frecuencia sientes que tienes mucho en común con las personas que te rodean?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q7', text: '¿Con qué frecuencia sientes que ya no estás cerca de nadie?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q8', text: '¿Con qué frecuencia sientes que tus intereses e ideas no son compartidos por quienes te rodean?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q9', text: '¿Con qué frecuencia te consideras una persona sociable?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q10', text: '¿Con qué frecuencia sientes que hay personas a las que te sientes cercano/a?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q11', text: '¿Con qué frecuencia te sientes abandonado/a?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q12', text: '¿Con qué frecuencia sientes que tus relaciones sociales son superficiales?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q13', text: '¿Con qué frecuencia sientes que nadie te conoce realmente bien?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q14', text: '¿Con qué frecuencia te sientes aislado/a de los demás?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q15', text: '¿Con qué frecuencia puedes encontrar compañía cuando lo deseas?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q16', text: '¿Con qué frecuencia sientes que hay personas que realmente te entienden?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q17', text: '¿Con qué frecuencia te sientes infeliz siendo tan introvertido/a?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q18', text: '¿Con qué frecuencia sientes que hay personas a tu alrededor pero no contigo?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q19', text: '¿Con qué frecuencia sientes que hay personas con las que puedes hablar?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
    Question(id: 'q20', text: '¿Con qué frecuencia sientes que hay personas a las que puedes acudir?', minValue: 1, maxValue: 4, labels: ucla4PointLabels),
  ];
  // 5-point scale (0-4) for Prefrontal Symptoms
  static const List<String> prefrontal5PointLabels = [
    'Nunca',
    'Raramente',
    'Ocasionalmente',
    'Frecuentemente',
    'Muy frecuentemente',
  ];

  static List<Question> prefrontalSymptomsQuestions = const [
    Question(id: 'q1', text: '¿Con qué frecuencia experimentas dificultad para mantener la atención en tareas o actividades?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q2', text: '¿Con qué frecuencia tienes problemas para planificar actividades o tareas complejas?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q3', text: '¿Con qué frecuencia experimentas dificultad para controlar impulsos?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q4', text: '¿Con qué frecuencia tienes problemas con la memoria de trabajo (recordar información mientras realizas una tarea)?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q5', text: '¿Con qué frecuencia experimentas dificultad para cambiar de una tarea a otra?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q6', text: '¿Con qué frecuencia tienes problemas para iniciar actividades por tu cuenta?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q7', text: '¿Con qué frecuencia experimentas dificultad para inhibir respuestas inapropiadas?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q8', text: '¿Con qué frecuencia tienes problemas con la flexibilidad mental (adaptarte a cambios)?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q9', text: '¿Con qué frecuencia experimentas dificultad para organizar información de manera lógica?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q10', text: '¿Con qué frecuencia tienes problemas para tomar decisiones?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q11', text: '¿Con qué frecuencia experimentas dificultad para resolver problemas complejos?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q12', text: '¿Con qué frecuencia tienes problemas con el control emocional?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q13', text: '¿Con qué frecuencia experimentas dificultad para mantener metas a largo plazo?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q14', text: '¿Con qué frecuencia tienes problemas con la iniciativa o motivación propia?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q15', text: '¿Con qué frecuencia experimentas dificultad para monitorear tu propia conducta?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q16', text: '¿Con qué frecuencia tienes problemas con la perseverancia en tareas difíciles?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q17', text: '¿Con qué frecuencia experimentas dificultad para evaluar las consecuencias de tus acciones?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q18', text: '¿Con qué frecuencia tienes problemas con el pensamiento abstracto?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q19', text: '¿Con qué frecuencia experimentas dificultad para secuenciar acciones de manera apropiada?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
    Question(id: 'q20', text: '¿Con qué frecuencia tienes problemas con la autorregulación de tu comportamiento?', minValue: 0, maxValue: 4, labels: prefrontal5PointLabels),
  ];

  // 5-point agreement scale for CAIDS
  static const List<String> caids5PointLabels = [
    'Totalmente en desacuerdo',
    'En desacuerdo',
    'Neutral',
    'De acuerdo',
    'Totalmente de acuerdo',
  ];

  static List<Question> caidsQuestions = const [
    Question(id: 'q1', text: 'Siento que necesito usar inteligencia artificial conversacional (como ChatGPT, Claude, etc.) regularmente.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q2', text: 'Me resulta difícil reducir el uso de IA conversacional.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q3', text: 'Uso IA conversacional más de lo que pretendía inicialmente.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q4', text: 'Me siento ansioso/a o incómodo/a cuando no puedo usar IA conversacional.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q5', text: 'Pienso en IA conversacional incluso cuando no la estoy usando.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q6', text: 'El uso de IA conversacional interfiere con mis actividades diarias.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q7', text: 'Prefiero interactuar con IA conversacional que con personas reales.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q8', text: 'Me cuesta imaginar mi vida sin IA conversacional.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q9', text: 'He intentado reducir el uso de IA conversacional sin éxito.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q10', text: 'Siento que dependo emocionalmente de la IA conversacional.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q11', text: 'El uso de IA conversacional ha afectado negativamente mis relaciones personales.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q12', text: 'Me siento más cómodo/a hablando con IA conversacional que con personas.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
    Question(id: 'q13', text: 'Necesito usar IA conversacional cada vez con más frecuencia para sentirme satisfecho/a.', minValue: 1, maxValue: 5, labels: caids5PointLabels),
  ];

  
}