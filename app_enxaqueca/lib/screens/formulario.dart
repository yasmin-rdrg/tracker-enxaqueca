import 'package:flutter/material.dart';
import '../services/database.dart';
import '../models/enxaqueca.dart';

class FormularioTela extends StatefulWidget {
  const FormularioTela({super.key});

  @override
  State<FormularioTela> createState() => _FormularioTelaState();
}

class _FormularioTelaState extends State<FormularioTela> {
  double _intensidade = 5;
  String _gatilho = 'Estresse';
  final _remedioController = TextEditingController();
  DateTime _data = DateTime.now();

  final List<String> _gatilhos = [
    'Estresse',
    'Falta de sono',
    'Barulho',
    'Luz forte',
    'Hormônios',
    'Alimentação',
    'Clima',
    'Não sei',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Data',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF443730))),
            const SizedBox(height: 8),
            Text(
              '${_data.day}/${_data.month}/${_data.year}',
              style: const TextStyle(fontSize: 16, color: Color(0xFF443730)),
            ),
            TextButton(
              onPressed: () async {
                final escolhida = await showDatePicker(
                  context: context,
                  initialDate: _data,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFF550C18),
                          onPrimary: Color(0xFFF7DAD9),
                          surface: Color(0xFFF7DAD9),
                          onSurface: Color(0xFF443730),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (escolhida != null) {
                  setState(() => _data = escolhida);
                }
              },
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF550C18)),
              child: const Text('Alterar data'),
            ),

            const Divider(height: 32, color: Color(0xFFA5907E)),

            const Text('Intensidade da dor',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF443730))),
            const SizedBox(height: 4),
            Text(
              '${_intensidade.round()} / 10',
              style: TextStyle(fontSize: 28, color: _corDaDor(_intensidade), fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _intensidade,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (valor) => setState(() => _intensidade = valor),
            ),

            const Divider(height: 32, color: Color(0xFFA5907E)),

            const Text('Possível gatilho',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF443730))),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _gatilho,
              items: _gatilhos.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (valor) => setState(() => _gatilho = valor!),
              dropdownColor: const Color(0xFFF7DAD9),
              style: const TextStyle(color: Color(0xFF443730)),
            ),

            const Divider(height: 32, color: Color(0xFFA5907E)),

            const Text('Remédio tomado',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF443730))),
            const SizedBox(height: 8),
            TextField(
              controller: _remedioController,
              decoration: const InputDecoration(hintText: 'ex: Ibuprofeno 400mg'),
            ),

            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.save),
              label: const Text('Salvar registro'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                minimumSize: const Size(double.infinity, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _corDaDor(double valor) {
    if (valor <= 3) return const Color(0xFF786452);
    if (valor <= 6) return const Color(0xFF550C18).withValues(alpha: 0.6);
    return const Color(0xFF550C18);
  }

  Future<void> _salvar() async {
    final novoRegistro = Enxaqueca(
      data: _data,
      intensidade: _intensidade.round(),
      gatilho: _gatilho,
      remedio: _remedioController.text.isEmpty ? 'Nenhum' : _remedioController.text,
    );
    await DatabaseService().inserir(novoRegistro);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro salvo!'),
          backgroundColor: Color(0xFF550C18),
        ),
      );
      Navigator.pop(context);
    }
  }
}