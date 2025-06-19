import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Icon(Icons.home, size: 80, color: AppColors.primary),
                    const SizedBox(height: 8),
                    Text(
                      'HabiLux',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Mot de passe
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              // Bouton connexion
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigation(),
                      ),
                    );
                  },
                  child: const Text('Se connecter'),
                ),
              ),
              const SizedBox(height: 16),
              // Lien vers inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous n'avez pas de compte ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Créer un compte',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
