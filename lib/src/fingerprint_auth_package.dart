import 'package:fingerprint_auth/src/ui/auth_button.dart';
import 'package:fingerprint_auth/src/ui/auth_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/auth_bloc.dart';

class FingerprintAuth extends StatelessWidget {
  const FingerprintAuth({
    super.key,
    this.authMessage = "Scan your finger to authenticate",
    required this.secondPage,
    this.pageBackgroundColor,
    this.title = "Login",
    this.titleColor,
    this.titleFontSize,
    this.titleFontWeight,
    this.bodyText = "Fingerprint Auth",
    this.bodyTextColor,
    this.bodyTextFontSize,
    this.bodyTextFontWeight,
    this.descriptionText =
    "Authenticate using your fingerprint instead of your password",
    this.descriptionTextColor,
    this.descriptionTextHeight,
    this.buttonText = "Authenticate",
    this.buttonColor,
  });

  final String authMessage;
  final Widget secondPage;
  final Color? pageBackgroundColor;
  final String title;
  final Color? titleColor;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final String bodyText;
  final Color? bodyTextColor;
  final double? bodyTextFontSize;
  final FontWeight? bodyTextFontWeight;
  final String descriptionText;
  final Color? descriptionTextColor;
  final double? descriptionTextHeight;
  final String buttonText;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: pageBackgroundColor ?? const Color(0xFF3C3E52),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor ?? Colors.white,
                  fontSize: titleFontSize ?? 48.0,
                  fontWeight: titleFontWeight ?? FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Center(
              child: Text(
                bodyText,
                style: TextStyle(
                  color: bodyTextColor ?? Colors.white,
                  fontSize: bodyTextFontSize ?? 22.0,
                  fontWeight: bodyTextFontWeight ?? FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: SizedBox(
                width: 250.0,
                child: Text(
                  descriptionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: descriptionTextColor ?? Colors.white,
                    height: descriptionTextHeight ?? 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            AuthButton(
              buttonText: buttonText,
              buttonColor: buttonColor,
              onPressed: () => context.read<AuthBloc>().authenticate(
                authMessage,
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => secondPage),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            const AuthMessage(),
          ],
        ),
      ),
    );
  }
}
