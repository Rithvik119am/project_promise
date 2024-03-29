import 'package:flutter/material.dart';
import 'package:project_promise/groups/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:appwrite/appwrite.dart';

class OutlineButtonFb1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final List<Color> gradientColors; // Add gradientColors parameter

  const OutlineButtonFb1({
    required this.text,
    required this.onPressed,
    required this.gradientColors, // Initialize gradientColors
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide.none),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: gradientColors, // Use gradientColors
          ).createShader(bounds);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.arrow_forward, size: 30)
          ],
        ),
      ),
    );
  }
}

class EmailInputFieldFb3 extends StatelessWidget {
  final TextEditingController inputController;
  const EmailInputFieldFb3({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          // Do something with the value
          value = inputController.text;
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
        decoration: InputDecoration(
          prefixIcon: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ).createShader(bounds);
            },
            child: const Icon(Icons.email, size: 30),
          ),
          filled: true,
          hintText: 'Enter your email',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}

class PasswordInputFieldFb3 extends StatefulWidget {
  final TextEditingController inputController;
  const PasswordInputFieldFb3({super.key, required this.inputController});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordInputFieldFb3State createState() => _PasswordInputFieldFb3State();
}

class _PasswordInputFieldFb3State extends State<PasswordInputFieldFb3> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: TextField(
        controller: widget.inputController,
        onChanged: (value) {
          // Do something with the value
          value = widget.inputController.text;
        },
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
        obscureText: _obscureText,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          prefixIcon: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ).createShader(bounds);
            },
            child: const Icon(Icons.lock, size: 30),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          filled: true,
          hintText: '********',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool loading = false;

  signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );

    try {
      final AuthAPI appwrite = context.read<AuthAPI>();
      await appwrite.createEmailSession(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on AppwriteException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //print(e.message);
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  }

  showAlert({required String title, required String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/2.png'), // Add your background image path here
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: EmailInputFieldFb3(
                      inputController:
                          emailTextController), // Use EmailInputFieldFb3
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: PasswordInputFieldFb3(
                      inputController:
                          passwordTextController), // Use PasswordInputFieldFb3
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 28.0, horizontal: 8.0),
                  child: OutlineButtonFb1(
                    text: 'Sign in',
                    onPressed: signIn,
                    gradientColors: const [
                      Colors.blue,
                      Colors.purple
                    ], // Add gradient colors
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
