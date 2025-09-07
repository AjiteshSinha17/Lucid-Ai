import '../models/chat_message.dart';

class AiState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool autoScroll;

  const AiState({
    this.messages = const [],
    this.isLoading = false,
    this.autoScroll = true,
  });

  AiState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? autoScroll,
  }) {
    return AiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      autoScroll: autoScroll ?? this.autoScroll,
    );
  }
}


