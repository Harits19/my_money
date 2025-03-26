import 'package:flutter/material.dart';
import 'package:googleapis/drive/v2.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/google_service.dart';
import 'package:my_money/src/state/auth_state/state.dart';

class AuthProvider extends StatefulWidget {
  const AuthProvider({
    super.key,
    required this.builder,
  });

  final Widget builder;

  @override
  State<AuthProvider> createState() => _AuthProviderState();
}

class _AuthProviderState extends State<AuthProvider> {
  AuthClient? authClient;
  bool isLoading = false;

  final GoogleService googleService = GoogleService(
    scopes: [
      SheetsApi.driveFileScope,
      DriveApi.driveFileScope,
    ],
  );

  Future<void> setAccount() async {
    isLoading = true;
    setState(() {});
    final result = await googleService.changeAccount();
    authClient = result;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    myLog.i("current auth client $authClient");
    return AuthState(
      setAccount: setAccount,
      isLoading: isLoading,
      authClient: authClient,
      child: widget.builder,
    );
  }
}
