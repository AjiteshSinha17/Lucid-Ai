class RoadmapStep {
  final String id;
  final String title;
  final String description;
  final List<String> skills;
  final int estimatedHours;
  final bool isOptional;
  final List<String> prerequisites;
  final List<String> resources;

  RoadmapStep({
    required this.id,
    required this.title,
    required this.description,
    required this.skills,
    required this.estimatedHours,
    this.isOptional = false,
    this.prerequisites = const [],
    this.resources = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'skills': skills,
      'estimatedHours': estimatedHours,
      'isOptional': isOptional,
      'prerequisites': prerequisites,
      'resources': resources,
    };
  }

  factory RoadmapStep.fromJson(Map<String, dynamic> json) {
    return RoadmapStep(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      skills: List<String>.from(json['skills']),
      estimatedHours: json['estimatedHours'],
      isOptional: json['isOptional'] ?? false,
      prerequisites: List<String>.from(json['prerequisites'] ?? []),
      resources: List<String>.from(json['resources'] ?? []),
    );
  }
}

class RoadmapPhase {
  final String id;
  final String title;
  final String description;
  final List<RoadmapStep> steps;
  final int estimatedWeeks;

  RoadmapPhase({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.estimatedWeeks,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'steps': steps.map((step) => step.toJson()).toList(),
      'estimatedWeeks': estimatedWeeks,
    };
  }

  factory RoadmapPhase.fromJson(Map<String, dynamic> json) {
    return RoadmapPhase(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      steps: (json['steps'] as List)
          .map((step) => RoadmapStep.fromJson(step))
          .toList(),
      estimatedWeeks: json['estimatedWeeks'],
    );
  }
}

class DetailedRoadmapModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String category;
  final List<String> skills;
  final String officialWebsite;
  final String documentationUrl;
  final String? pdfDownloadUrl;
  final String iconUrl;
  final int estimatedHours;
  final String difficulty;
  final List<RoadmapPhase> phases;
  final List<String> careerPaths;
  final List<String> relatedRoadmaps;
  final double averageSalary;
  final String salaryRange;

  DetailedRoadmapModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.skills,
    required this.officialWebsite,
    required this.documentationUrl,
    this.pdfDownloadUrl,
    required this.iconUrl,
    required this.estimatedHours,
    required this.difficulty,
    required this.phases,
    required this.careerPaths,
    required this.relatedRoadmaps,
    required this.averageSalary,
    required this.salaryRange,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'category': category,
      'skills': skills,
      'officialWebsite': officialWebsite,
      'documentationUrl': documentationUrl,
      'pdfDownloadUrl': pdfDownloadUrl,
      'iconUrl': iconUrl,
      'estimatedHours': estimatedHours,
      'difficulty': difficulty,
      'phases': phases.map((phase) => phase.toJson()).toList(),
      'careerPaths': careerPaths,
      'relatedRoadmaps': relatedRoadmaps,
      'averageSalary': averageSalary,
      'salaryRange': salaryRange,
    };
  }

  factory DetailedRoadmapModel.fromJson(Map<String, dynamic> json) {
    return DetailedRoadmapModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      category: json['category'],
      skills: List<String>.from(json['skills']),
      officialWebsite: json['officialWebsite'],
      documentationUrl: json['documentationUrl'],
      pdfDownloadUrl: json['pdfDownloadUrl'],
      iconUrl: json['iconUrl'],
      estimatedHours: json['estimatedHours'],
      difficulty: json['difficulty'],
      phases: (json['phases'] as List)
          .map((phase) => RoadmapPhase.fromJson(phase))
          .toList(),
      careerPaths: List<String>.from(json['careerPaths']),
      relatedRoadmaps: List<String>.from(json['relatedRoadmaps']),
      averageSalary: json['averageSalary'].toDouble(),
      salaryRange: json['salaryRange'],
    );
  }
}