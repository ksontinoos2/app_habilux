import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Map<String, dynamic> property;
  final void Function(Map<String, dynamic>)? onAddFavori;
  final void Function(Map<String, dynamic>)? onRemoveFavori;
  final bool Function(Map<String, dynamic>)? isFavori;
  const PropertyDetailScreen({
    Key? key,
    required this.property,
    this.onAddFavori,
    this.onRemoveFavori,
    this.isFavori,
  }) : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
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
    final String image = property['image'] ?? '';
    final String type = property['type'] ?? '-';
    final bool isFav =
        widget.isFavori != null ? widget.isFavori!(property) : false;
    List<Map<String, dynamic>> caracteristiques = [];
    if (type == 'Villa') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': property['superficie'] ?? '350 m²',
        },
        {
          'icon': Icons.king_bed,
          'label': 'Chambres',
          'value': property['chambres'] ?? '5',
        },
        {
          'icon': Icons.bathtub,
          'label': 'Salles de bain',
          'value': property['sdb'] ?? '3',
        },
        {
          'icon': Icons.garage,
          'label': 'Garage',
          'value': property['garage'] ?? 'Oui',
        },
        {
          'icon': Icons.pool,
          'label': 'Piscine',
          'value': property['piscine'] ?? 'Oui',
        },
        {
          'icon': Icons.park,
          'label': 'Jardin',
          'value': property['jardin'] ?? 'Oui',
        },
        {
          'icon': Icons.calendar_today,
          'label': 'Année',
          'value': property['annee_construction'] ?? '2015',
        },
      ];
    } else if (type == 'Appartement') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': property['superficie'] ?? '120 m²',
        },
        {
          'icon': Icons.king_bed,
          'label': 'Chambres',
          'value': property['chambres'] ?? '3',
        },
        {
          'icon': Icons.bathtub,
          'label': 'Salles de bain',
          'value': property['sdb'] ?? '2',
        },
        {
          'icon': Icons.elevator,
          'label': 'Ascenseur',
          'value': property['ascenseur'] ?? 'Oui',
        },
        {
          'icon': Icons.apartment,
          'label': 'Étage',
          'value': property['etage'] ?? '2',
        },
        {
          'icon': Icons.local_parking,
          'label': 'Parking',
          'value': property['parking'] ?? 'Oui',
        },
        {
          'icon': Icons.calendar_today,
          'label': 'Année',
          'value': property['annee_construction'] ?? '2018',
        },
      ];
    } else if (type == 'Terrain') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': property['superficie'] ?? '500 m²',
        },
        {
          'icon': Icons.location_on,
          'label': 'Zone',
          'value': property['zone'] ?? 'Résidentielle',
        },
        {
          'icon': Icons.verified,
          'label': 'Titre foncier',
          'value': property['titre_foncier'] ?? 'Oui',
        },
      ];
    } else if (type == 'Dépôt') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': property['superficie'] ?? '800 m²',
        },
        {
          'icon': Icons.local_shipping,
          'label': 'Accès poids lourd',
          'value': property['poids_lourd'] ?? 'Oui',
        },
        {
          'icon': Icons.security,
          'label': 'Sécurité',
          'value': property['securite'] ?? 'Oui',
        },
      ];
    } else if (type == 'Bureau commercial') {
      caracteristiques = [
        {
          'icon': Icons.square_foot,
          'label': 'Superficie',
          'value': property['superficie'] ?? '200 m²',
        },
        {
          'icon': Icons.apartment,
          'label': 'Étage',
          'value': property['etage'] ?? '1',
        },
        {
          'icon': Icons.wifi,
          'label': 'Internet',
          'value': property['internet'] ?? 'Oui',
        },
        {
          'icon': Icons.local_parking,
          'label': 'Parking',
          'value': property['parking'] ?? 'Oui',
        },
      ];
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          // Image principale avec placeholder
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  image,
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
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statut == 'À vendre' ? Colors.blue : Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    statut,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    if (widget.isFavori != null &&
                        widget.onAddFavori != null &&
                        widget.onRemoveFavori != null) {
                      if (isFav) {
                        widget.onRemoveFavori!(property);
                      } else {
                        widget.onAddFavori!(property);
                      }
                      setState(() {});
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : AppColors.primary,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Date de publication et nombre de favoris
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  'Publié le $datePublication',
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Icon(Icons.favorite, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(
                  '$nbFavoris favoris',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Card(
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
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(description, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ),
          // Référence, Ville, Gouvernorat
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.numbers, color: AppColors.primary, size: 20),
                const SizedBox(width: 6),
                Text(
                  'Réf : $reference',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Icon(Icons.location_city, color: AppColors.primary, size: 20),
                const SizedBox(width: 6),
                Text('$ville, $gouvernorat'),
              ],
            ),
          ),
          // Formulaire de contact
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Card(
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
                      'Contacter l\'agence',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nom'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Message'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Envoyer'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Section caractéristiques & commodités
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Card(
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
                      'Caractéristiques & commodités',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 18,
                      runSpacing: 12,
                      children:
                          caracteristiques
                              .map(
                                (c) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.primary
                                          .withOpacity(0.08),
                                      child: Icon(
                                        c['icon'],
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      c['label'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      c['value'].toString(),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Emplacement sur la carte
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Emplacement sur la carte',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.map, size: 60, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
