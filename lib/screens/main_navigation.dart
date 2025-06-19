import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'property_list_screen.dart';
import 'property_detail_screen.dart';
import '../constants/colors.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _favoris = [];

  void addToFavoris(Map<String, dynamic> property) {
    if (!_favoris.any(
      (p) =>
          p['adresse'] == property['adresse'] && p['type'] == property['type'],
    )) {
      setState(() {
        _favoris.add(property);
      });
    }
  }

  void removeFromFavoris(Map<String, dynamic> property) {
    setState(() {
      _favoris.removeWhere(
        (p) =>
            p['adresse'] == property['adresse'] &&
            p['type'] == property['type'],
      );
    });
  }

  bool isFavori(Map<String, dynamic> property) {
    return _favoris.any(
      (p) =>
          p['adresse'] == property['adresse'] && p['type'] == property['type'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(
        onAddFavori: addToFavoris,
        onRemoveFavori: removeFromFavoris,
        isFavori: isFavori,
      ),
      const RechercheScreen(),
      FavorisScreen(favoris: _favoris, onRemoveFavori: removeFromFavoris),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Pages statiques pour Recherche
class RechercheScreen extends StatefulWidget {
  const RechercheScreen();
  @override
  State<RechercheScreen> createState() => _RechercheScreenState();
}

class _RechercheScreenState extends State<RechercheScreen> {
  final List<Map<String, dynamic>> allProperties = [
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'adresse': '123 Rue des Villas',
      'type': 'Villa',
      'prix': 1200000,
      'statut': 'À vendre',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
    },
    {
      'image': 'https://images.unsplash.com/photo-1460518451285-97b6aa326961',
      'adresse': '45 Avenue des Champs',
      'type': 'Appartement',
      'prix': 350000,
      'statut': 'À louer',
      'ville': 'Sfax',
      'gouvernorat': 'Sfax',
    },
    {
      'image': 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',
      'adresse': 'Zone Industrielle',
      'type': 'Dépôt',
      'prix': 800000,
      'statut': 'À vendre',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
    },
    {
      'image': 'https://images.unsplash.com/photo-1503389152951-9c3d8bca6c63',
      'adresse': 'Centre Ville',
      'type': 'Bureau commercial',
      'prix': 2000,
      'statut': 'À louer',
      'ville': 'Ariana',
      'gouvernorat': 'Ariana',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'adresse': 'Route de la Plage',
      'type': 'Terrain',
      'prix': 500000,
      'statut': 'À vendre',
      'ville': 'Nabeul',
      'gouvernorat': 'Nabeul',
    },
  ];

  String searchText = '';
  String selectedType = 'Tous';
  String selectedStatut = 'Tous';
  String selectedVille = 'Toutes';
  String selectedGouv = 'Tous';
  double minPrix = 0;
  double maxPrix = 2000000;
  double currentMinPrix = 0;
  double currentMaxPrix = 2000000;

  final List<String> types = [
    'Tous',
    'Villa',
    'Appartement',
    'Dépôt',
    'Bureau commercial',
    'Terrain',
  ];
  final List<String> villes = [
    'Toutes',
    'Tunis',
    'Sfax',
    'Sousse',
    'Ariana',
    'Nabeul',
  ];
  final List<String> gouvernorats = [
    'Tous',
    'Tunis',
    'Sfax',
    'Sousse',
    'Ariana',
    'Nabeul',
  ];
  final List<String> statuts = ['Tous', 'À vendre', 'À louer'];

  void resetFilters() {
    setState(() {
      searchText = '';
      selectedType = 'Tous';
      selectedStatut = 'Tous';
      selectedVille = 'Toutes';
      selectedGouv = 'Tous';
      currentMinPrix = minPrix;
      currentMaxPrix = maxPrix;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered =
        allProperties
            .where((p) => selectedType == 'Tous' || p['type'] == selectedType)
            .where(
              (p) => selectedStatut == 'Tous' || p['statut'] == selectedStatut,
            )
            .where(
              (p) => selectedVille == 'Toutes' || p['ville'] == selectedVille,
            )
            .where(
              (p) => selectedGouv == 'Tous' || p['gouvernorat'] == selectedGouv,
            )
            .where(
              (p) =>
                  (p['prix'] as num) >= currentMinPrix &&
                  (p['prix'] as num) <= currentMaxPrix,
            )
            .where(
              (p) =>
                  searchText.isEmpty ||
                  p['adresse'].toString().toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
            )
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Recherche'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Champ de recherche
          TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher par adresse, référence... ',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (val) => setState(() => searchText = val),
          ),
          const SizedBox(height: 16),
          // Filtres avancés
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Type de bien
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedType,
                          decoration: const InputDecoration(labelText: 'Type'),
                          items:
                              types
                                  .map(
                                    (t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setState(() => selectedType = val!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Type d'offre
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedStatut,
                          decoration: const InputDecoration(
                            labelText: 'Type d\'offre',
                          ),
                          items:
                              statuts
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setState(() => selectedStatut = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Ville
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedVille,
                          decoration: const InputDecoration(labelText: 'Ville'),
                          items:
                              villes
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setState(() => selectedVille = val!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Gouvernorat
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedGouv,
                          decoration: const InputDecoration(
                            labelText: 'Gouvernorat',
                          ),
                          items:
                              gouvernorats
                                  .map(
                                    (g) => DropdownMenuItem(
                                      value: g,
                                      child: Text(g),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setState(() => selectedGouv = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Prix
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Prix (en €)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RangeSlider(
                        min: minPrix,
                        max: maxPrix,
                        divisions: 20,
                        values: RangeValues(currentMinPrix, currentMaxPrix),
                        onChanged: (values) {
                          setState(() {
                            currentMinPrix = values.start;
                            currentMaxPrix = values.end;
                          });
                        },
                        labels: RangeLabels(
                          currentMinPrix.toInt().toString(),
                          currentMaxPrix.toInt().toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Réinitialiser'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Résultats
          Text(
            '${filtered.length} résultat(s)',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          if (filtered.isEmpty)
            Center(
              child: Column(
                children: const [
                  SizedBox(height: 24),
                  Icon(
                    Icons.sentiment_dissatisfied,
                    color: AppColors.primary,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text('Aucun bien trouvé.', style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          else
            ...filtered.map(
              (property) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      property['image'] ?? '',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            width: 70,
                            height: 70,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                    ),
                  ),
                  title: Text(
                    property['adresse'] ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(property['type'] ?? '-'),
                      Text(
                        '${(property['prix'] ?? 0).toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]} ")} €',
                        style: const TextStyle(color: Colors.green),
                      ),
                      Text(
                        property['statut'] ?? '-',
                        style: TextStyle(
                          color:
                              property['statut'] == 'À vendre'
                                  ? Colors.blue
                                  : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                PropertyDetailScreen(property: property),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Page Favoris dynamique
class FavorisScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoris;
  final Function(Map<String, dynamic>) onRemoveFavori;
  const FavorisScreen({
    Key? key,
    required this.favoris,
    required this.onRemoveFavori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoris'), centerTitle: true),
      body:
          favoris.isEmpty
              ? const Center(child: Text('Aucun favori pour le moment.'))
              : ListView.builder(
                itemCount: favoris.length,
                itemBuilder: (context, index) {
                  final property = favoris[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          property['image'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        property['adresse'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(property['type']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onRemoveFavori(property),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    PropertyDetailScreen(property: property),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
