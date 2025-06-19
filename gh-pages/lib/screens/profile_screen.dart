import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profil'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Header
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 60, color: AppColors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Jean Dupont',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'jean.dupont@email.com',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text('+33 6 12 34 56 78', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
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
                children: const [
                  Text(
                    'Informations personnelles',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Adresse : 123 Rue de la Liberté, 75000 Paris'),
                  SizedBox(height: 6),
                  Text('Date de naissance : 01/01/1980'),
                  SizedBox(height: 6),
                  Text('Genre : Homme'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Préférences
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Préférences',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Type de bien préféré : Villa'),
                  SizedBox(height: 6),
                  Text('Budget : 1 000 000 €'),
                  SizedBox(height: 6),
                  Text('Ville favorite : Paris'),
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
                children: const [
                  Text(
                    'Contact',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Email : jean.dupont@email.com'),
                  SizedBox(height: 6),
                  Text('Téléphone : +33 6 12 34 56 78'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
