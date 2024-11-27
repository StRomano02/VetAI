class Chat {
  final String name;
  final String imageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final List<Message> messages;

  Chat({
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.messages,
  });
}

class Message {
  final String sender;
  final String text;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}

final List<Chat> exampleChats = [
  Chat(
    name: "Luca Verdi (Adozione)",
    imageUrl: "https://example.com/image1.jpg",
    lastMessage: "Perfetto, sono disponibile nel pomeriggio. A che ora?",
    lastMessageTime: DateTime.now().subtract(Duration(minutes: 5)),
    messages: [
      Message(
        sender: "Luca Verdi",
        text: "Buongiorno, sono interessato ad adottare Luna.",
        timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      ),
      Message(
        sender: "Me",
        text:
            "Buongiorno, Luna è ancora disponibile! Possiamo fissare un incontro.",
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      ),
      Message(
        sender: "Luca Verdi",
        text: "Perfetto, sono disponibile nel pomeriggio. A che ora?",
        timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      ),
    ],
  ),
  Chat(
    name: "Dr. Marco Rossi (Consulenza)",
    imageUrl: "https://example.com/image2.jpg",
    lastMessage: "Grazie mille! Aspetto le informazioni.",
    lastMessageTime: DateTime.now().subtract(Duration(minutes: 40)),
    messages: [
      Message(
        sender: "Me",
        text:
            "Ciao Marco, hai esperienza con casi di allergia alimentare nei gatti?",
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
      ),
      Message(
        sender: "Dr. Marco Rossi",
        text: "Sì, ho avuto diversi casi. Posso condividere una dieta adatta.",
        timestamp: DateTime.now().subtract(Duration(minutes: 50)),
      ),
      Message(
        sender: "Me",
        text: "Grazie mille! Aspetto le informazioni.",
        timestamp: DateTime.now().subtract(Duration(minutes: 40)),
      ),
    ],
  ),
  Chat(
    name: "Giulia Bianchi (Adozione)",
    imageUrl: "https://example.com/image3.jpg",
    lastMessage: "Posso venire a conoscere Max domani?",
    lastMessageTime: DateTime.now().subtract(Duration(hours: 1)),
    messages: [
      Message(
        sender: "Giulia Bianchi",
        text: "Ciao, volevo sapere di più su Max, il Labrador.",
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
      Message(
        sender: "Me",
        text: "Certo, Max ha 3 anni ed è molto socievole. È già vaccinato.",
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 45)),
      ),
      Message(
        sender: "Giulia Bianchi",
        text: "Posso venire a conoscere Max domani?",
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
      ),
    ],
  ),
  Chat(
    name: "Dr. Elisa Neri (Aggiornamento)",
    imageUrl: "https://example.com/image4.jpg",
    lastMessage: "Luna sta recuperando bene. Grazie per l'interesse!",
    lastMessageTime: DateTime.now().subtract(Duration(hours: 3)),
    messages: [
      Message(
        sender: "Me",
        text: "Ciao Elisa, come sta Luna dopo l'operazione?",
        timestamp: DateTime.now().subtract(Duration(hours: 4)),
      ),
      Message(
        sender: "Dr. Elisa Neri",
        text: "Sta recuperando bene. Mangia regolarmente e sembra attiva.",
        timestamp: DateTime.now().subtract(Duration(hours: 3, minutes: 45)),
      ),
      Message(
        sender: "Me",
        text: "Ottimo, grazie per l'aggiornamento!",
        timestamp: DateTime.now().subtract(Duration(hours: 3)),
      ),
    ],
  ),
  Chat(
    name: "Matteo Blu (Adozione)",
    imageUrl: "https://example.com/image5.jpg",
    lastMessage: "Un giovane gatto sarebbe perfetto.",
    lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
    messages: [
      Message(
        sender: "Matteo Blu",
        text: "Buonasera, mi piacerebbe adottare un gatto. Avete suggerimenti?",
        timestamp: DateTime.now().subtract(Duration(days: 1, hours: 1)),
      ),
      Message(
        sender: "Me",
        text:
            "Buonasera, abbiamo diversi gatti disponibili. Che età preferirebbe?",
        timestamp: DateTime.now().subtract(Duration(days: 1, hours: 23)),
      ),
      Message(
        sender: "Matteo Blu",
        text: "Un giovane gatto sarebbe perfetto.",
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
    ],
  ),
];
