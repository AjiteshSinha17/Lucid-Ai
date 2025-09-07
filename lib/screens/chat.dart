import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart' as rvd;
import 'package:animate_do/animate_do.dart';
import '../widgets/chat/chat_input.dart';
import '../widgets/chat/message_bubble.dart';
import '../services/ai_provider.dart';
import '../services/auth_service.dart';
import '../services/roadmap_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final container = rvd.ProviderScope.containerOf(context);
      container.read(aiProvider.notifier).addWelcomeMessage();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 2.0,
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.15),
              const Color(0xFF03DAC6).withOpacity(0.05),
              const Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(child: _buildChatMessages()),
            _buildChatInput(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.8),
              const Color(0xFF03DAC6).withOpacity(0.8),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          const Icon(Icons.psychology_rounded, size: 24),
          const SizedBox(width: 12),
          provider.Consumer<AuthService>(
            builder: (context, authService, child) {
              final displayName = authService.user?.displayName;
              final firstName = (displayName == null || displayName.isEmpty)
                  ? 'there'
                  : displayName.split(' ').first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lucid AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hey $firstName!',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      actions: [
        provider.Consumer<AuthService>(
          builder: (context, authService, child) {
            return PopupMenuButton(
              icon: CircleAvatar(
                radius: 16,
                backgroundImage: authService.user?.photoURL != null
                    ? NetworkImage(authService.user!.photoURL!)
                    : null,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: authService.user?.photoURL == null
                    ? const Icon(Icons.person, color: Colors.white, size: 16)
                    : null,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Sign Out'),
                  onTap: () => authService.signOut(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatMessages() {
    return rvd.Consumer(
      builder: (context, ref, child) {
        final aiState = ref.watch(aiProvider);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (aiState.autoScroll) {
            _scrollToBottom();
          }
        });

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: aiState.messages.length,
          itemBuilder: (context, index) {
            final message = aiState.messages[index];
            return FadeInUp(
              delay: Duration(milliseconds: index * 50),
              child: MessageBubble(message: message),
            );
          },
        );
      },
    );
  }

  Widget _buildChatInput() {
    return ChatInput(
      onSendMessage: (message) async {
        final roadmapService = context.read<RoadmapService>();

        if (roadmapService.isRoadmapQuery(message)) {
          final roadmapResponse =
              roadmapService.generateDetailedRoadmapResponse(message);
          final container = rvd.ProviderScope.containerOf(context);
          await container
              .read(aiProvider.notifier)
              .sendRoadmapMessage(message, roadmapResponse);
        } else {
          final container = rvd.ProviderScope.containerOf(context);
          await container.read(aiProvider.notifier).sendMessage(message);
        }

        _scrollToBottom();
      },
    );
  }
}
