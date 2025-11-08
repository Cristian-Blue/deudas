import 'package:cuenta/services/admin/deuda/deuda_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _proveedorController = TextEditingController();
  bool _isEditing = false;

  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
    customPattern: '\u00A4#,##0', //
  );

  @override
  void initState() {
    super.initState();
    _montoController.addListener(_onMontoChanged);
  }

  @override
  void dispose() {
    _montoController.removeListener(_onMontoChanged);
    super.dispose();
  }

  _onMontoChanged() {
    if (_isEditing) return;

    _isEditing = true;

    String texto = _montoController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (texto.isEmpty) {
      _montoController.text = '';
    } else {
      final numero = int.parse(texto);
      _montoController.text = _formatter.format(numero);
      _montoController.selection = TextSelection.fromPosition(
        TextPosition(offset: _montoController.text.length),
      );
    }

    _isEditing = false;
    setState(() {});
  }

  void _saveDeuda(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please finish all field')));
      return;
    }

    final monto = _montoController.text;
    String montoFormateado = monto.replaceAll(RegExp(r'[^0-9]'), '');
    final descripcion = _descripcionController.text;
    final proveedor = _proveedorController.text;
    String data = await DeudaService.saveDeuda(
      montoFormateado,
      descripcion,
      proveedor,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Registro de deudas'),
            TextFormField(
              controller: _montoController,
              decoration: InputDecoration(
                labelText: 'Monto',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Monto es requerido'
                    : null;
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _saveDeuda(context),
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
