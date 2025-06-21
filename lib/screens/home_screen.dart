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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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

  // Biens à la une
  final List<Map<String, dynamic>> featuredProperties = [
    {
      'title': 'Villa de luxe à Marrakech',
      'price': '2,500,000 DH',
      'location': 'Marrakech, Palmeraie',
      'image':
          'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800',
      'rating': 4.8,
      'reviews': 24,
      'features': ['5 chambres', 'Piscine', 'Jardin'],
    },
    {
      'title': 'Appartement moderne à Casablanca',
      'price': '1,200,000 DH',
      'location': 'Casablanca, Anfa',
      'image':
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      'rating': 4.6,
      'reviews': 18,
      'features': ['3 chambres', 'Balcon', 'Parking'],
    },
    {
      'title': 'Bureau premium à Rabat',
      'price': '800,000 DH',
      'location': 'Rabat, Agdal',
      'image':
          'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
      'rating': 4.7,
      'reviews': 12,
      'features': ['200m²', 'Vue mer', 'Sécurité'],
    },
  ];

  // Témoignages clients
  final List<Map<String, dynamic>> testimonials = [
    {
      'name': 'Nidhal Safta',
      'role': 'Investisseur',
      'comment':
          'HabiLux m\'a aidé à trouver l\'investissement parfait. Service exceptionnel !',
      'avatar': 'assets/images/saf.jpeg',
      'rating': 5,
    },
    {
      'name': 'Aziz Benfraj',
      'role': 'Propriétaire',
      'comment':
          'Vendre ma propriété avec HabiLux a été un vrai plaisir. Très professionnel.',
      'avatar': 'assets/images/zizou.jpg',
      'rating': 5,
    },
    {
      'name': 'Karim Mansouri',
      'role': 'Acheteur',
      'comment':
          'L\'équipe HabiLux a été très réactive et m\'a guidé tout au long du processus.',
      'avatar':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      'rating': 5,
    },
  ];

  // Statistiques
  final List<Map<String, dynamic>> stats = [
    {'number': '500+', 'label': 'Biens vendus'},
    {'number': '1000+', 'label': 'Clients satisfaits'},
    {'number': '50+', 'label': 'Villes couvertes'},
    {'number': '24/7', 'label': 'Support client'},
  ];

  int selectedIndex = 0;
  late AnimationController _animationController;
  late AnimationController _statsController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _statsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
    _statsController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _statsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header visuel amélioré
          _buildHeader(),
          const SizedBox(height: 28),

          // Section statistiques animées
          _buildStatsSection(),
          const SizedBox(height: 32),

          // Carrousel horizontal des types de biens
          _buildPropertyTypesCarousel(),
          const SizedBox(height: 24),

          // Bouton de recherche par type
          _buildSearchButton(),
          const SizedBox(height: 32),

          // Section "À la une"
          _buildFeaturedSection(),
          const SizedBox(height: 32),

          // Section avantages améliorée
          _buildAdvantagesSection(),
          const SizedBox(height: 32),

          // Section témoignages
          _buildTestimonialsSection(),
          const SizedBox(height: 32),

          // Section actualités/offres
          _buildNewsSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(_animationController),
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Découvrez notre sélection exclusive de propriétés premium',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // Champ de recherche amélioré
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RechercheScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: '🔍 Rechercher par ville, référence...',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nos chiffres clés',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children:
                stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  return Expanded(
                    child: AnimatedBuilder(
                      animation: _statsController,
                      builder: (context, child) {
                        final progress = _statsController.value;
                        final delay = index * 0.2;
                        final animationValue = (progress - delay).clamp(
                          0.0,
                          1.0,
                        );

                        return Transform.scale(
                          scale: 0.8 + (0.2 * animationValue),
                          child: Opacity(
                            opacity: animationValue,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
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
                              child: Column(
                                children: [
                                  Text(
                                    stat['number'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    stat['label'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypesCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Types de biens',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  duration: const Duration(milliseconds: 300),
                  width: 120,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (isSelected ? AppColors.primary : Colors.grey)
                            .withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color:
                          isSelected ? AppColors.primary : Colors.grey.shade200,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          type['image'],
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Icon(
                        type['icon'],
                        color: isSelected ? Colors.white : AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        type['label'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 20),
              const SizedBox(width: 8),
              Text('Voir les biens ${propertyTypes[selectedIndex]['label']}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'À la une',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigation vers la liste complète
                },
                child: Text(
                  'Voir tout',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: featuredProperties.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final property = featuredProperties[index];
                return _buildFeaturedCard(property);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> property) {
    return Container(
      width: 280,
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Stack(
              children: [
                Image.network(
                  property['image'],
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      property['price'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property['location'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${property['rating']} (${property['reviews']} avis)',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children:
                          property['features'].map<Widget>((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantagesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pourquoi choisir HabiLux ?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: _AdvantageCard(
                  icon: Icons.verified_user,
                  title: 'Biens vérifiés',
                  description:
                      'Tous nos biens sont soigneusement vérifiés et validés.',
                  color: Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _AdvantageCard(
                  icon: Icons.support_agent,
                  title: 'Support 7j/7',
                  description: 'Une équipe dédiée à votre écoute chaque jour.',
                  color: Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _AdvantageCard(
                  icon: Icons.handshake,
                  title: 'Accompagnement',
                  description:
                      'Un suivi personnalisé pour chaque projet immobilier.',
                  color: Color(0xFFFF9800),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _AdvantageCard(
                  icon: Icons.security,
                  title: 'Sécurité garantie',
                  description:
                      'Transactions sécurisées et documents officiels.',
                  color: Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ce que disent nos clients',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: testimonials.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return _buildTestimonialCard(testimonial);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    (testimonial['avatar'] as String).startsWith('assets/')
                        ? AssetImage(testimonial['avatar'])
                        : NetworkImage(testimonial['avatar']) as ImageProvider,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      testimonial['role'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                size: 16,
                color:
                    index < testimonial['rating']
                        ? Colors.amber
                        : Colors.grey.shade300,
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            '"${testimonial['comment']}"',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actualités & Offres',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, Color(0xFF2C4A5A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Offre spéciale',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '-20% sur les frais d\'agence',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Valable jusqu\'au 31 décembre 2024',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Action pour l'offre
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('En savoir plus'),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.local_offer,
                  color: Colors.white.withOpacity(0.3),
                  size: 60,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvantageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _AdvantageCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
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
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
