import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/chat_message.dart';
import 'ai_state.dart';

class AiNotifier extends StateNotifier<AiState> {
  AiNotifier() : super(const AiState());

  void addWelcomeMessage() {
    if (state.messages.isEmpty) {
      final nextMessages = [
        ...state.messages,
        ChatMessage.ai(
          '''# 🌟 Welcome to Lucid AI!

I'm your intelligent learning companion, ready to help you with:

🗺️ **Developer Roadmaps** - Get structured learning paths with official resources
🎯 **Career Guidance** - Discover salary info and job opportunities  
📚 **Learning Resources** - Access documentation and PDF guides
💡 **Smart Assistance** - Ask me anything about technology and development

**Quick Start:**
• Tap the roadmap icons above for instant access
• Ask: "Show me Flutter roadmap" or "How to learn React?"
• Browse all roadmaps with the floating button

Ready to start your learning journey? 🚀''',
          isMarkdown: true,
        ),
      ];
      state = state.copyWith(messages: nextMessages);
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    state = state.copyWith(
      messages: [...state.messages, ChatMessage.user(message)],
      isLoading: true,
      autoScroll: true,
    );

    try {
      final response = await _getAIResponse(message);
      state = state.copyWith(
        messages: [
          ...state.messages,
          ChatMessage.ai(response, isMarkdown: true),
        ],
      );
    } catch (e) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          ChatMessage.ai(
            'I apologize, but I encountered an error processing your request. Please try again or check your connection.',
          ),
        ],
      );
    }

    state = state.copyWith(isLoading: false);
  }

  Future<void> sendRoadmapMessage(
      String userMessage, String roadmapResponse) async {
    if (userMessage.trim().isEmpty) return;

    state = state.copyWith(
      messages: [...state.messages, ChatMessage.user(userMessage)],
      isLoading: true,
      autoScroll: true,
    );

    await Future.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      messages: [...state.messages, ChatMessage.roadmap(roadmapResponse)],
      isLoading: false,
    );
  }

  Future<String> _getAIResponse(String message) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      return _getFallbackResponse(message);
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  '''You are Lucid AI, an intelligent assistant specializing in developer education and career guidance. 

Key instructions:
- Provide helpful, accurate information about programming, development, and technology careers
- Format responses using Markdown for better readability
- Be encouraging and supportive in your tone
- Include practical advice and actionable steps
- When discussing technologies, mention official documentation when relevant
- Keep responses concise but informative (aim for 200-400 words)

If asked about roadmaps or learning paths that aren't automatically detected, guide users to use the roadmap search feature.'''
            },
            {'role': 'user', 'content': message}
          ],
          'max_tokens': 500,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return _getFallbackResponse(message);
      }
    } catch (e) {
      return _getFallbackResponse(message);
    }
  }

  String _getFallbackResponse(String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      return '''# Hello! 👋

I'm Lucid AI, your learning companion! I can help you with:

• **Developer Roadmaps** - Structured learning paths
• **Career Guidance** - Salary info and job opportunities  
• **Technology Questions** - Programming help and advice
• **Learning Resources** - Documentation and guides

What would you like to explore today?''';
    }

    if (lowerMessage.contains('roadmap') || lowerMessage.contains('learn')) {
      return '''# 🗺️ Learning Roadmaps Available!

I can provide detailed roadmaps for:

**Web Development:** Frontend, Backend, Full Stack  
**Mobile:** Android, iOS, Flutter, React Native  
**Data & AI:** Data Science, Machine Learning, Analytics  
**Infrastructure:** DevOps, Cloud Computing, Cybersecurity  

**Pro Tip:** Use the quick access buttons above or the roadmap search (floating button) for visual learning paths with official documentation!

Which technology interests you most?''';
    }

    return '''# Thanks for your question! 🤔

I'm here to help with programming, development, and technology careers. 

**Popular topics I can assist with:**
• Programming languages and frameworks
• Career guidance and salary information  
• Learning roadmaps and educational resources
• Development best practices

**Need a roadmap?** Use the quick access buttons above or search all roadmaps with the floating button!

Feel free to ask me anything about technology and development! 🚀''';
  }

  void clearMessages() {
    state = const AiState();
    addWelcomeMessage();
  }

  void setAutoScroll(bool autoScroll) {
    state = state.copyWith(autoScroll: autoScroll);
  }
}

final aiProvider =
    StateNotifierProvider<AiNotifier, AiState>((ref) => AiNotifier());
