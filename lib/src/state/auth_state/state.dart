import 'package:flutter/material.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class AuthState extends InheritedWidget {
  const AuthState({
    super.key,
    required super.child,
    required AuthClient? authClient,
    required this.isLoading,
    required this.setAccount,
  }) : _authClient = authClient;

  final AuthClient? _authClient;
  final bool isLoading;
  final Future<void> Function() setAccount;

  AuthClient get authClient {
    if (_authClient == null) {
      throw Exception("_authClient has not been initialized.");
    }
    return _authClient;
  }

  AuthClient? get maybeAuthClient {
    return _authClient;
  }

  bool get isAuthenticated {
    return _authClient != null;
  }

  static AuthState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AuthState>();
    if (result == null) {
      throw Exception("AuthState has not been initialized.");
    }
    return result;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
