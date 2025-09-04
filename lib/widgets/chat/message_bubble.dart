import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == MessageType.user;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(),
          if (!isUser) const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                      )
                    : LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                borderRadius: BorderRadius.circular(16).copyWith(
                  topLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
                  topRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
                ),
                border: !isUser ? Border.all(
                  color: Colors.white.withOpacity(0.1),
                ) : null,
              ),
              child: message.isMarkdown && !isUser
                  ? MarkdownBody(
                      data: message.content,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(color: Colors.white, fontSize: 16),
                        h1: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        h2: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        h3: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        code: TextStyle(
                          backgroundColor: Colors.black.withOpacity(0.3),
                          color: const Color(0xFF03DAC6),
                        ),
                      ),
                    )
                  : Text(
                      message.content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final isUser = message.type == MessageType.user;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUser 
              ? [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.6)]
              : [const Color(0xFF6C63FF), const Color(0xFF03DAC6)],
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isUser ? Icons.person : Icons.psychology_rounded,
        color: isUser ? const Color(0xFF6C63FF) : Colors.white,
        size: 18,
      ),
    );
  }
}