import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../services/auth_service.dart';
import '../widgets/auth_background.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();


  bool loading = false;
  bool showPassword = false;
  bool showConfirmPassword = false;


  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await AuthService().register(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ----------- IMAGE ABOVE CARD -----------
                Center(
                  child: Image.asset(
                    'assets/images/can_logo_full.png',
                    height: 100,
                  ),
                ),

                const SizedBox(height: 20),

                // ---------- CARD ----------
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              'Créer un compte',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(labelText: 'Nom d’utilisateur'),
                            validator: (v) =>
                            (v == null || v.trim().length < 3)
                                ? 'Au moins 3 caractères'
                                : null,
                          ),
                          const SizedBox(height: 12),

                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: (v) =>
                            !EmailValidator.validate(v ?? '')
                                ? 'Email invalide'
                                : null,
                          ),

                          const SizedBox(height: 12),

                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !showPassword,
                            validator: (v) => (v == null || v.length < 6)
                                ? 'Au moins 6 caractères'
                                : null,
                          ),


                          const SizedBox(height: 12),

                          TextFormField(
                            controller: confirmController,
                            decoration: InputDecoration(
                              labelText: 'Confirmer le mot de passe',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showConfirmPassword = !showConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !showConfirmPassword,
                            validator: (v) =>
                            v != passwordController.text
                                ? 'Les mots de passe ne correspondent pas'
                                : null,
                          ),


                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: loading ? null : _register,
                            child: loading
                                ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              'Créer un compte',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---------- LOGIN BUTTON OUTSIDE CARD ----------
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A0C0F),
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Déjà un compte ? Se connecter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      setState(() => loading = true);
                      try {
                        await AuthService().signInWithGoogle();
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      } finally {
                        if (mounted) setState(() => loading = false);
                      }
                    },
                    icon: Image.asset(
                      'assets/images/google_logo.png',
                      height: 33,
                      width: 33,
                    ),
                    label: const Text(
                      'Se connecter avec Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
