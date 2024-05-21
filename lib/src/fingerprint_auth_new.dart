import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth(
      {Key? key,
      this.authMessage = "Scan your finger to authenticate",
      this.authSuccessMessage = "Authorized success",
      this.authNotSuccessMessage = "Failed to authenticate",
      required this.secondPage,
      this.pageBackgroundColor,
      this.verticalPaddingHeader,
      this.horizontalPaddingHeader,
      this.title = "Login",
      this.titleColor,
      this.titleFontSize,
      this.titleFontWeight,
      this.verticalMarginBody,
      //this.imageWidth,
      this.bodyText = "Fingerprint Auth",
      this.bodyTextColor,
      this.bodyTextFontSize,
      this.bodyTextFontWeight,
      this.verticalMarginDescriptionText,
      this.descriptionTextWidth,
      this.descriptionText =
          "Authenticate using your fingerprint instead of your password ",
      this.descriptionTextColor,
      this.descriptionTextHeight,
      this.verticalMarginButton,
      this.verticalPaddingButton,
      this.horizontalPaddingButton,
      this.buttonText = "Authenticate",
      this.buttonColor})
      : super(key: key);

  final String authMessage;
  final String authSuccessMessage;
  final String authNotSuccessMessage;
  final Widget secondPage;
  final Color? pageBackgroundColor;
  final double? verticalPaddingHeader;
  final double? horizontalPaddingHeader;
  final String title;
  final Color? titleColor;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final double? verticalMarginBody;
  //final double? imageWidth;
  final String bodyText;
  final Color? bodyTextColor;
  final double? bodyTextFontSize;
  final FontWeight? bodyTextFontWeight;
  final double? verticalMarginDescriptionText;
  final double? descriptionTextWidth;
  final String descriptionText;
  final Color? descriptionTextColor;
  final double? descriptionTextHeight;
  final double? verticalMarginButton;
  final double? verticalPaddingButton;
  final double? horizontalPaddingButton;
  final String buttonText;
  final Color? buttonColor;

  @override
  FingerprintAuthState createState() => FingerprintAuthState();
}

class FingerprintAuthState extends State<FingerprintAuth> {
  LocalAuthentication auth = LocalAuthentication();
  late bool _canCheckBiometric;
  late List<BiometricType> _availableBiometrics;
  String authorized = "Not authorized";

  Future<void> _checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometric() async {
    late List<BiometricType> availableBiometric;
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
          localizedReason: widget.authMessage,
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: false));
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      authorized = authenticated
          ? widget.authSuccessMessage
          : widget.authNotSuccessMessage;
      if (authenticated) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => widget.secondPage));
      }
      print(authorized);
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: widget.pageBackgroundColor ?? const Color(0xFF3C3E52),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.verticalPaddingHeader ?? 12.0,
            horizontal: widget.horizontalPaddingHeader ?? 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                widget.title,
                style: TextStyle(
                    color: widget.titleColor ?? Colors.white,
                    fontSize: widget.titleFontSize ?? 48.0,
                    fontWeight: widget.titleFontWeight ?? FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: widget.verticalMarginBody ?? 50.0),
                child: Column(
                  children: [ /*
                    Image.asset(
                      'assets/fingerprint.png',
                      width: widget.imageWidth ?? 120.0,
                    ),
                    */
                    Text(
                      widget.bodyText,
                      style: TextStyle(
                          color: widget.bodyTextColor ?? Colors.white,
                          fontSize: widget.bodyTextFontSize ?? 22.0,
                          fontWeight:
                              widget.bodyTextFontWeight ?? FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical:
                              widget.verticalMarginDescriptionText ?? 15.0),
                      width: widget.descriptionTextWidth ?? 250.0,
                      child: Text(
                        widget.descriptionText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: widget.descriptionTextColor ?? Colors.white,
                            height: widget.descriptionTextHeight ?? 1.5),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: widget.verticalMarginButton ?? 15.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _authenticate,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: widget.verticalPaddingButton ?? 14.0,
                              horizontal:
                                  widget.horizontalPaddingButton ?? 24.0),
                          child: Text(
                            widget.buttonText,
                            style: TextStyle(
                                color: widget.buttonColor ?? Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
