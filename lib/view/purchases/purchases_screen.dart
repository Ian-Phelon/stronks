import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controller/controller.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController pwCtrl = TextEditingController();

  bool editEmailVisibility = true;
  bool editPwVisibility = true;
  void _triggerEmailVisibility() {
    setState(() {
      editEmailVisibility = !editEmailVisibility;
    });
  }

  void _triggerPwVisibility() {
    setState(() {
      editPwVisibility = !editPwVisibility;
    });
  }

  @override
  void dispose() {
    /////⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡⇡↑⇡
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = StronksAuth.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Purchases'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppleSignIn(
                  signInWithApple: () => auth.signInWithApple(),
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
                  signInWithEmail: () => auth.userSignInEmailAndPW(
                      '${emailCtrl.text}', '${pwCtrl.text}'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Visibility(
                  replacement: const SizedBox.shrink(),
                  visible: editEmailVisibility,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) => emailCtrl.text = value,
                    onSubmitted: (value) {
                      emailCtrl.text = value;
                      _triggerEmailVisibility();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Visibility(
                  replacement: const SizedBox.shrink(),
                  visible: editPwVisibility,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) => pwCtrl.text = value,
                    onSubmitted: (value) {
                      pwCtrl.text = value;
                      _triggerPwVisibility();
                    },
                  ),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Sign in with Email',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
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
              width: 2.0, color: Theme.of(context).colorScheme.primaryVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: FaIcon(
                  FontAwesomeIcons.google,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Sign in with Google',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppleSignIn extends StatelessWidget {
  const AppleSignIn({
    Key? key,
    required this.signInWithApple,
  }) : super(key: key);
  final Function signInWithApple;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        signInWithApple();
      },
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primaryVariant)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: FaIcon(
                  FontAwesomeIcons.apple,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Sign in with Apple',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
