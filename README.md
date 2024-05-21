<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The fingerprint authentication package contains a number of useful containers with functionality that can help you with building fingerprint authentication screens for your app. The package contains image container, description and result text.


## Features

Will be added later.

## Getting started

packages need for use this library:
# local_auth: ^2.2.0 (use their latest version)


## Usage

```dart
class FingerprintAuth extends StatelessWidget {
  const FingerprintAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FingerprintAuth(
          authMessage = "Scan your finger to authenticate",
          authSuccessMessage = "Authorized success",
          authNotSuccessMessage = "Failed to authenticate", 
          secondPage = Secondpage(),
          title = "Login",
          bodyText = "Fingerprint Auth",
          descriptionText = "Authenticate using your fingerprint instead of your password ",
          buttonText = "Authenticate"
        ),
      ),
    );
  }
}
```
