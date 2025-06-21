import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Map<String, dynamic> property;
  final void Function(Map<String, dynamic>)? onAddFavori;
  final void Function(Map<String, dynamic>)? onRemoveFavori;
  final bool Function(Map<String, dynamic>)? isFavori;
  const PropertyDetailScreen({
    super.key,
    required this.property,
    this.onAddFavori,
    this.onRemoveFavori,
    this.isFavori,
  });

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen>
    with TickerProviderStateMixin {
  int currentImageIndex = 0;
  bool isFavori = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late PageController _pageController;

  // Variables pour la carte
  LatLng _propertyLocation = LatLng(36.8065, 10.1815); // Tunis par défaut
  bool _isMapLoading = true;

  // Données de l'agent
  final Map<String, dynamic> agent = {
    'nom': 'Ahmed Ksontini',
    'photo': 'assets/images/ahm.JPG',
    'telephone': '+216 93 313 278',
    'email': 'ahmed.ksontini@habilux.com',
    'rating': 4.9,
    'nb_ventes': 52,
    'experience': '6 ans',
  };

  // Données de simulation de prêt
  double montantEmprunt = 0;
  double tauxInteret = 4.5;
  int dureeAnnees = 20;
  double mensualite = 0;

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
    _pageController = PageController();

    _animationController.forward();

    // Initialiser les données
    isFavori = widget.isFavori?.call(widget.property) ?? false;
    montantEmprunt = (widget.property['prix'] as num) * 0.8; // 80% du prix
    _calculerMensualite();
    _getCoordinates();
  }

  Future<void> _getCoordinates() async {
    try {
      final String adresse = widget.property['adresse'] ?? '';
      final String ville = widget.property['ville'] ?? '';
      final String gouvernorat = widget.property['gouvernorat'] ?? '';
      String fullAddress = '$adresse, $ville, $gouvernorat, Tunisie';

      List<Location> locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        setState(() {
          _propertyLocation = LatLng(
            locations.first.latitude,
            locations.first.longitude,
          );
          _isMapLoading = false;
        });
      } else {
        _setDefaultLocation(ville);
      }
    } catch (e) {
      final String ville = widget.property['ville'] ?? '';
      _setDefaultLocation(ville);
    }
  }

  void _setDefaultLocation(String ville) {
    LatLng defaultLocation;
    switch (ville.toLowerCase()) {
      case 'tunis':
        defaultLocation = LatLng(36.8065, 10.1815);
        break;
      case 'sfax':
        defaultLocation = LatLng(34.7473, 10.7662);
        break;
      case 'sousse':
        defaultLocation = LatLng(35.8333, 10.6333);
        break;
      case 'ariana':
        defaultLocation = LatLng(36.8625, 10.1956);
        break;
      case 'nabeul':
        defaultLocation = LatLng(36.4561, 10.7376);
        break;
      default:
        defaultLocation = LatLng(36.8065, 10.1815); // Tunis par défaut
    }
    setState(() {
      _propertyLocation = defaultLocation;
      _isMapLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _calculerMensualite() {
    double tauxMensuel = tauxInteret / 100 / 12;
    int nbMois = dureeAnnees * 12;

    if (tauxMensuel > 0) {
      mensualite =
          montantEmprunt *
          (tauxMensuel * math.pow(1 + tauxMensuel, nbMois)) /
          (math.pow(1 + tauxMensuel, nbMois) - 1);
    } else {
      mensualite = montantEmprunt / nbMois;
    }
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    final String datePublication = property['date_publication'] ?? '12/06/2024';
    final int nbFavoris = property['nb_favoris'] ?? 23;
    final String description =
        property['description'] ??
        'Superbe bien immobilier avec toutes les commodités modernes, idéalement situé.';
    final String reference = property['reference'] ?? 'REF123456';
    final String ville = property['ville'] ?? '-';
    final String gouvernorat = property['gouvernorat'] ?? '-';
    final String statut = property['statut'] ?? '-';
    final String adresse = property['adresse'] ?? '-';
    final int prix = property['prix'] ?? 0;
    final String type = property['type'] ?? '-';
    final List<String> photos = property['photos'] ?? [property['image']];
    final List<String> equipements = property['equipements'] ?? [];

    List<Map<String, dynamic>> caracteristiques = _getCaracteristiques(
      property,
      type,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // App Bar avec image principale
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Galerie photos
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentImageIndex = index;
                        });
                      },
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          photos[index],
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                color: AppColors.background,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        );
                      },
                    ),

                    // Indicateurs de photos
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(photos.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  currentImageIndex == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Badges
                    Positioned(
                      top: 50,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              statut == 'À vendre'
                                  ? Colors.blue
                                  : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statut,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 50,
                      right: 16,
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
                          reference,
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
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isFavori ? Icons.favorite : Icons.favorite_border,
                    color: isFavori ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavori = !isFavori;
                      if (isFavori) {
                        widget.onAddFavori?.call(property);
                      } else {
                        widget.onRemoveFavori?.call(property);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Action de partage
                  },
                ),
              ],
            ),

            // Contenu principal
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête avec prix et titre
                    _buildHeader(property),
                    const SizedBox(height: 24),

                    // Statistiques rapides
                    _buildStatistiques(property),
                    const SizedBox(height: 24),

                    // Description
                    _buildDescription(description),
                    const SizedBox(height: 24),

                    // Caractéristiques
                    _buildCaracteristiques(caracteristiques),
                    const SizedBox(height: 24),

                    // Équipements
                    if (equipements.isNotEmpty) ...[
                      _buildEquipements(equipements),
                      const SizedBox(height: 24),
                    ],

                    // Calculatrice de prêt
                    _buildCalculatricePret(),
                    const SizedBox(height: 24),

                    // Agent immobilier
                    _buildAgentImmobilier(),
                    const SizedBox(height: 24),

                    // Plan de localisation
                    _buildPlanLocalisation(ville, gouvernorat),
                    const SizedBox(height: 24),

                    // Actions
                    _buildActions(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                property['adresse'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Text(
              '${property['prix'].toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]} ")} DT',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              '${property['ville']}, ${property['gouvernorat']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.home, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              property['type'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatistiques(Map<String, dynamic> property) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              'Vues',
              '${property['nb_vues'] ?? 0}',
              Icons.visibility,
              Colors.blue,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              'Favoris',
              '${property['nb_favoris'] ?? 0}',
              Icons.favorite,
              Colors.red,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              'Note',
              '${property['rating'] ?? 0}',
              Icons.star,
              Colors.amber,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              'Avis',
              '${property['nb_avis'] ?? 0}',
              Icons.rate_review,
              Colors.green,
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
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaracteristiques(List<Map<String, dynamic>> caracteristiques) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Caractéristiques',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: caracteristiques.length,
            itemBuilder: (context, index) {
              final carac = caracteristiques[index];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      carac['icon'],
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          carac['label'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          carac['value'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEquipements(List<String> equipements) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Équipements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                equipements.map((equipement) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      equipement,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatricePret() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Simulateur de prêt',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Montant emprunté
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Montant emprunté: ${montantEmprunt.toInt()} DT',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                value: montantEmprunt,
                min: 0,
                max: widget.property['prix'].toDouble(),
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    montantEmprunt = value;
                    _calculerMensualite();
                  });
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Taux d'intérêt
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Taux d\'intérêt: ${tauxInteret}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                value: tauxInteret,
                min: 1,
                max: 10,
                divisions: 18,
                onChanged: (value) {
                  setState(() {
                    tauxInteret = value;
                    _calculerMensualite();
                  });
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Durée
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Durée: $dureeAnnees ans',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                value: dureeAnnees.toDouble(),
                min: 5,
                max: 30,
                divisions: 25,
                onChanged: (value) {
                  setState(() {
                    dureeAnnees = value.toInt();
                    _calculerMensualite();
                  });
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Résultat
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mensualité:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${mensualite.toInt()} DT/mois',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentImmobilier() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Votre agent immobilier',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(agent['photo']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent['nom'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${agent['rating']} (${agent['nb_ventes']} ventes)',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${agent['experience']} d\'expérience'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Action appel
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Appeler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
                    // Action message
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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
    );
  }

  Widget _buildPlanLocalisation(String ville, String gouvernorat) {
    final String adresse = widget.property['adresse'] ?? '';

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Localisation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  _isMapLoading
                      ? Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Recherche des coordonnées...',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )
                      : FlutterMap(
                        options: MapOptions(
                          initialCenter: _propertyLocation,
                          initialZoom: 15.0,
                          interactionOptions: const InteractionOptions(
                            flags:
                                InteractiveFlag.none, // Rend la carte statique
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app_habilux',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _propertyLocation,
                                width: 80,
                                height: 80,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$adresse, $ville, $gouvernorat',
                    style: TextStyle(fontSize: 14, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Action visite virtuelle
            },
            icon: const Icon(Icons.visibility),
            label: const Text('Visite virtuelle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action demande de visite
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Demander une visite'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action faire une offre
                },
                icon: const Icon(Icons.gavel),
                label: const Text('Faire une offre'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getCaracteristiques(
    Map<String, dynamic> property,
    String type,
  ) {
    List<Map<String, dynamic>> caracteristiques = [];

    if (type == 'Villa') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': '${property['superficie'] ?? 350} m²',
        },
        {
          'icon': Icons.king_bed,
          'label': 'Chambres',
          'value': '${property['chambres'] ?? 5}',
        },
        {
          'icon': Icons.bathtub,
          'label': 'Salles de bain',
          'value': '${property['sdb'] ?? 3}',
        },
        {
          'icon': Icons.garage,
          'label': 'Garage',
          'value': property['garage'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.pool,
          'label': 'Piscine',
          'value': property['piscine'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.park,
          'label': 'Jardin',
          'value': property['jardin'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.calendar_today,
          'label': 'Année',
          'value': '${property['annee_construction'] ?? 2015}',
        },
      ];
    } else if (type == 'Appartement') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': '${property['superficie'] ?? 120} m²',
        },
        {
          'icon': Icons.king_bed,
          'label': 'Chambres',
          'value': '${property['chambres'] ?? 3}',
        },
        {
          'icon': Icons.bathtub,
          'label': 'Salles de bain',
          'value': '${property['sdb'] ?? 2}',
        },
        {
          'icon': Icons.elevator,
          'label': 'Ascenseur',
          'value': property['ascenseur'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.apartment,
          'label': 'Étage',
          'value': '${property['etage'] ?? 2}',
        },
        {
          'icon': Icons.local_parking,
          'label': 'Parking',
          'value': property['parking'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.calendar_today,
          'label': 'Année',
          'value': '${property['annee_construction'] ?? 2018}',
        },
      ];
    } else if (type == 'Terrain') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': '${property['superficie'] ?? 500} m²',
        },
        {
          'icon': Icons.location_on,
          'label': 'Zone',
          'value': property['zone'] ?? 'Résidentielle',
        },
        {
          'icon': Icons.verified,
          'label': 'Titre foncier',
          'value': property['titre_foncier'] == true ? 'Oui' : 'Non',
        },
      ];
    } else if (type == 'Dépôt') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': '${property['superficie'] ?? 800} m²',
        },
        {
          'icon': Icons.local_shipping,
          'label': 'Accès poids lourd',
          'value': property['poids_lourd'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.security,
          'label': 'Sécurité',
          'value': property['securite'] == true ? 'Oui' : 'Non',
        },
      ];
    } else if (type == 'Bureau commercial') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': '${property['superficie'] ?? 200} m²',
        },
        {
          'icon': Icons.apartment,
          'label': 'Étage',
          'value': '${property['etage'] ?? 1}',
        },
        {
          'icon': Icons.wifi,
          'label': 'Internet',
          'value': property['internet'] == true ? 'Oui' : 'Non',
        },
        {
          'icon': Icons.local_parking,
          'label': 'Parking',
          'value': property['parking'] == true ? 'Oui' : 'Non',
        },
      ];
    }

    return caracteristiques;
  }
}
