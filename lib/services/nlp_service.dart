// ignore_for_file: avoid_print

class NLPService {
  // Intent detection patterns
  static const Map<String, List<String>> _intentPatterns = {
    'greeting': [
      'hello',
      'hi',
      'hey',
      'good morning',
      'good afternoon',
      'good evening',
      'greetings',
      'howdy',
      "what's up",
      'sup'
    ],
    'roadmap_request': [
      'roadmap',
      'learning path',
      'guide',
      'how to learn',
      'tutorial',
      'course',
      'curriculum',
      'study plan',
      'career path'
    ],
    'career_question': [
      'salary',
      'job',
      'career',
      'employment',
      'work',
      'profession',
      'opportunity',
      'hiring',
      'interview'
    ],
    'help_request': [
      'help',
      'assist',
      'support',
      'explain',
      'what is',
      'how does',
      'can you',
      'please help'
    ],
    'technology_question': [
      'programming',
      'coding',
      'development',
      'framework',
      'language',
      'library',
      'tool',
      'technology',
      'software'
    ]
  };

  // Extract intent from user message
  static String detectIntent(String message) {
    final lowerMessage = message.toLowerCase();

    for (final intent in _intentPatterns.keys) {
      final patterns = _intentPatterns[intent]!;
      if (patterns.any((pattern) => lowerMessage.contains(pattern))) {
        return intent;
      }
    }

    return 'general_question';
  }

  // Extract entities (technologies, topics) from message
  static List<String> extractEntities(String message) {
    final lowerMessage = message.toLowerCase();
    final entities = <String>[];

    // Common technologies and frameworks
    final technologies = [
      'javascript',
      'python',
      'java',
      'react',
      'angular',
      'vue',
      'nodejs',
      'flutter',
      'swift',
      'kotlin',
      'android',
      'ios',
      'html',
      'css',
      'typescript',
      'php',
      'ruby',
      'go',
      'rust',
      'django',
      'flask',
      'spring',
      'express',
      'laravel',
      'docker',
      'kubernetes',
      'aws',
      'azure',
      'gcp',
      'tensorflow',
      'pytorch',
      'scikit-learn',
      'pandas',
      'numpy'
    ];

    for (final tech in technologies) {
      if (lowerMessage.contains(tech)) {
        entities.add(tech);
      }
    }

    return entities;
  }

  // Clean and normalize user input
  static String cleanInput(String input) {
    return input
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ') // Multiple spaces to single
        .replaceAll(RegExp(r'[^\w\s.,!?]'), ''); // Remove special chars
  }

  // Generate context-aware suggestions
  static List<String> getSuggestions(String intent, List<String> entities) {
    switch (intent) {
      case 'roadmap_request':
        return [
          'Show me frontend development roadmap',
          'How to become a mobile developer?',
          'Data science learning path',
          'DevOps career guidance'
        ];
      case 'career_question':
        return [
          'What is the average salary for a Flutter developer?',
          'Backend developer job opportunities',
          'How to prepare for technical interviews?',
          'Career transition to AI/ML field'
        ];
      case 'technology_question':
        if (entities.contains('react')) {
          return [
            'React vs Vue comparison',
            'React Native mobile development',
            'React best practices',
            'React job market trends'
          ];
        }
        return [
          'Popular programming languages in 2024',
          'Best frameworks for web development',
          'Cloud computing platforms comparison',
          'AI/ML tools for beginners'
        ];
      default:
        return [
          'Explore developer roadmaps',
          'Get career guidance',
          'Learn about technologies',
          'Find learning resources'
        ];
    }
  }

  // Sentiment analysis (basic)
  static double analyzeSentiment(String message) {
    final lowerMessage = message.toLowerCase();

    final positiveWords = [
      'good',
      'great',
      'excellent',
      'amazing',
      'wonderful',
      'fantastic',
      'love',
      'like',
      'enjoy',
      'happy',
      'pleased',
      'satisfied'
    ];

    final negativeWords = [
      'bad',
      'terrible',
      'awful',
      'horrible',
      'hate',
      'dislike',
      'frustrated',
      'angry',
      'disappointed',
      'confused',
      'difficult'
    ];

    int positiveCount = 0;
    int negativeCount = 0;

    for (final word in positiveWords) {
      if (lowerMessage.contains(word)) positiveCount++;
    }

    for (final word in negativeWords) {
      if (lowerMessage.contains(word)) negativeCount++;
    }

    // Return sentiment score (-1 to 1)
    final totalWords = positiveCount + negativeCount;
    if (totalWords == 0) return 0.0;

    return (positiveCount - negativeCount) / totalWords;
  }
}
