import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'property_detail_screen.dart';

class PropertyListScreen extends StatefulWidget {
  final String propertyType;
  final void Function(Map<String, dynamic>) onAddFavori;
  final void Function(Map<String, dynamic>) onRemoveFavori;
  final bool Function(Map<String, dynamic>) isFavori;
  const PropertyListScreen({
    Key? key,
    required this.propertyType,
    required this.onAddFavori,
    required this.onRemoveFavori,
    required this.isFavori,
  }) : super(key: key);

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen>
    with TickerProviderStateMixin {
  // Données statiques simulées avec plus de détails
  final List<Map<String, dynamic>> allProperties = [
    // Villas
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1682377521625-c656fc1ff3e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dmlsbGF8ZW58MHx8MHx8fDA%3D',
      'adresse': '123 Rue des Villas',
      'type': 'Villa',
      'prix': 1200000,
      'statut': 'À vendre',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
      'superficie': 350,
      'chambres': 5,
      'sdb': 3,
      'garage': true,
      'piscine': true,
      'jardin': true,
      'annee_construction': 2015,
      'reference': 'VIL001',
      'date_publication': '2024-01-15',
      'nb_vues': 245,
      'nb_favoris': 18,
      'rating': 4.8,
      'nb_avis': 12,
      'description': 'Magnifique villa de luxe avec vue panoramique',
      'equipements': ['Climatisation', 'Ascenseur', 'Sécurité', 'Domotique'],
      'photos': [
        'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800',
        'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?w=800',
        'https://images.unsplash.com/photo-1503389152951-9c3d8bca6c63?w=800',
      ],
    },
    {
      'image':
          'https://media.inmobalia.com/imgV1/B95mbh8olwFQm~uCUaVOI2kQT0hb0a8sZ9turUNfnwtvuccYCzs0YVPfPbfkc2VnnN1JFDplhuC3TbFKfXVpXWoYuP5Gy6tEWQPFksz8oklT8is6Atdqkg4IfY0UavEwouJDOOueqUfHJbQ_1l8qY1WmDp69Ub85bJ1_71ll0C7vH~L~TBkvbA1jDWw91w20FgG2c7SdRH10as9LVJ0Sys6ZXfPlxyBMWJKzigUS0xQ5bEHyFKb3zYudIZB23DTUyHz1Vsylvnwz5qtpP8bOrkHb5MJBXfjlXK3SiuCfpWEfFM3HEtjv6bXFtuicoXp9EFwj_XvPT_5maPLVSMKqN~PRxLa5Gd_6kyXrTUvDFq_Hm4i49WozZ8Ur3DZywiUySCMS4YcRQPnYnDnFlqK7.jpg',
      'adresse': 'Villa des Roses',
      'type': 'Villa',
      'prix': 950000,
      'statut': 'À vendre',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
      'superficie': 280,
      'chambres': 4,
      'sdb': 2,
      'garage': true,
      'piscine': false,
      'jardin': true,
      'annee_construction': 2018,
      'reference': 'VIL002',
      'date_publication': '2024-01-10',
      'nb_vues': 189,
      'nb_favoris': 14,
      'rating': 4.6,
      'nb_avis': 8,
      'description': 'Villa moderne avec jardin paysager',
      'equipements': ['Climatisation', 'Sécurité', 'Jardin paysager'],
      'photos': [
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
        'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
      ],
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1682377521625-c656fc1ff3e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB',
      'adresse': 'Villa Plage',
      'type': 'Villa',
      'prix': 2000000,
      'statut': 'À vendre',
      'ville': 'Nabeul',
      'gouvernorat': 'Nabeul',
      'superficie': 450,
      'chambres': 6,
      'sdb': 4,
      'garage': true,
      'piscine': true,
      'jardin': true,
      'annee_construction': 2020,
      'reference': 'VIL003',
      'date_publication': '2024-01-05',
      'nb_vues': 312,
      'nb_favoris': 25,
      'rating': 4.9,
      'nb_avis': 15,
      'description': 'Villa de luxe en bord de mer',
      'equipements': [
        'Climatisation',
        'Ascenseur',
        'Sécurité',
        'Domotique',
        'Vue mer',
      ],
      'photos': [
        'https://plus.unsplash.com/premium_photo-1682377521625-c656fc1ff3e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB',
        'https://plus.unsplash.com/premium_photo-1682377521625-c656fc1ff3e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB',
      ],
    },
    // Appartements
    {
      'image':
          'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
      'adresse': '45 Avenue des Champs',
      'type': 'Appartement',
      'prix': 350000,
      'statut': 'À louer',
      'ville': 'Sfax',
      'gouvernorat': 'Sfax',
      'superficie': 120,
      'chambres': 3,
      'sdb': 2,
      'etage': 3,
      'ascenseur': true,
      'parking': true,
      'annee_construction': 2018,
      'reference': 'APT001',
      'date_publication': '2024-01-12',
      'nb_vues': 156,
      'nb_favoris': 9,
      'rating': 4.4,
      'nb_avis': 6,
      'description': 'Appartement moderne au cœur de la ville',
      'equipements': ['Climatisation', 'Ascenseur', 'Parking', 'Balcon'],
      'photos': [
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
        'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
      ],
    },
    {
      'image':
          'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
      'adresse': 'Appartement Corniche',
      'type': 'Appartement',
      'prix': 420000,
      'statut': 'À vendre',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
      'superficie': 140,
      'chambres': 4,
      'sdb': 2,
      'etage': 5,
      'ascenseur': true,
      'parking': true,
      'annee_construction': 2019,
      'reference': 'APT002',
      'date_publication': '2024-01-08',
      'nb_vues': 203,
      'nb_favoris': 16,
      'rating': 4.7,
      'nb_avis': 11,
      'description': 'Appartement avec vue sur la corniche',
      'equipements': ['Climatisation', 'Ascenseur', 'Parking', 'Vue mer'],
      'photos': [
        'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
        'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
      ],
    },
    // Dépôts
    {
      'image':
          'https://media.istockphoto.com/id/1209677273/fr/photo/les-gens-faisant-du-shopping-au-home-depot-dans-la-r%C3%A9gion-de-la-baie-de-san-francisco.jpg?s=612x612&w=0&k=20&c=KrPC3m-wLS52ulQlGsmfgSm78LTwftSuD4EdfWEU3rs=',
      'adresse': 'Dépôt Industriel',
      'type': 'Dépôt',
      'prix': 800000,
      'statut': 'À vendre',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
      'superficie': 800,
      'poids_lourd': true,
      'securite': true,
      'annee_construction': 2010,
      'reference': 'DEP001',
      'date_publication': '2024-01-03',
      'nb_vues': 89,
      'nb_favoris': 5,
      'rating': 4.2,
      'nb_avis': 3,
      'description': 'Dépôt industriel bien équipé',
      'equipements': ['Accès poids lourd', 'Sécurité', 'Quai de chargement'],
      'photos': [
        'https://media.istockphoto.com/id/1209677273/fr/photo/les-gens-faisant-du-shopping-au-home-depot-dans-la-r%C3%A9gion-de-la-baie-de-san-francisco.jpg?s=612x612&w=0&k=20&c=KrPC3m-wLS52ulQlGsmfgSm78LTwftSuD4EdfWEU3rs=',
        'https://media.istockphoto.com/id/1209677273/fr/photo/les-gens-faisant-du-shopping-au-home-depot-dans-la-r%C3%A9gion-de-la-baie-de-san-francisco.jpg?s=612x612&w=0&k=20&c=KrPC3m-wLS52ulQlGsmfgSm78LTwftSuD4EdfWEU3rs=',
      ],
    },
    // Bureaux commerciaux
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsrqqMSWHaxC9JrkS-wdtv8SyzVQj_54G8uA&s',
      'adresse': 'Bureau Centre Ville',
      'type': 'Bureau commercial',
      'prix': 2000,
      'statut': 'À louer',
      'ville': 'Ariana',
      'gouvernorat': 'Ariana',
      'superficie': 200,
      'etage': 2,
      'internet': true,
      'parking': true,
      'annee_construction': 2015,
      'reference': 'BUR001',
      'date_publication': '2024-01-14',
      'nb_vues': 134,
      'nb_favoris': 8,
      'rating': 4.5,
      'nb_avis': 7,
      'description': 'Bureau moderne en centre-ville',
      'equipements': ['Internet', 'Parking', 'Climatisation', 'Sécurité'],
      'photos': [
        'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
        'https://images.unsplash.com/photo-1503389152951-9c3d8bca6c63?w=800',
      ],
    },
    // Terrains
    {
      'image':
          'https://media.istockphoto.com/id/1019274338/fr/photo/b%C3%A2timent-parcelle-%C3%A0-vendre-%C3%A0-vendre-immobilier-signe.jpg?s=612x612&w=0&k=20&c=PRSzSA57GnsurMtvWZ0leBb6VwiyWkMMAV9MmV-EoEw=',
      'adresse': 'Terrain Plage',
      'type': 'Terrain',
      'prix': 500000,
      'statut': 'À vendre',
      'ville': 'Nabeul',
      'gouvernorat': 'Nabeul',
      'superficie': 500,
      'zone': 'Résidentielle',
      'titre_foncier': true,
      'reference': 'TER001',
      'date_publication': '2024-01-01',
      'nb_vues': 167,
      'nb_favoris': 12,
      'rating': 4.3,
      'nb_avis': 4,
      'description': 'Terrain constructible en bord de mer',
      'equipements': ['Titre foncier', 'Accès route', 'Vue mer'],
      'photos': [
        'https://media.istockphoto.com/id/1019274338/fr/photo/b%C3%A2timent-parcelle-%C3%A0-vendre-%C3%A0-vendre-immobilier-signe.jpg?s=612x612&w=0&k=20&c=PRSzSA57GnsurMtvWZ0leBb6VwiyWkMMAV9MmV-EoEw=',
        'https://media.istockphoto.com/id/1019274338/fr/photo/b%C3%A2timent-parcelle-%C3%A0-vendre-%C3%A0-vendre-immobilier-signe.jpg?s=612x612&w=0&k=20&c=PRSzSA57GnsurMtvWZ0leBb6VwiyWkMMAV9MmV-EoEw=',
      ],
    },
  ];

  // Filtres avancés
  String selectedStatut = 'Tous';
  String selectedVille = 'Toutes';
  String selectedGouv = 'Tous';
  String selectedTri = 'Prix croissant';
  double minPrix = 0;
  double maxPrix = 2000000;
  double currentMinPrix = 0;
  double currentMaxPrix = 2000000;
  int minChambres = 0;
  int maxChambres = 10;
  int currentMinChambres = 0;
  int currentMaxChambres = 10;
  bool showFiltres = false;

  int currentPage = 1;
  final int itemsPerPage = 6;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
  final List<String> tris = [
    'Prix croissant',
    'Prix décroissant',
    'Date récente',
    'Superficie',
    'Popularité',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void resetFilters() {
    setState(() {
      selectedStatut = 'Tous';
      selectedVille = 'Toutes';
      selectedGouv = 'Tous';
      selectedTri = 'Prix croissant';
      currentMinPrix = minPrix;
      currentMaxPrix = maxPrix;
      currentMinChambres = minChambres;
      currentMaxChambres = maxChambres;
      currentPage = 1;
    });
  }

  List<Map<String, dynamic>> _trierBiens(List<Map<String, dynamic>> biens) {
    switch (selectedTri) {
      case 'Prix croissant':
        biens.sort((a, b) => (a['prix'] as num).compareTo(b['prix'] as num));
        break;
      case 'Prix décroissant':
        biens.sort((a, b) => (b['prix'] as num).compareTo(a['prix'] as num));
        break;
      case 'Date récente':
        biens.sort(
          (a, b) => (b['date_publication'] as String).compareTo(
            a['date_publication'] as String,
          ),
        );
        break;
      case 'Superficie':
        biens.sort(
          (a, b) => (b['superficie'] as num).compareTo(a['superficie'] as num),
        );
        break;
      case 'Popularité':
        biens.sort(
          (a, b) => (b['nb_vues'] as num).compareTo(a['nb_vues'] as num),
        );
        break;
    }
    return biens;
  }

  @override
  Widget build(BuildContext context) {
    // Filtrage avancé
    List<Map<String, dynamic>> filtered =
        allProperties
            .where((p) => p['type'] == widget.propertyType)
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
                  (p['chambres'] ?? 0) >= currentMinChambres &&
                  (p['chambres'] ?? 0) <= currentMaxChambres,
            )
            .toList();

    // Tri
    filtered = _trierBiens(filtered);

    // Pagination
    int totalPages = (filtered.length / itemsPerPage).ceil().clamp(1, 999);
    int start = (currentPage - 1) * itemsPerPage;
    int end = (start + itemsPerPage).clamp(0, filtered.length);
    List<Map<String, dynamic>> paginated = filtered.sublist(start, end);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header amélioré avec statistiques
          SliverToBoxAdapter(child: _buildHeader(filtered.length)),

          // Filtres avancés
          SliverToBoxAdapter(child: _buildFiltresAvances()),

          // Statistiques rapides
          SliverToBoxAdapter(child: _buildStatistiques(filtered)),

          // Liste des biens
          paginated.isEmpty
              ? SliverToBoxAdapter(child: _buildEmptyState())
              : _buildPropertyListSliver(paginated),

          // Pagination améliorée
          if (totalPages > 1)
            SliverToBoxAdapter(child: _buildPagination(totalPages)),
        ],
      ),
    );
  }

  Widget _buildHeader(int nbResultats) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, Color(0xFF2C4A5A)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logohome.png',
                  width: 150,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                IconButton(
                  onPressed: () => setState(() => showFiltres = !showFiltres),
                  icon: Icon(
                    showFiltres ? Icons.filter_list_off : Icons.filter_list,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.propertyType}s disponibles',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$nbResultats bien(s) trouvé(s)',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltresAvances() {
    if (!showFiltres) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Première ligne de filtres
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownFilter(
                        'Type d\'offre',
                        selectedStatut,
                        statuts,
                        (val) => setState(() {
                          selectedStatut = val!;
                          currentPage = 1;
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdownFilter(
                        'Ville',
                        selectedVille,
                        villes,
                        (val) => setState(() {
                          selectedVille = val!;
                          currentPage = 1;
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Deuxième ligne de filtres
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownFilter(
                        'Gouvernorat',
                        selectedGouv,
                        gouvernorats,
                        (val) => setState(() {
                          selectedGouv = val!;
                          currentPage = 1;
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdownFilter(
                        'Trier par',
                        selectedTri,
                        tris,
                        (val) => setState(() {
                          selectedTri = val!;
                          currentPage = 1;
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filtres de prix
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fourchette de prix (DT)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RangeSlider(
                      min: minPrix,
                      max: maxPrix,
                      divisions: 20,
                      values: RangeValues(currentMinPrix, currentMaxPrix),
                      onChanged: (values) {
                        setState(() {
                          currentMinPrix = values.start;
                          currentMaxPrix = values.end;
                          currentPage = 1;
                        });
                      },
                      labels: RangeLabels(
                        '${currentMinPrix.toInt()} DT',
                        '${currentMaxPrix.toInt()} DT',
                      ),
                      activeColor: AppColors.primary,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${currentMinPrix.toInt()} DT'),
                        Text('${currentMaxPrix.toInt()} DT'),
                      ],
                    ),
                  ],
                ),

                // Filtres de chambres (pour villas et appartements)
                if (widget.propertyType == 'Villa' ||
                    widget.propertyType == 'Appartement') ...[
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nombre de chambres',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        min: minChambres.toDouble(),
                        max: maxChambres.toDouble(),
                        divisions: 10,
                        values: RangeValues(
                          currentMinChambres.toDouble(),
                          currentMaxChambres.toDouble(),
                        ),
                        onChanged: (values) {
                          setState(() {
                            currentMinChambres = values.start.toInt();
                            currentMaxChambres = values.end.toInt();
                            currentPage = 1;
                          });
                        },
                        labels: RangeLabels(
                          '${currentMinChambres} ch.',
                          '${currentMaxChambres} ch.',
                        ),
                        activeColor: AppColors.primary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${currentMinChambres} chambres'),
                          Text('${currentMaxChambres} chambres'),
                        ],
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: resetFilters,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Réinitialiser'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => showFiltres = false),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Appliquer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownFilter(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildStatistiques(List<Map<String, dynamic>> biens) {
    if (biens.isEmpty) return const SizedBox.shrink();

    double prixMoyen =
        biens.map((b) => b['prix'] as num).reduce((a, b) => a + b) /
        biens.length;
    double superficieMoyenne =
        biens.map((b) => b['superficie'] as num).reduce((a, b) => a + b) /
        biens.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Prix moyen',
              '${prixMoyen.toInt()} DT',
              Icons.euro,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Surface moyenne',
              '${superficieMoyenne.toInt()} m²',
              Icons.square_foot,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Biens disponibles',
              '${biens.length}',
              Icons.home,
              AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, color: AppColors.primary, size: 80),
          const SizedBox(height: 16),
          Text(
            'Aucun bien trouvé',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Essayez de modifier vos critères de recherche',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: resetFilters,
            icon: const Icon(Icons.refresh),
            label: const Text('Réinitialiser les filtres'),
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
    );
  }

  Widget _buildPropertyListSliver(List<Map<String, dynamic>> properties) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final property = properties[index];
          final isFav = widget.isFavori(property);
          return _buildPropertyCard(property, isFav);
        }, childCount: properties.length),
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property, bool isFav) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image avec badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  property['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              // Badge statut
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        property['statut'] == 'À vendre'
                            ? Colors.blue
                            : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    property['statut'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              // Badge référence
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    property['reference'] ?? 'REF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

              // Bouton favori
              Positioned(
                bottom: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    if (isFav) {
                      widget.onRemoveFavori(property);
                    } else {
                      widget.onAddFavori(property);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Informations du bien
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre et prix
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        property['adresse'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      '${property['prix'].toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]} ")} DT',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Localisation
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.primary, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${property['ville']}, ${property['gouvernorat']}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Caractéristiques principales
                Row(
                  children: [
                    if (property['superficie'] != null) ...[
                      _buildFeatureChip(
                        '${property['superficie']} m²',
                        Icons.square_foot,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (property['chambres'] != null) ...[
                      _buildFeatureChip(
                        '${property['chambres']} ch.',
                        Icons.king_bed,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (property['sdb'] != null) ...[
                      _buildFeatureChip(
                        '${property['sdb']} sdb',
                        Icons.bathtub,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // Statistiques et actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Statistiques
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${property['nb_vues'] ?? 0}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.favorite, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${property['nb_favoris'] ?? 0}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    // Bouton voir détails
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PropertyDetailScreen(
                                  property: property,
                                  onAddFavori: widget.onAddFavori,
                                  onRemoveFavori: widget.onRemoveFavori,
                                  isFavori: widget.isFavori,
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text('Voir détails'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Bouton précédent
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
                currentPage > 1 ? () => setState(() => currentPage--) : null,
            style: IconButton.styleFrom(
              backgroundColor:
                  currentPage > 1 ? AppColors.primary : Colors.grey[300],
              foregroundColor:
                  currentPage > 1 ? Colors.white : Colors.grey[600],
            ),
          ),

          const SizedBox(width: 16),

          // Indicateur de page
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Page $currentPage / $totalPages',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Bouton suivant
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed:
                currentPage < totalPages
                    ? () => setState(() => currentPage++)
                    : null,
            style: IconButton.styleFrom(
              backgroundColor:
                  currentPage < totalPages
                      ? AppColors.primary
                      : Colors.grey[300],
              foregroundColor:
                  currentPage < totalPages ? Colors.white : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
