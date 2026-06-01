class Enxaqueca {
  final int? id;
  final DateTime data;
  final int intensidade;
  final String gatilho;
  final String remedio;

  Enxaqueca({
    this.id,
    required this.data,
    required this.intensidade,
    required this.gatilho,
    required this.remedio,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String(),
      'intensidade': intensidade,
      'gatilho': gatilho,
      'remedio': remedio,
    };
  }

  factory Enxaqueca.fromMap(Map<String, dynamic> map) {
    return Enxaqueca(
      id: map['id'],
      data: DateTime.parse(map['data']),
      intensidade: map['intensidade'],
      gatilho: map['gatilho'],
      remedio: map['remedio'],
    );
  }
}