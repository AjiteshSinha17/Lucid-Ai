import 'package:uuid/uuid.dart';

enum MessageType { user, ai, system, roadmap }

class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isMarkdown;
  final Map<String, dynamic>? metadata;

  ChatMessage({
    String? id,
    required this.content,
    required this.type,
    DateTime? timestamp,
    this.isMarkdown = false,
    this.metadata,
  }) : id = id ?? const Uuid().v4(),
       timestamp = timestamp ?? DateTime.now();

  factory ChatMessage.user(String content) {
    return ChatMessage(
      content: content,
      type: MessageType.user,
    );
  }

  factory ChatMessage.ai(String content, {bool isMarkdown = false}) {
    return ChatMessage(
      content: content,
      type: MessageType.ai,
      isMarkdown: isMarkdown,
    );
  }

  factory ChatMessage.roadmap(String content) {
    return ChatMessage(
      content: content,
      type: MessageType.roadmap,
      isMarkdown: true,
    );
  }

  factory ChatMessage.system(String content) {
    return ChatMessage(
      content: content,
      type: MessageType.system,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'isMarkdown': isMarkdown,
      'metadata': metadata,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      content: json['content'],
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.ai,
      ),
      timestamp: DateTime.parse(json['timestamp']),
      isMarkdown: json['isMarkdown'] ?? false,
      metadata: json['metadata'],
    );
  }
}