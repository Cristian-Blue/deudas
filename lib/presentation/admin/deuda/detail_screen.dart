import 'package:cuenta/model/admin/producto_model.dart';
import 'package:cuenta/presentation/shared/images/images_widget.dart';
import 'package:cuenta/services/admin/deuda/deuda_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ProductoModel data = ProductoModel.fromJson({});
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
    customPattern: '\u00A4#,##0', //
  );
  getDetail() async {
    final ProductoModel response = await DeudaService.getDetail(widget.id);
    print(response);
    setState(() {
      data = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data.title,
                      style: TextStyle(fontSize: 24),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    _formatter.format(data.price),
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ImagesWidget(images: data.images),
              SizedBox(height: 16),
              Chip(label: Text(data.category)),
              SizedBox(height: 16),
              Text(data.description, textAlign: TextAlign.justify),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Añadir'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
