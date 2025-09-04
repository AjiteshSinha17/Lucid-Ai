import 'package:flutter/material.dart';
// Removed unused import '../models/roadmap_model.dart'
import '../models/detailed_roadmap_model.dart';

class RoadmapService extends ChangeNotifier {
  final List<DetailedRoadmapModel> _detailedRoadmaps = [];
  final List<DetailedRoadmapModel> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';

  // Enhanced keyword mapping for comprehensive detection
  static const Map<String, List<String>> _roadmapKeywords = {
    'frontend': [
      'frontend',
      'front-end',
      'front end',
      'web development',
      'web dev',
      'html',
      'css',
      'javascript',
      'js',
      'typescript',
      'ts',
      'react',
      'vue',
      'angular',
      'svelte',
      'nextjs',
      'nuxt',
      'client-side',
      'ui development',
      'user interface',
      'responsive design',
      'web design'
    ],
    'backend': [
      'backend',
      'back-end',
      'back end',
      'server-side',
      'server development',
      'nodejs',
      'node.js',
      'express',
      'fastapi',
      'django',
      'flask',
      'spring boot',
      'laravel',
      'php',
      'asp.net',
      'api development',
      'rest api',
      'graphql',
      'microservices',
      'database',
      'sql'
    ],
    'android': [
      'android',
      'android development',
      'mobile development',
      'app development',
      'kotlin',
      'java',
      'android studio',
      'gradle',
      'jetpack compose',
      'android ui',
      'mobile app',
      'play store'
    ],
    'ios': [
      'ios',
      'ios development',
      'iphone',
      'ipad',
      'swift',
      'swiftui',
      'xcode',
      'objective-c',
      'app store',
      'mobile development'
    ],
    'flutter': [
      'flutter',
      'dart',
      'mobile development',
      'app development',
      'cross-platform',
      'flutter app',
      'flutter development',
      'mobile ui'
    ],
    'devops': [
      'devops',
      'dev ops',
      'ci/cd',
      'continuous integration',
      'deployment',
      'docker',
      'kubernetes',
      'k8s',
      'jenkins',
      'terraform',
      'ansible',
      'infrastructure',
      'cloud deployment',
      'automation',
      'monitoring'
    ],
    'data-scientist': [
      'data scientist',
      'data science',
      'machine learning',
      'ml',
      'ai',
      'python',
      'r',
      'jupyter',
      'pandas',
      'numpy',
      'scikit-learn'
    ],
    'cybersecurity': [
      'cybersecurity',
      'cyber security',
      'security',
      'ethical hacking',
      'penetration testing',
      'pen testing',
      'information security',
      'network security',
      'web security',
      'cryptography',
      'owasp'
    ],
  };

  List<DetailedRoadmapModel> get detailedRoadmaps => _detailedRoadmaps;
  List<DetailedRoadmapModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  RoadmapService() {
    _initializeDetailedRoadmaps();
  }

  void _initializeDetailedRoadmaps() {
    _detailedRoadmaps.addAll([
      // Android Development
      DetailedRoadmapModel(
        id: 'android',
        title: 'Android Development',
        subtitle: 'Mobile App Development',
        description:
            'Learn to build native Android applications using Kotlin and modern Android development practices',
        category: 'Mobile Development',
        skills: [
          'Kotlin',
          'Java',
          'Android SDK',
          'Jetpack Compose',
          'Room Database'
        ],
        officialWebsite: 'https://developer.android.com/',
        documentationUrl: 'https://developer.android.com/docs',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/android.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/android.png',
        estimatedHours: 200,
        difficulty: 'Intermediate',
        careerPaths: ['Mobile Developer', 'Android Engineer'],
        relatedRoadmaps: ['kotlin', 'java', 'flutter'],
        averageSalary: 95000,
        salaryRange: '70k - 130k',
        phases: [
          RoadmapPhase(
            id: 'fundamentals',
            title: 'The Fundamentals',
            description: 'Learn the basics of Android development',
            estimatedWeeks: 4,
            steps: [
              RoadmapStep(
                id: 'pick-language',
                title: 'Pick a Language',
                description: 'Choose between Kotlin (recommended) or Java',
                skills: ['Kotlin', 'Java'],
                estimatedHours: 20,
                resources: ['https://kotlinlang.org/'],
              ),
            ],
          ),
        ],
      ),

      // Frontend Development
      DetailedRoadmapModel(
        id: 'frontend',
        title: 'Frontend Development',
        subtitle: 'Client-Side Web Development',
        description:
            'Master modern frontend development with HTML, CSS, JavaScript, and popular frameworks',
        category: 'Web Development',
        skills: ['HTML', 'CSS', 'JavaScript', 'React', 'Vue.js', 'TypeScript'],
        officialWebsite: 'https://developer.mozilla.org/en-US/docs/Web',
        documentationUrl: 'https://developer.mozilla.org/en-US/docs/Web/Guide',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/frontend.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/frontend.png',
        estimatedHours: 180,
        difficulty: 'Beginner',
        careerPaths: ['Frontend Developer', 'UI Developer'],
        relatedRoadmaps: ['javascript', 'react', 'vue'],
        averageSalary: 85000,
        salaryRange: '60k - 120k',
        phases: [],
      ),

      // Backend Development
      DetailedRoadmapModel(
        id: 'backend',
        title: 'Backend Development',
        subtitle: 'Server-Side Development',
        description:
            'Build robust server-side applications, APIs, and databases',
        category: 'Web Development',
        skills: ['Node.js', 'Express', 'Python', 'Django', 'PostgreSQL'],
        officialWebsite: 'https://nodejs.org/',
        documentationUrl: 'https://expressjs.com/',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/backend.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/backend.png',
        estimatedHours: 220,
        difficulty: 'Intermediate',
        careerPaths: ['Backend Developer', 'API Developer'],
        relatedRoadmaps: ['nodejs', 'python', 'database'],
        averageSalary: 92000,
        salaryRange: '70k - 140k',
        phases: [],
      ),

      // Flutter Development
      DetailedRoadmapModel(
        id: 'flutter',
        title: 'Flutter Development',
        subtitle: 'Cross-Platform Mobile',
        description:
            'Build beautiful native applications for mobile, web, and desktop with Flutter',
        category: 'Mobile Development',
        skills: ['Dart', 'Flutter', 'Firebase', 'State Management'],
        officialWebsite: 'https://flutter.dev/',
        documentationUrl: 'https://docs.flutter.dev/',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/flutter.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/flutter.png',
        estimatedHours: 180,
        difficulty: 'Beginner',
        careerPaths: ['Flutter Developer', 'Mobile Engineer'],
        relatedRoadmaps: ['dart', 'firebase'],
        averageSalary: 88000,
        salaryRange: '65k - 125k',
        phases: [],
      ),

      // iOS Development
      DetailedRoadmapModel(
        id: 'ios',
        title: 'iOS Development',
        subtitle: 'Native iOS Apps',
        description: 'Build native iOS applications using Swift and SwiftUI',
        category: 'Mobile Development',
        skills: ['Swift', 'SwiftUI', 'UIKit', 'Xcode'],
        officialWebsite: 'https://developer.apple.com/',
        documentationUrl: 'https://developer.apple.com/documentation/',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/ios.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/ios.png',
        estimatedHours: 200,
        difficulty: 'Intermediate',
        careerPaths: ['iOS Developer', 'Mobile Engineer'],
        relatedRoadmaps: ['swift'],
        averageSalary: 98000,
        salaryRange: '75k - 135k',
        phases: [],
      ),

      // DevOps
      DetailedRoadmapModel(
        id: 'devops',
        title: 'DevOps Engineering',
        subtitle: 'Infrastructure & Deployment',
        description:
            'Learn CI/CD, containerization, cloud platforms, and automation tools',
        category: 'DevOps',
        skills: ['Docker', 'Kubernetes', 'AWS', 'Jenkins', 'Terraform'],
        officialWebsite: 'https://aws.amazon.com/',
        documentationUrl: 'https://docs.docker.com/',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/devops.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/devops.png',
        estimatedHours: 280,
        difficulty: 'Advanced',
        careerPaths: ['DevOps Engineer', 'Site Reliability Engineer'],
        relatedRoadmaps: ['aws', 'docker', 'kubernetes'],
        averageSalary: 110000,
        salaryRange: '85k - 160k',
        phases: [],
      ),

      // Data Science
      DetailedRoadmapModel(
        id: 'data-scientist',
        title: 'Data Science',
        subtitle: 'ML & Analytics',
        description: 'Master machine learning, statistics, and data analysis',
        category: 'AI/ML',
        skills: ['Python', 'R', 'Machine Learning', 'Statistics'],
        officialWebsite: 'https://www.python.org/',
        documentationUrl: 'https://scikit-learn.org/',
        pdfDownloadUrl:
            'https://roadmap.sh/pdfs/roadmaps/ai-data-scientist.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/ai-data-scientist.png',
        estimatedHours: 350,
        difficulty: 'Advanced',
        careerPaths: ['Data Scientist', 'ML Engineer'],
        relatedRoadmaps: ['python', 'machine-learning'],
        averageSalary: 120000,
        salaryRange: '90k - 180k',
        phases: [],
      ),

      // Cybersecurity
      DetailedRoadmapModel(
        id: 'cybersecurity',
        title: 'Cybersecurity',
        subtitle: 'Information Security',
        description:
            'Learn ethical hacking, security auditing, and threat analysis',
        category: 'Security',
        skills: ['Network Security', 'Penetration Testing', 'Cryptography'],
        officialWebsite: 'https://owasp.org/',
        documentationUrl: 'https://www.sans.org/',
        pdfDownloadUrl: 'https://roadmap.sh/pdfs/roadmaps/cyber-security.pdf',
        iconUrl: 'https://roadmap.sh/assets/roadmaps/cyber-security.png',
        estimatedHours: 320,
        difficulty: 'Advanced',
        careerPaths: ['Security Analyst', 'Ethical Hacker'],
        relatedRoadmaps: ['networking', 'linux'],
        averageSalary: 98000,
        salaryRange: '75k - 140k',
        phases: [],
      ),
    ]);
  }

  // Enhanced roadmap detection
  bool isRoadmapQuery(String query) {
    final lowercaseQuery = query.toLowerCase();

    final learningContexts = [
      'roadmap',
      'learning path',
      'career path',
      'how to learn',
      'guide to',
      'tutorial',
      'course',
      'beginner guide',
      'from scratch',
      'mastering',
      'becoming a',
      'career in',
      'job ready',
      'step by step'
    ];

    bool hasLearningContext =
        learningContexts.any((context) => lowercaseQuery.contains(context));

    bool hasTechnologyKeyword = _roadmapKeywords.values.any((keywords) =>
        keywords
            .any((keyword) => lowercaseQuery.contains(keyword.toLowerCase())));

    return hasLearningContext || hasTechnologyKeyword;
  }

  String generateDetailedRoadmapResponse(String query) {
    final lowercaseQuery = query.toLowerCase();
    final matchingRoadmaps = <DetailedRoadmapModel>[];

    for (final roadmap in _detailedRoadmaps) {
      final keywords = _roadmapKeywords[roadmap.id] ?? [];
      if (keywords.any((keyword) => lowercaseQuery.contains(keyword))) {
        matchingRoadmaps.add(roadmap);
      }
    }

    if (matchingRoadmaps.isEmpty) {
      return _generateAllRoadmapsResponse();
    }

    final bestMatch = matchingRoadmaps.first;
    return _generateStructuredRoadmapResponse(bestMatch);
  }

  String _generateStructuredRoadmapResponse(DetailedRoadmapModel roadmap) {
    return '''# 🎯 ${roadmap.title} Complete Roadmap

**${roadmap.subtitle}** | ${roadmap.difficulty} Level | ${roadmap.estimatedHours}+ hours

${roadmap.description}

## 💰 Career Information
• **Average Salary:** \$${roadmap.averageSalary.toStringAsFixed(0)}/year (${roadmap.salaryRange})
• **Career Paths:** ${roadmap.careerPaths.join(', ')}
• **Related Skills:** ${roadmap.skills.join(', ')}

## 🔗 Essential Resources

### 📚 Official Documentation
[📖 ${roadmap.title} Documentation](${roadmap.documentationUrl})

### 🌐 Official Website
[🏠 Visit Official Site](${roadmap.officialWebsite})

### 📄 Complete Roadmap PDF
[📋 Download PDF Guide](${roadmap.pdfDownloadUrl ?? 'Coming Soon'})

Ready to start your ${roadmap.title} journey? 🚀''';
  }

  String _generateAllRoadmapsResponse() {
    return '''🗺️ **Available Developer Roadmaps** (${_detailedRoadmaps.length} Total)

## 🎯 Role-based Roadmaps

### 💻 Web Development
• **Frontend Developer** - HTML, CSS, JavaScript, React
• **Backend Developer** - APIs, Databases, Server-side

### 📱 Mobile Development
• **Android Developer** - Native Android with Kotlin
• **iOS Developer** - Native iOS with Swift
• **Flutter Developer** - Cross-platform with Dart

### 🤖 AI & Data
• **Data Scientist** - ML, Statistics, Python

### ☁️ Infrastructure
• **DevOps Engineer** - CI/CD, Docker, Kubernetes

### 🔐 Security
• **Cybersecurity** - Ethical Hacking, Security

Which career path interests you most? I'll provide the complete roadmap! 🎯''';
  }

  Future<void> searchRoadmaps(String query) async {
    _setLoading(true);
    _searchQuery = query;

    await Future.delayed(const Duration(milliseconds: 300));

    _searchResults.clear();

    if (query.isEmpty) {
      _searchResults.addAll(_detailedRoadmaps);
    } else {
      final lowercaseQuery = query.toLowerCase();
      _searchResults.addAll(_detailedRoadmaps.where((roadmap) {
        final keywords = _roadmapKeywords[roadmap.id] ?? [];
        return roadmap.title.toLowerCase().contains(lowercaseQuery) ||
            roadmap.description.toLowerCase().contains(lowercaseQuery) ||
            roadmap.category.toLowerCase().contains(lowercaseQuery) ||
            keywords.any((keyword) => keyword.contains(lowercaseQuery)) ||
            roadmap.skills
                .any((skill) => skill.toLowerCase().contains(lowercaseQuery));
      }));
    }

    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  DetailedRoadmapModel? getDetailedRoadmapById(String id) {
    try {
      return _detailedRoadmaps.firstWhere((roadmap) => roadmap.id == id);
    } catch (e) {
      return null;
    }
  }

  List<String> getAllCategories() {
    return _detailedRoadmaps
        .map((roadmap) => roadmap.category)
        .toSet()
        .toList();
  }
}
