import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  String nom = 'Ksontini Ahmed';
  String email = 'ahmedksontini@gmail.com';
  String tel = '+216 93 313 278';
  String adresse = 'rue taher ben fraj';
  String dateNaiss = '21/05/2002';
  int selectedTab = 0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Données simulées
  final List<Map<String, dynamic>> biensFavoris = [
    {
      'image':
          'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800',
      'titre': 'Villa de luxe à Marrakech',
      'prix': '2,500,000 DT',
      'localisation': 'Marrakech, Palmeraie',
      'type': 'Villa',
      'statut': 'À vendre',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      'titre': 'Appartement moderne à Casablanca',
      'prix': '1,200,000 DT',
      'localisation': 'Casablanca, Anfa',
      'type': 'Appartement',
      'statut': 'À vendre',
    },
  ];

  final List<Map<String, dynamic>> historiqueVisites = [
    {
      'date': '15/01/2024',
      'bien': 'Villa des Roses',
      'localisation': 'Sousse',
      'statut': 'Visité',
      'note': 4.5,
    },
    {
      'date': '10/01/2024',
      'bien': 'Appartement Corniche',
      'localisation': 'Tunis',
      'statut': 'Programmé',
      'note': null,
    },
  ];

  final List<Map<String, dynamic>> notifications = [
    {
      'titre': 'Nouveau bien disponible',
      'message': 'Une villa correspondant à vos critères vient d\'être ajoutée',
      'date': 'Il y a 2h',
      'lu': false,
      'type': 'nouveau_bien',
    },
    {
      'titre': 'Visite confirmée',
      'message':
          'Votre visite de l\'appartement Corniche est confirmée pour demain',
      'date': 'Il y a 1j',
      'lu': true,
      'type': 'visite',
    },
    {
      'titre': 'Prix mis à jour',
      'message': 'Le prix de la villa des Roses a été mis à jour',
      'date': 'Il y a 2j',
      'lu': true,
      'type': 'prix',
    },
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
                    decoration: const InputDecoration(
                      labelText: 'Nom complet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: telCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Téléphone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: adresseCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Adresse',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: dateNaissCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Date de naissance',
                      border: OutlineInputBorder(),
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
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Header du profil
            _buildProfileHeader(),

            // Onglets
            _buildTabs(),

            // Contenu des onglets
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
        children: [
          // Photo de profil et informations
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('assets/images/ahm.JPG'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nom,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tel,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Statistiques rapides
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Favoris',
                  '${biensFavoris.length}',
                  Icons.favorite,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Visites',
                  '${historiqueVisites.length}',
                  Icons.visibility,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Notifications',
                  '${notifications.where((n) => !n['lu']).length}',
                  Icons.notifications,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
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
            child: _buildTabButton('Tableau de bord', 0, Icons.dashboard),
          ),
          Expanded(child: _buildTabButton('Favoris', 1, Icons.favorite)),
          Expanded(child: _buildTabButton('Visites', 2, Icons.visibility)),
          Expanded(
            child: _buildTabButton('Notifications', 3, Icons.notifications),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index, IconData icon) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.primary,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildFavoris();
      case 2:
        return _buildVisites();
      case 3:
        return _buildNotifications();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Informations personnelles
        _buildInfoCard('Informations personnelles', [
          {'label': 'Adresse', 'value': adresse},
          {'label': 'Date de naissance', 'value': dateNaiss},
        ], Icons.person),

        const SizedBox(height: 16),

        // Contact
        _buildInfoCard('Contact', [
          {'label': 'Email', 'value': email},
          {'label': 'Téléphone', 'value': tel},
        ], Icons.contact_phone),

        const SizedBox(height: 16),

        // Actions rapides
        _buildActionsCard(),

        const SizedBox(height: 16),

        // Paramètres
        _buildSettingsCard(),
      ],
    );
  }

  Widget _buildFavoris() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: biensFavoris.length,
      itemBuilder: (context, index) {
        final bien = biensFavoris[index];
        return _buildFavoriCard(bien);
      },
    );
  }

  Widget _buildVisites() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: historiqueVisites.length,
      itemBuilder: (context, index) {
        final visite = historiqueVisites[index];
        return _buildVisiteCard(visite);
      },
    );
  }

  Widget _buildNotifications() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildInfoCard(
    String title,
    List<Map<String, String>> infos,
    IconData icon,
  ) {
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
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...infos.map(
            (info) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info['label']!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    info['value']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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

  Widget _buildActionsCard() {
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
          Row(
            children: [
              Icon(Icons.settings, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Actions rapides',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock_reset, size: 18),
                  label: const Text('Changer mot de passe'),
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
                  onPressed: () {},
                  icon: const Icon(Icons.block, size: 18),
                  label: const Text('Désactiver compte'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
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

  Widget _buildSettingsCard() {
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
          Row(
            children: [
              Icon(Icons.settings, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Paramètres',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingItem('Notifications push', Icons.notifications, true),
          _buildSettingItem('Notifications email', Icons.email, true),
          _buildSettingItem('Mode sombre', Icons.dark_mode, false),
          _buildSettingItem('Localisation', Icons.location_on, true),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, IconData icon, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Switch(
            value: value,
            onChanged: (newValue) {
              // Action pour changer le paramètre
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriCard(Map<String, dynamic> bien) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              bien['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bien['titre'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bien['localisation'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bien['prix'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              bien['statut'] == 'À vendre'
                                  ? Colors.blue
                                  : Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          bien['statut'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisiteCard(Map<String, dynamic> visite) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                visite['bien'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      visite['statut'] == 'Visité'
                          ? Colors.green
                          : Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  visite['statut'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            visite['localisation'],
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date: ${visite['date']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              if (visite['note'] != null)
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(
                      '${visite['note']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            notification['lu'] ? Colors.white : Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border:
            notification['lu']
                ? null
                : Border.all(color: Colors.blue.withOpacity(0.2)),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getNotificationColor(
                notification['type'],
              ).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getNotificationIcon(notification['type']),
              color: _getNotificationColor(notification['type']),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['titre'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: notification['lu'] ? AppColors.primary : Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['message'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['date'],
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (!notification['lu'])
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'nouveau_bien':
        return Colors.green;
      case 'visite':
        return Colors.blue;
      case 'prix':
        return Colors.orange;
      default:
        return AppColors.primary;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'nouveau_bien':
        return Icons.home;
      case 'visite':
        return Icons.visibility;
      case 'prix':
        return Icons.euro;
      default:
        return Icons.notifications;
    }
  }
}
