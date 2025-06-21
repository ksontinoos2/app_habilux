import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'property_list_screen.dart';
import 'property_detail_screen.dart';
import '../constants/colors.dart';
import 'chatbot_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _favoris = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      const ChatbotScreen(),
    ];
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _pages[_currentIndex],
      ),
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

// Page de recherche améliorée
class RechercheScreen extends StatefulWidget {
  const RechercheScreen();
  @override
  State<RechercheScreen> createState() => _RechercheScreenState();
}

class _RechercheScreenState extends State<RechercheScreen>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> allProperties = [
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1682377521625-c656fc1ff3e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB',
      'adresse': '123 Rue des Villas',
      'type': 'Villa',
      'prix': 1200000,
      'statut': 'À vendre',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
      'superficie': 350,
      'chambres': 5,
      'sdb': 3,
      'reference': 'VIL001',
      'rating': 4.8,
      'nb_avis': 12,
    },
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
      'reference': 'APT001',
      'rating': 4.4,
      'nb_avis': 8,
    },
    {
      'image':
          'https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2165979070.jpg?c=original',
      'adresse': 'Zone Industrielle',
      'type': 'Dépôt',
      'prix': 800000,
      'statut': 'À vendre',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
      'superficie': 800,
      'reference': 'DEP001',
      'rating': 4.2,
      'nb_avis': 5,
    },
    {
      'image':
          'https://cdn.shopify.com/s/files/1/1228/3740/files/CITE_PLAN30_SNO_Upswing.jpg?v=1665170978',
      'adresse': 'Centre Ville',
      'type': 'Bureau commercial',
      'prix': 2000,
      'statut': 'À louer',
      'ville': 'Ariana',
      'gouvernorat': 'Ariana',
      'superficie': 200,
      'reference': 'BUR001',
      'rating': 4.5,
      'nb_avis': 7,
    },
    {
      'image':
          'https://lh3.googleusercontent.com/HbBE-i6BPzOa5YWEFGmDSUyxTqqKpWTdIZMI3OPkFJ0eX-c75arGwjEkVDYjojxzvZyNOaiRHcyb1DNKdT-fVmh-B-jqqknVMkvZEw=rj-w700-h660-l80',
      'adresse': 'Route de la Plage',
      'type': 'Terrain',
      'prix': 500000,
      'statut': 'À vendre',
      'ville': 'Nabeul',
      'gouvernorat': 'Nabeul',
      'superficie': 500,
      'reference': 'TER001',
      'rating': 4.3,
      'nb_avis': 4,
    },
  ];

  String searchText = '';
  String selectedType = 'Tous';
  String selectedStatut = 'Tous';
  String selectedVille = 'Toutes';
  String selectedGouv = 'Tous';
  String selectedTri = 'Prix croissant';
  double minPrix = 0;
  double maxPrix = 2000000;
  double currentMinPrix = 0;
  double currentMaxPrix = 2000000;
  bool showFiltres = false;
  bool showRechercheAvancee = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
      duration: const Duration(milliseconds: 800),
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
      searchText = '';
      selectedType = 'Tous';
      selectedStatut = 'Tous';
      selectedVille = 'Toutes';
      selectedGouv = 'Tous';
      selectedTri = 'Prix croissant';
      currentMinPrix = minPrix;
      currentMaxPrix = maxPrix;
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
        // Tri par popularité pour simuler la date
        biens.sort(
          (a, b) => (b['rating'] as num).compareTo(a['rating'] as num),
        );
        break;
      case 'Superficie':
        biens.sort(
          (a, b) => (b['superficie'] as num).compareTo(a['superficie'] as num),
        );
        break;
      case 'Popularité':
        biens.sort(
          (a, b) => (b['rating'] as num).compareTo(a['rating'] as num),
        );
        break;
    }
    return biens;
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
                  p['adresse'].toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  p['ville'].toLowerCase().contains(searchText.toLowerCase()) ||
                  p['reference'].toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
            )
            .toList();

    filtered = _trierBiens(filtered);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // Header avec recherche
            SliverToBoxAdapter(child: _buildHeader(filtered.length)),

            // Barre de recherche
            SliverToBoxAdapter(child: _buildSearchBar()),

            // Filtres avancés
            if (showFiltres) SliverToBoxAdapter(child: _buildFiltresAvances()),

            // Statistiques rapides
            SliverToBoxAdapter(child: _buildStatistiques(filtered)),

            // Liste des résultats
            filtered.isEmpty
                ? SliverToBoxAdapter(child: _buildEmptyState())
                : _buildResultatsSliver(filtered),
          ],
        ),
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
          const Text(
            'Recherche avancée',
            style: TextStyle(
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: (value) => setState(() => searchText = value),
              decoration: InputDecoration(
                hintText: 'Rechercher par ville, adresse, référence...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
          IconButton(
            onPressed:
                () => setState(
                  () => showRechercheAvancee = !showRechercheAvancee,
                ),
            icon: Icon(
              showRechercheAvancee
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltresAvances() {
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
                // Première ligne
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownFilter(
                        'Type',
                        selectedType,
                        types,
                        (val) => setState(() => selectedType = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdownFilter(
                        'Statut',
                        selectedStatut,
                        statuts,
                        (val) => setState(() => selectedStatut = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Deuxième ligne
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownFilter(
                        'Ville',
                        selectedVille,
                        villes,
                        (val) => setState(() => selectedVille = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdownFilter(
                        'Trier par',
                        selectedTri,
                        tris,
                        (val) => setState(() => selectedTri = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filtre de prix
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
              'Biens trouvés',
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

  Widget _buildResultatsSliver(List<Map<String, dynamic>> biens) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final bien = biens[index];
          return _buildBienCard(bien);
        }, childCount: biens.length),
      ),
    );
  }

  Widget _buildBienCard(Map<String, dynamic> bien) {
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
                  bien['image'],
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
                        bien['statut'] == 'À vendre'
                            ? Colors.blue
                            : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    bien['statut'],
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
                    bien['reference'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
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
                        bien['adresse'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      '${bien['prix'].toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]} ")} DT',
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
                      '${bien['ville']}, ${bien['gouvernorat']}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Caractéristiques principales
                Row(
                  children: [
                    if (bien['superficie'] != null) ...[
                      _buildFeatureChip(
                        '${bien['superficie']} m²',
                        Icons.square_foot,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (bien['chambres'] != null) ...[
                      _buildFeatureChip(
                        '${bien['chambres']} ch.',
                        Icons.king_bed,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (bien['sdb'] != null) ...[
                      _buildFeatureChip('${bien['sdb']} sdb', Icons.bathtub),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // Note et actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Note
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${bien['rating']} (${bien['nb_avis']} avis)',
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
                                (context) =>
                                    PropertyDetailScreen(property: bien),
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
}

// Page de favoris moderne
class FavorisScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoris;
  final void Function(Map<String, dynamic>) onRemoveFavori;

  const FavorisScreen({
    Key? key,
    required this.favoris,
    required this.onRemoveFavori,
  }) : super(key: key);

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Contenu
            Expanded(
              child:
                  widget.favoris.isEmpty
                      ? _buildEmptyState()
                      : _buildFavorisList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
              if (widget.favoris.isNotEmpty)
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Vider les favoris'),
                            content: const Text(
                              'Êtes-vous sûr de vouloir supprimer tous vos favoris ?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Annuler'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Vider tous les favoris
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Supprimer tout'),
                              ),
                            ],
                          ),
                    );
                  },
                  icon: const Icon(Icons.delete_sweep, color: Colors.white),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Mes favoris',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.favoris.length} bien(s) sauvegardé(s)',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, color: AppColors.primary, size: 80),
          const SizedBox(height: 16),
          Text(
            'Aucun favori',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ajoutez des biens à vos favoris pour les retrouver ici',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigation vers la recherche
            },
            icon: const Icon(Icons.search),
            label: const Text('Découvrir des biens'),
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

  Widget _buildFavorisList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.favoris.length,
      itemBuilder: (context, index) {
        final bien = widget.favoris[index];
        return _buildFavoriCard(bien);
      },
    );
  }

  Widget _buildFavoriCard(Map<String, dynamic> bien) {
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
                  bien['image'],
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
                        bien['statut'] == 'À vendre'
                            ? Colors.blue
                            : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    bien['statut'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              // Bouton supprimer
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => widget.onRemoveFavori(bien),
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
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
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
                        bien['adresse'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      '${bien['prix'].toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]} ")} DT',
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
                      '${bien['ville']}, ${bien['gouvernorat']}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Caractéristiques principales
                Row(
                  children: [
                    if (bien['superficie'] != null) ...[
                      _buildFeatureChip(
                        '${bien['superficie']} m²',
                        Icons.square_foot,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (bien['chambres'] != null) ...[
                      _buildFeatureChip(
                        '${bien['chambres']} ch.',
                        Icons.king_bed,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (bien['sdb'] != null) ...[
                      _buildFeatureChip('${bien['sdb']} sdb', Icons.bathtub),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      PropertyDetailScreen(property: bien),
                            ),
                          );
                        },
                        icon: const Icon(Icons.visibility, size: 16),
                        label: const Text('Voir détails'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Action contact agent
                        },
                        icon: const Icon(Icons.phone, size: 16),
                        label: const Text('Contacter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
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
}
