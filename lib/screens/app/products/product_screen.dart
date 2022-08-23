import 'package:database_elancer/models/proccess_responce.dart';
import 'package:database_elancer/models/product.dart';
import 'package:database_elancer/prefs/shared_pref_controller.dart';
import 'package:database_elancer/provider/products_provider.dart';
import 'package:database_elancer/utils/context_extinsion.dart';
import 'package:database_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _infoTextController;
  late TextEditingController _priceTextController;
  late TextEditingController _quantityTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _infoTextController = TextEditingController();
    _priceTextController = TextEditingController();
    _quantityTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _infoTextController.dispose();
    _priceTextController.dispose();
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.create_product),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Text(
            context.localizations.create_product,
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            hint: context.localizations.name,
            prefixIcon: Icons.title,
            keyboardType: TextInputType.text,
            textEditingController: _nameTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            hint: context.localizations.info,
            prefixIcon: Icons.info,
            keyboardType: TextInputType.text,
            textEditingController: _infoTextController,
          ),
          SizedBox(
            height: 20,
            child: Row(
              children: [
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  hint: context.localizations.price,
                  prefixIcon: Icons.money,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  textEditingController: _priceTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  hint: context.localizations.quantity,
                  prefixIcon: Icons.production_quantity_limits,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  textEditingController: _quantityTextController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _performSave() {
    if (_checkData()) _save();
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty &&
        _priceTextController.text.isNotEmpty &&
        _quantityTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(
        message: context.localizations.error_data, error: true);
    return false;
  }

  Future<void> _save() async {
    ProcessResponse processResponse =
        await Provider.of<ProductsProvider>(context, listen: false)
            .create(product);
    context.showSnackBar(
        message: processResponse.message, error: !processResponse.success);

    if (processResponse.success) {
      _clear();
    }
  }

  Product get product {
    Product product = Product();
    product.name = _nameTextController.text;
    product.info = _infoTextController.text;
    product.price = double.parse(_priceTextController.text);
    product.quantity = int.parse(_quantityTextController.text);
    product.userId = SharedPrefController().getValueFor<int>(PrefKeys.id.name)!;
    return product;
  }

  void _clear() {
    _nameTextController.clear();
    _infoTextController.clear();
    _priceTextController.clear();
    _quantityTextController.clear();
  }
}
