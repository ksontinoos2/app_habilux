import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'property_list_screen.dart';
import 'main_navigation.dart';

class HomeScreen extends StatefulWidget {
  final void Function(Map<String, dynamic>) onAddFavori;
  final void Function(Map<String, dynamic>) onRemoveFavori;
  final bool Function(Map<String, dynamic>) isFavori;
  const HomeScreen({
    Key? key,
    required this.onAddFavori,
    required this.onRemoveFavori,
    required this.isFavori,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> propertyTypes = [
    {
      'label': 'Villa',
      'icon': Icons.house,
      'image':
          'https://plus.unsplash.com/premium_photo-1682377521625-c656fc1ff3e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dmlsbGF8ZW58MHx8MHx8fDA%3D',
    },
    {
      'label': 'Appartement',
      'icon': Icons.apartment,
      'image':
          'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
    },
    {
      'label': 'Dépôt',
      'icon': Icons.warehouse,
      'image':
          'https://magasins.electrodepot.fr/api/v1/medias/poi/one?mediaid=abf7671e-3659-4976-b241-a9c799e6c98e',
    },
    {
      'label': 'Bureau commercial',
      'icon': Icons.business,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcrGGlWWiJOdOTysMfcNT4U4yjQin_NRnVHA&s',
    },
    {
      'label': 'Terrain',
      'icon': Icons.terrain,
      'image':
          'https://lh3.googleusercontent.com/HbBE-i6BPzOa5YWEFGmDSUyxTqqKpWTdIZMI3OPkFJ0eX-c75arGwjEkVDYjojxzvZyNOaiRHcyb1DNKdT-fVmh-B-jqqknVMkvZEw=rj-w700-h660-l80',
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header visuel
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logohome.png',
                      width: 200,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Trouvez le bien de vos rêves',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sélectionnez un type pour commencer votre recherche.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                // Champ de recherche rapide (interactif)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RechercheScreen(),
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              'Rechercher par ville, référence... (cliquez)',
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primary,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        enabled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Carrousel horizontal des types de biens
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: propertyTypes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 18),
              itemBuilder: (context, index) {
                final type = propertyTypes[index];
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 110,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.18),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                      ],
                      border: Border.all(
                        color:
                            isSelected
                                ? AppColors.primary
                                : AppColors.background,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            type['image'],
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Icon(
                          type['icon'],
                          color: isSelected ? Colors.white : AppColors.primary,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          type['label'],
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Bouton de recherche par type
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PropertyListScreen(
                            propertyType: propertyTypes[selectedIndex]['label'],
                            onAddFavori: widget.onAddFavori,
                            onRemoveFavori: widget.onRemoveFavori,
                            isFavori: widget.isFavori,
                          ),
                    ),
                  );
                },
                child: Text(
                  'Voir les biens ${propertyTypes[selectedIndex]['label']}',
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Section avantages
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pourquoi choisir HabiLux ?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _AdvantageCard(
                      icon: Icons.verified,
                      title: 'Biens vérifiés',
                      description:
                          'Tous nos biens sont soigneusement vérifiés.',
                    ),
                    _AdvantageCard(
                      icon: Icons.support_agent,
                      title: 'Support 7j/7',
                      description: 'Une équipe à votre écoute chaque jour.',
                    ),
                    _AdvantageCard(
                      icon: Icons.handshake,
                      title: 'Accompagnement',
                      description: 'Un suivi personnalisé pour chaque projet.',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _AdvantageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _AdvantageCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
