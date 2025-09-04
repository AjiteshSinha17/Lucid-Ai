import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth? _auth;
  GoogleSignIn? _googleSignIn;
  bool _available = false;

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAvailable => _available;

  AuthService() {
    // Initialize only if Firebase is ready to avoid runtime crash
    if (Firebase.apps.isNotEmpty) {
      _auth = FirebaseAuth.instance;
      _googleSignIn = GoogleSignIn();
      _available = true;
      _auth!.authStateChanges().listen(_onAuthStateChanged);
    } else {
      // Firebase not initialized yet. Keep service disabled but app can run.
      _available = false;
    }
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      _user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? 'Anonymous',
        photoURL: firebaseUser.photoURL,
        provider: firebaseUser.providerData.isNotEmpty 
            ? firebaseUser.providerData.first.providerId 
            : 'email',
        createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
      );
    } else {
      _user = null;
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Email and Password Sign Up
  Future<void> createUserWithEmailAndPassword(
    String email, 
    String password,
    String displayName,
  ) async {
    try {
      if (!_available) {
        throw 'Authentication is unavailable. Firebase not initialized.';
      }
      _setLoading(true);
      UserCredential result = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await result.user?.updateDisplayName(displayName);

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw _handleAuthError(e);
    }
  }

  // Email and Password Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      if (!_available) {
        throw 'Authentication is unavailable. Firebase not initialized.';
      }
      _setLoading(true);
      await _auth!.signInWithEmailAndPassword(email: email, password: password);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw _handleAuthError(e);
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    try {
      if (!_available) {
        throw 'Authentication is unavailable. Firebase not initialized.';
      }
      _setLoading(true);
      final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();

      if (googleUser == null) {
        _setLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth!.signInWithCredential(credential);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw _handleAuthError(e);
    }
  }

  // GitHub Sign In (Mock implementation)
  Future<void> signInWithGitHub() async {
    try {
      if (!_available) {
        throw 'Authentication is unavailable. Firebase not initialized.';
      }
      _setLoading(true);
      // TODO: Implement actual GitHub OAuth
      // For now, create a demo user
      await Future.delayed(const Duration(seconds: 2));

      // Mock GitHub login - replace with actual implementation
      UserCredential result = await _auth!.signInAnonymously();
      await result.user?.updateDisplayName('GitHub User');

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw _handleAuthError(e);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      if (_available) {
        await Future.wait([
          _auth!.signOut(),
          _googleSignIn?.signOut() ?? Future.value(),
        ]);
      }
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw _handleAuthError(e);
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      if (!_available) {
        throw 'Authentication is unavailable. Firebase not initialized.';
      }
      await _auth!.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  String _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many failed attempts. Please try again later.';
        case 'operation-not-allowed':
          return 'This sign-in method is not allowed.';
        default:
          return e.message ?? 'An authentication error occurred.';
      }
    }
    return 'An unexpected error occurred.';
  }
}