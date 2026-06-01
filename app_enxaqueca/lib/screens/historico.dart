import 'package:flutter/material.dart';
import '../services/database.dart';
import '../models/enxaqueca.dart';

class HistoricoTela extends StatefulWidget {
  const HistoricoTela({super.key});

  @override
  State<HistoricoTela> createState() => _HistoricoTelaState();
}

class _HistoricoTelaState extends State<HistoricoTela> {
  late Future<List<Enxaqueca>> _registros;

  @override
  void initState() {
    super.initState();
    _registros = DatabaseService().listarTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: FutureBuilder<List<Enxaqueca>>(
        future: _registros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF550C18)),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum registro ainda.\nRegistre sua primeira enxaqueca!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF786452), fontSize: 16),
              ),
            );
          }

          final lista = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];
              return Dismissible(
                key: Key(item.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF550C18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Color(0xFFF7DAD9)),
                ),
                onDismissed: (_) async {
                  await DatabaseService().apagar(item.id!);
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _corDaDor(item.intensidade),
                      child: Text(
                        '${item.intensidade}',
                        style: const TextStyle(
                          color: Color(0xFFF7DAD9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      '${item.data.day}/${item.data.month}/${item.data.year}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF443730),
                      ),
                    ),
                    subtitle: Text(
                      'Gatilho: ${item.gatilho}  •  ${item.remedio}',
                      style: const TextStyle(color: Color(0xFF786452)),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _corDaDor(int valor) {
    if (valor <= 3) return const Color(0xFF786452);
    if (valor <= 6) return const Color(0xFF443730);
    return const Color(0xFF550C18);
  }
}