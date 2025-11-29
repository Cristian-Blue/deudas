import 'package:cuenta/model/admin/producto_model.dart';
import 'package:cuenta/services/admin/deuda/deuda_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  bool loading = true;
  List<ProductoModel> deudas = [];

  void getDeudas() async {
    final tempDeuda = await DeudaService.getDeudas();
    setState(() {
      deudas = tempDeuda;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDeudas();
  }

  void sendToDetail(String id) {
    context.push('/admin/deuda/$id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: deudas.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => sendToDetail(deudas[index].id.toString()),
            leading: Text(deudas[index].price.toString()),
            title: Text(deudas[index].title),
            subtitle: Text(deudas[index].description),
          );
        },
      ),
    );
  }
}
