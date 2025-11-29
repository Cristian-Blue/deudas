import 'package:cuenta/model/admin/producto_model.dart';
import 'package:cuenta/services/admin/deuda/deuda_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  bool loading = true;
  List<ProductoModel> deudas = [ProductoModel.fromJson({})];

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
      body: Skeletonizer(
        enabled: loading,
        enableSwitchAnimation: true,
        child: ListTileCustom(deudas.length, deudas),
      ),
    );
  }

  ListView ListTileCustom(int itemCount, List<ProductoModel> deudas) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => sendToDetail(deudas[index].id.toString()),
          leading: Text(deudas[index].price.toString()),
          title: Text(deudas[index].title),
          subtitle: Text(deudas[index].description),
        );
      },
    );
  }
}
