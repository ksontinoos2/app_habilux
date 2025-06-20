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

class _PropertyListScreenState extends State<PropertyListScreen> {
  // Données statiques simulées
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
    },
    {
      'image':
          'https://st3.idealista.pt/news/arquivos/styles/fullwidth_xl/public/2023-02/media/image/200912673.jpg?VersionId=TvjBUnAHtEUTlc7w7tv6NcN6HdrYFszJ&itok=oM5UI4FD',
      'adresse': 'Villa Plage',
      'type': 'Villa',
      'prix': 2000000,
      'statut': 'À vendre',
      'ville': 'Nabeul',
      'gouvernorat': 'Nabeul',
    },
    {
      'image':
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/295090917.jpg?k=d17621b71b0eaa0c7a37d8d8d02d33896cef75145f61e7d96d296d88375a7d39&o=&hp=1',
      'adresse': 'Villa Centre Ville',
      'type': 'Villa',
      'prix': 1750000,
      'statut': 'À louer',
      'ville': 'Ariana',
      'gouvernorat': 'Ariana',
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
    },
    {
      'image':
          'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
      'adresse': 'Appartement Sahloul',
      'type': 'Appartement',
      'prix': 390000,
      'statut': 'À louer',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
    },
    {
      'image':
          'https://www.shutterstock.com/image-photo/new-modern-block-flats-green-600nw-2501530247.jpg',
      'adresse': 'Appartement Lac',
      'type': 'Appartement',
      'prix': 510000,
      'statut': 'À vendre',
      'ville': 'Ariana',
      'gouvernorat': 'Ariana',
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
    },
    {
      'image':
          'https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2165979070.jpg?c=original',
      'adresse': 'Dépôt Logistique',
      'type': 'Dépôt',
      'prix': 1200000,
      'statut': 'À louer',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
    },
    {
      'image':
          'https://negoce.zepros.fr/sites/default/files/styles/max_1300x1300/public/2023-06/BRICO%20DEPOT%20CAHORS%2007.jpg?itok=-bFK8h4u',
      'adresse': 'Dépôt Sfax',
      'type': 'Dépôt',
      'prix': 950000,
      'statut': 'À vendre',
      'ville': 'Sfax',
      'gouvernorat': 'Sfax',
    },
    {
      'image':
          'https://magasins.electrodepot.fr/api/v1/medias/poi/one?mediaid=abf7671e-3659-4976-b241-a9c799e6c98e',
      'adresse': 'Dépôt Ariana',
      'type': 'Dépôt',
      'prix': 700000,
      'statut': 'À louer',
      'ville': 'Ariana',
      'gouvernorat': 'Ariana',
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
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZP5RlHDuLkQIAEDjW3Ifc5iKfr4Spvuhfpg&s',
      'adresse': 'Bureau Tunis',
      'type': 'Bureau commercial',
      'prix': 3500,
      'statut': 'À vendre',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsrqqMSWHaxC9JrkS-wdtv8SyzVQj_54G8uA&s',
      'adresse': 'Bureau Sfax',
      'type': 'Bureau commercial',
      'prix': 2500,
      'statut': 'À louer',
      'ville': 'Sfax',
      'gouvernorat': 'Sfax',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcrGGlWWiJOdOTysMfcNT4U4yjQin_NRnVHA&s',
      'adresse': 'Bureau Sousse',
      'type': 'Bureau commercial',
      'prix': 3000,
      'statut': 'À vendre',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
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
    },
    {
      'image':
          'https://lh3.googleusercontent.com/HbBE-i6BPzOa5YWEFGmDSUyxTqqKpWTdIZMI3OPkFJ0eX-c75arGwjEkVDYjojxzvZyNOaiRHcyb1DNKdT-fVmh-B-jqqknVMkvZEw=rj-w700-h660-l80',
      'adresse': 'Terrain Agricole',
      'type': 'Terrain',
      'prix': 350000,
      'statut': 'À vendre',
      'ville': 'Sfax',
      'gouvernorat': 'Sfax',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw-NPEumf_hmzxSNNfCoMyOZO_-SSwNJ57XQ&s',
      'adresse': 'Terrain Résidentiel',
      'type': 'Terrain',
      'prix': 420000,
      'statut': 'À louer',
      'ville': 'Tunis',
      'gouvernorat': 'Tunis',
    },
    {
      'image':
          'https://media.istockphoto.com/id/1019274338/fr/photo/b%C3%A2timent-parcelle-%C3%A0-vendre-%C3%A0-vendre-immobilier-signe.jpg?s=612x612&w=0&k=20&c=PRSzSA57GnsurMtvWZ0leBb6VwiyWkMMAV9MmV-EoEw=',
      'adresse': 'Terrain Sousse',
      'type': 'Terrain',
      'prix': 390000,
      'statut': 'À vendre',
      'ville': 'Sousse',
      'gouvernorat': 'Sousse',
    },
  ];

  // Filtres avancés
  String selectedStatut = 'Tous';
  String selectedVille = 'Toutes';
  String selectedGouv = 'Tous';
  double minPrix = 0;
  double maxPrix = 2000000;
  double currentMinPrix = 0;
  double currentMaxPrix = 2000000;

  int currentPage = 1;
  final int itemsPerPage = 4;

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
      selectedStatut = 'Tous';
      selectedVille = 'Toutes';
      selectedGouv = 'Tous';
      currentMinPrix = minPrix;
      currentMaxPrix = maxPrix;
      currentPage = 1;
    });
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
            .toList();

    // Pagination
    int totalPages = (filtered.length / itemsPerPage).ceil().clamp(1, 999);
    int start = (currentPage - 1) * itemsPerPage;
    int end = (start + itemsPerPage).clamp(0, filtered.length);
    List<Map<String, dynamic>> paginated = filtered.sublist(start, end);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header coloré
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 48,
              left: 24,
              right: 24,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
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
                const SizedBox(height: 8),
                Text(
                  '${filtered.length} résultat(s)',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          // Système de filtrage avancé
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
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
                            onChanged: (val) {
                              setState(() {
                                selectedStatut = val!;
                                currentPage = 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Ville
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedVille,
                            decoration: const InputDecoration(
                              labelText: 'Ville',
                            ),
                            items:
                                villes
                                    .map(
                                      (v) => DropdownMenuItem(
                                        value: v,
                                        child: Text(v),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedVille = val!;
                                currentPage = 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
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
                            onChanged: (val) {
                              setState(() {
                                selectedGouv = val!;
                                currentPage = 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Prix
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Prix (en DT)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              RangeSlider(
                                min: minPrix,
                                max: maxPrix,
                                divisions: 20,
                                values: RangeValues(
                                  currentMinPrix,
                                  currentMaxPrix,
                                ),
                                onChanged: (values) {
                                  setState(() {
                                    currentMinPrix = values.start;
                                    currentMaxPrix = values.end;
                                    currentPage = 1;
                                  });
                                },
                                labels: RangeLabels(
                                  currentMinPrix.toInt().toString(),
                                  currentMaxPrix.toInt().toString(),
                                ),
                              ),
                            ],
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
          ),
          // Liste des biens
          Expanded(
            child:
                paginated.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: AppColors.primary,
                            size: 60,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Aucun bien trouvé.',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: paginated.length,
                      itemBuilder: (context, index) {
                        final property = paginated[index];
                        final isFav = widget.isFavori(property);
                        return GestureDetector(
                          onTap: () {
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
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),
                                      ),
                                      child: Image.network(
                                        property['image'],
                                        width: double.infinity,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
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
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                isFav
                                                    ? Colors.red
                                                    : AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          property['statut'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        property['adresse'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColors.primary,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${property['ville']}, ${property['gouvernorat']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.euro,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${property['prix'].toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]} ")} €',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
          // Pagination stylisée
          if (totalPages > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed:
                        currentPage > 1
                            ? () => setState(() => currentPage--)
                            : null,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Page $currentPage / $totalPages',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed:
                        currentPage < totalPages
                            ? () => setState(() => currentPage++)
                            : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
