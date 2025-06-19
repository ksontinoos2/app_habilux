import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nom = 'Ksontini Ahmed';
  String email = 'ahmedksontini@gmail.com';
  String tel = '+216 93 313 278';
  String adresse = 'rue taher ben fraj';
  String dateNaiss = '21/05/2002';

  void _editProfile() async {
    final nomCtrl = TextEditingController(text: nom);
    final emailCtrl = TextEditingController(text: email);
    final telCtrl = TextEditingController(text: tel);
    final adresseCtrl = TextEditingController(text: adresse);
    final dateNaissCtrl = TextEditingController(text: dateNaiss);
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Modifier le profil'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nomCtrl,
                    decoration: const InputDecoration(labelText: 'Nom'),
                  ),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: telCtrl,
                    decoration: const InputDecoration(labelText: 'Téléphone'),
                  ),
                  TextFormField(
                    controller: adresseCtrl,
                    decoration: const InputDecoration(labelText: 'Adresse'),
                  ),
                  TextFormField(
                    controller: dateNaissCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Date de naissance',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Annuler'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('Enregistrer'),
                onPressed: () {
                  setState(() {
                    nom = nomCtrl.text;
                    email = emailCtrl.text;
                    tel = telCtrl.text;
                    adresse = adresseCtrl.text;
                    dateNaiss = dateNaissCtrl.text;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Image.asset('assets/images/logohome.png', height: 40),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primary,
                  backgroundImage: AssetImage('assets/images/ahm.JPG'),
                ),
                const SizedBox(height: 16),
                Text(
                  nom,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _editProfile,
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier le profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Informations personnelles
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informations personnelles',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text('Adresse : $adresse'),
                  const SizedBox(height: 6),
                  Text('Date de naissance : $dateNaiss'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Contact
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text('Email : $email'),
                  const SizedBox(height: 6),
                  Text('Téléphone : $tel'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Actions statiques
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.lock_reset),
                    label: const Text('Changer le mot de passe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.block),
                    label: const Text('Désactiver le compte'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Bouton de déconnexion
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Se déconnecter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ],
      ),
    );
  }
}
