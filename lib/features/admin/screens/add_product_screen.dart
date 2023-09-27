import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:estoregpt/features/admin/services/admin_services.dart';
import 'package:estoregpt/widgets/custom_button.dart';
import 'package:estoregpt/widgets/height_space.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../widgets/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  static const String route = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController firstColorControlller = TextEditingController();
  final TextEditingController secondColorControlller = TextEditingController();
  final TextEditingController specificationsController =
      TextEditingController();

  final TextEditingController discountPercentageController =
      TextEditingController();

  //Creating an instance of adminServices from lib/features/admin/services/admin_service.dart
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<XFile> _images = [];

  // List<XFile> images = [];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'KitchenWare',
    'Appliances',
    'Electronics',
    'Accessories',
    "Foods"
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && _images.isNotEmpty) {
      adminServices.addProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: int.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        category: category,
        images: _images,
        brand: brandController.text,
        colors: [firstColorControlller.text, secondColorControlller.text],
        discountPercentage: int.parse(discountPercentageController.text),
        size: sizeController.text,
        specifications: specificationsController.text,
      );
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    setState(() {
      _images = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                // gradient: GlobalVariables.appBarGradient,
                ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType<double>(
                context: context,
                mobile: 20,
                tablet: 20,
                desktop: 300,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                //if images is Not empty,
                //Display a Carousel slider
                //or Our Dotted Border Contaainer
                _images.isNotEmpty
                    ? CarouselSlider(
                        items: _images.map((i) {
                          return Builder(
                            builder: (BuildContext context) => Image.network(
                              i.path, // Use the path property of the XFile
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: pickImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                CustomTextField(
                  controller: brandController,
                  hintText: 'Brand',
                ),
                CustomTextField(
                  controller: sizeController,
                  hintText: 'Size(Optional)',
                ),
                CustomTextField(
                  controller: discountPercentageController,
                  hintText: 'Discount',
                ),
                CustomTextField(
                  controller: firstColorControlller,
                  hintText: 'Color 1',
                ),
                CustomTextField(
                  controller: secondColorControlller,
                  hintText: 'Color 2',
                ),
                CustomTextField(
                  controller: specificationsController,
                  hintText: 'Specifications',
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  buttonText: 'Add',
                  onTap: sellProduct,
                  buttonTextColor: Colors.white,
                ),
                const HeightSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
