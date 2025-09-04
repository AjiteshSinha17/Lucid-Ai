class RoadmapModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final List<String> skills;
  final String officialWebsite;
  final String documentationUrl;
  final String? pdfDownloadUrl;
  final String iconUrl;
  final int estimatedHours;
  final String difficulty;

  RoadmapModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.skills,
    required this.officialWebsite,
    required this.documentationUrl,
    this.pdfDownloadUrl,
    required this.iconUrl,
    required this.estimatedHours,
    required this.difficulty,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      skills: List<String>.from(json['skills']),
      officialWebsite: json['officialWebsite'],
      documentationUrl: json['documentationUrl'],
      pdfDownloadUrl: json['pdfDownloadUrl'],
      iconUrl: json['iconUrl'],
      estimatedHours: json['estimatedHours'],
      difficulty: json['difficulty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'skills': skills,
      'officialWebsite': officialWebsite,
      'documentationUrl': documentationUrl,
      'pdfDownloadUrl': pdfDownloadUrl,
      'iconUrl': iconUrl,
      'estimatedHours': estimatedHours,
      'difficulty': difficulty,
    };
  }
}