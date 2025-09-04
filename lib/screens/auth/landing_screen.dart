import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../services/auth_service.dart';
import '../../widgets/auth/gradient_button.dart';
import '../../widgets/auth/social_login_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildWelcomeText(),
                  const SizedBox(height: 60),
                  _buildFeatures(),
                  const SizedBox(height: 24),
                  _buildAuthButtons(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.topCenter,
        radius: 2.0,
        colors: [
          const Color(0xFF6C63FF).withOpacity(0.3),
          const Color(0xFF03DAC6).withOpacity(0.2),
          const Color(0xFF0A0A0A),
          const Color(0xFF000000),
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget _buildLogo() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1000),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C63FF).withOpacity(0.8 + _pulseController.value * 0.2),
                  const Color(0xFF03DAC6).withOpacity(0.8 + _pulseController.value * 0.2),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.4),
                  blurRadius: 30 + _pulseController.value * 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology_rounded,
              size: 60,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
            ).createShader(bounds),
            child: const Text(
              'Welcome to Lucid AI',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Text(
            'Your intelligent learning companion for developer roadmaps, career guidance, and AI-powered assistance.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    final features = [
      {
        'icon': Icons.map_rounded,
        'title': 'Learning Roadmaps',
        'description': '15+ comprehensive developer roadmaps with official resources',
      },
      {
        'icon': Icons.psychology_rounded,
        'title': 'AI Assistant',
        'description': 'Smart chatbot that understands your learning needs',
      },
      {
        'icon': Icons.trending_up_rounded,
        'title': 'Career Guidance',
        'description': 'Salary insights and career path recommendations',
      },
    ];

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;

        return FadeInLeft(
          delay: Duration(milliseconds: 800 + (index * 200)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feature['description'] as String,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAuthButtons() {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Column(
          children: [
            FadeInUp(
              delay: const Duration(milliseconds: 1400),
              child: SocialLoginButton(
                icon: 'google',
                label: 'Continue with Google',
                gradient: const LinearGradient(
                  colors: [Color(0xFFDB4437), Color(0xFFEA4335)],
                ),
                onPressed: (!authService.isAvailable || authService.isLoading)
                    ? null
                    : () => _signInWithGoogle(),
              ),
            ),
            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: SocialLoginButton(
                icon: 'github',
                label: 'Continue with GitHub',
                gradient: const LinearGradient(
                  colors: [Color(0xFF333333), Color(0xFF24292e)],
                ),
                onPressed: (!authService.isAvailable || authService.isLoading)
                    ? null
                    : () => _signInWithGitHub(),
              ),
            ),
            const SizedBox(height: 24),

            FadeInUp(
              delay: const Duration(milliseconds: 1600),
              child: Row(
                children: [
                  Expanded(
                    child: GradientButton(
                      text: 'Sign Up',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                      ),
                      onPressed: authService.isLoading ? null : () => _navigateToSignUp(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GradientButton(
                      text: 'Sign In',
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      borderColor: Colors.white.withOpacity(0.3),
                      onPressed: authService.isLoading ? null : () => _navigateToLogin(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      await context.read<AuthService>().signInWithGoogle();
    } catch (e) {
      _showErrorSnackBar('Google sign-in failed: ${e.toString()}');
    }
  }

  Future<void> _signInWithGitHub() async {
    try {
      await context.read<AuthService>().signInWithGitHub();
    } catch (e) {
      _showErrorSnackBar('GitHub sign-in failed: ${e.toString()}');
    }
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LoginScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const SignupScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}