import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../constants/colors.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _chatbotData = [];
  List<_Message> _messages = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadChatbotData();
  }

  Future<void> _loadChatbotData() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/chatbot_data.json',
      );
      setState(() {
        _chatbotData = List<Map<String, dynamic>>.from(json.decode(data));
        _loading = false;
        _messages.add(
          _Message(
            text:
                "Bonjour et bienvenue sur le chatbot HabiLux !\nJe suis votre assistant intelligent, prêt à répondre à vos questions sur l'agence, les biens, les services ou toute autre demande. Posez-moi votre question !",
            isUser: false,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _messages.add(
          _Message(
            text: 'Erreur de chargement du chatbot :\n$e',
            isUser: false,
          ),
        );
        _loading = false;
      });
    }
  }

  void _askQuestion() {
    final question = _controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      _messages.add(_Message(text: question, isUser: true));
    });
    _controller.clear();
    Future.delayed(const Duration(milliseconds: 100), () => _scrollToBottom());

    // Amélioration de l'algorithme de recherche
    final lowerQuestion = question.toLowerCase();
    String answer =
        "Désolé, je n'ai pas compris votre question. Pouvez-vous reformuler ou me poser une question sur nos services immobiliers ?";

    // Recherche par mots-clés avec score de pertinence
    Map<String, double> scores = {};

    for (final entry in _chatbotData) {
      double score = 0;
      final keywords = List<String>.from(entry['keywords']);

      // Vérifier chaque mot-clé
      for (final keyword in keywords) {
        if (lowerQuestion.contains(keyword.toLowerCase())) {
          score += 1;
        }
      }

      // Bonus pour les mots-clés plus longs (plus spécifiques)
      for (final keyword in keywords) {
        if (keyword.length > 3 &&
            lowerQuestion.contains(keyword.toLowerCase())) {
          score += 0.5;
        }
      }

      // Vérifier aussi dans la question
      final questionText = entry['question'].toLowerCase();
      if (lowerQuestion.contains(questionText.split(' ').first) ||
          questionText.contains(lowerQuestion.split(' ').first)) {
        score += 0.3;
      }

      if (score > 0) {
        scores[entry['response']] = score;
      }
    }

    // Trouver la meilleure réponse
    if (scores.isNotEmpty) {
      String bestResponse =
          scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      // Seuil minimum pour accepter une réponse
      double maxScore = scores.values.reduce((a, b) => a > b ? a : b);
      if (maxScore >= 0.5) {
        answer = bestResponse;
      }
    }

    // Réponses par défaut pour des questions communes
    if (lowerQuestion.contains('bonjour') ||
        lowerQuestion.contains('salut') ||
        lowerQuestion.contains('hello')) {
      answer =
          "Bonjour ! Je suis l'assistant virtuel de HabiLux. Comment puis-je vous aider aujourd'hui ?";
    } else if (lowerQuestion.contains('merci') ||
        lowerQuestion.contains('thanks')) {
      answer =
          "Je vous en prie ! N'hésitez pas si vous avez d'autres questions sur nos services immobiliers.";
    } else if (lowerQuestion.contains('au revoir') ||
        lowerQuestion.contains('bye')) {
      answer =
          "Au revoir ! N'hésitez pas à revenir si vous avez d'autres questions. Bonne journée !";
    }

    setState(() {
      _messages.add(_Message(text: answer, isUser: false));
    });
    Future.delayed(const Duration(milliseconds: 100), () => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logohome.png', height: 40),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return Align(
                          alignment:
                              msg.isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  msg.isUser
                                      ? AppColors.primary
                                      : Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(18),
                                topRight: const Radius.circular(18),
                                bottomLeft: Radius.circular(
                                  msg.isUser ? 18 : 4,
                                ),
                                bottomRight: Radius.circular(
                                  msg.isUser ? 4 : 18,
                                ),
                              ),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color:
                                    msg.isUser ? Colors.white : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Écrivez votre message...',
                              border: OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (_) => _askQuestion(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.primary,
                          ),
                          onPressed: _askQuestion,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class _Message {
  final String text;
  final bool isUser;
  _Message({required this.text, required this.isUser});
}
