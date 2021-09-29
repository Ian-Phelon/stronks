import 'package:flutter/material.dart';
import '../../controller/controller.dart';
import 'package:http/http.dart' as http;

const String googleLogoCDN =
    'https://lh3.googleusercontent.com/COxitqgJr1sJnIDe8-jiKhxDx1FrYbtRHKJ9z_hELisAlapwE9LUPh6fcXIfb5vwpbMl4xl9H9TRFPc5NOO8Sb3VSgIBrfRYvW6cUA';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = StronksAuth.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
            IconButton(
                onPressed: () {
                  auth.userSignOut();
                },
                icon: Icon(Icons.delete))
          ],
          title: Text('Purchases'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppleSignIn(
                  signInButton: auth.appleButton(() => auth.signInWithApple()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GoogleSignIn(
                  signInWithGoogle: () => auth.signInWithGoogle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: EmailSignIn(
                  signInWithEmail: () => auth.userSignInEmailAndPW(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailSignIn extends StatelessWidget {
  const EmailSignIn({Key? key, required this.signInWithEmail})
      : super(key: key);
  final Function signInWithEmail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        signInWithEmail();
      },
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primaryVariant)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.email_outlined,
                size: 33,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Sign in Anonymously',
                // style: Theme.of(context).textTheme.headline6,
                style: TextStyle(
                  fontSize: 33,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({
    Key? key,
    required this.signInWithGoogle,
  }) : super(key: key);
  final Function signInWithGoogle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        signInWithGoogle();
      },
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primaryVariant)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network(
                googleLogoCDN,
                height: 42,
                errorBuilder: (_, __, ___) => Text(
                  'G',
                  style: TextStyle(fontSize: 33),
                ),
              ),
              // Icon(
              //   Icons.format_align_justify_outlined,
              //   size: 33,
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Sign in goog',
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppleSignIn extends StatelessWidget {
  const AppleSignIn({
    Key? key,
    // required this.signInWithApple,
    required this.signInButton,
  }) : super(key: key);
  // final Function signInWithApple;
  final Widget signInButton;

  @override
  Widget build(BuildContext context) {
    return signInButton;

    // GestureDetector(
    //   onTap: () {
    //     // signInWithApple();
    //   },
    //   child: Material(
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(4.0),
    //         side: BorderSide(
    //             width: 2.0,
    //             color: Theme.of(context).colorScheme.primaryVariant)),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(2.0),
    //           child: Icon(
    //             Icons.email_outlined,
    //             size: 33,
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(4.0),
    //           child: Text(
    //             'Sign in Anonymously',
    //             style: Theme.of(context).textTheme.headline6,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
