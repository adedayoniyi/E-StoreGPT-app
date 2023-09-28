import 'package:estoregpt/features/search/models/searched_product_model.dart';
import 'package:estoregpt/features/search/services/search_services.dart';
import 'package:estoregpt/features/search/widgets/product_grid.dart';
import 'package:estoregpt/features/search/widgets/quick_search_container.dart';
import 'package:estoregpt/providers/drawer_provider.dart';
import 'package:estoregpt/widgets/height_space.dart';
import 'package:estoregpt/widgets/type_writer_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  static const String route = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchServices searchServices = SearchServices();
  String response = "";
  bool hasTappedQuickSearch = false;
  SearchedProduct? searchedProduct;
  bool isLoading = false;
  bool responseHasEnded = false;
  List<String> suggestionPrompts = [
    "Do you have any discounts available for iphone 14?",
    "Can you recommend some high quality washing machines that are very user friendly",
    "Can you tell me who you are and what you can do please",
    "Generate a poem for me please",
    "Are you constantly improving?",
    "Solve for x in x-2+2=0 assuning x is a whole number",
    // "Solve for x in x-2+2=0 assuning x is a whole number",
    // "Solve for x in x-2+2=0 assuning x is a whole number",
  ];
  List<Color> qucikSearchContainerColor = [
    Color(0xFF70d5f8),
    Color(0xFFd3c8ea),
    Color(0xFFffc8a7),
    Color(0xFFfea37b),
    Color(0xFF70d5f8),
    Color(0xFFd3c8ea),
    // Color(0xFFd3c8ea),
    // Color(0xFFd3c8ea),
  ];

  void searchProduct() async {
    setState(() {
      isLoading = true;
      hasTappedQuickSearch = true;
    });

    final result =
        await searchServices.searchProduct(query: smartSearchController.text);
    // print(result.message);

    setState(() {
      searchedProduct = result;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPreferenceAndShowDialog();
  }

  void _checkPreferenceAndShowDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? shouldNotShowDialog = prefs.getBool('shouldNotShowDialog');
    print(shouldNotShowDialog);

    if (shouldNotShowDialog == null || !shouldNotShowDialog) {
      _getResponseAndShowDialog();
    }
  }

  void _getResponseAndShowDialog() async {
    response = await searchServices.generateWelcomeResponse();

    if (mounted) {
      // After getting the response, show the dialog
      showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 100,
            child: FittedBox(
              fit: BoxFit.contain,
              child: AlertDialog(
                backgroundColor: Color(0xFFf6faf9),
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                actions: [
                  TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('shouldNotShowDialog', true);
                        Navigator.of(context).pop();
                      },
                      child: Text("Dont show again"))
                ],
                title: Image.asset(
                  "assets/images/full_logo.png",
                  height: 55,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 13),
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 30,
                    ),
                    ChatBubble(
                      clipper: ChatBubbleClipper1(
                        type: BubbleType.receiverBubble,
                      ),
                      backGroundColor: Colors.white,
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.55,
                          // maxHeight: 70,
                        ),
                        child: TypeWriterTexts(
                          text: response.isNotEmpty
                              ? response // Display the received response
                              : "No response received", // Display a placeholder or an error message when there is no response.
                          duration: Duration(seconds: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  final TextEditingController smartSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xFFf6faf9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Image.asset(
          "assets/images/full_logo.png",
          height: 55,
        ),
        leading: isDesktop
            ? null
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () =>
                    Provider.of<DrawerProvider>(context, listen: false)
                        .openDrawer(),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.feedback_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf6faf9),
              Color(0xFFf1eef7),
              // Colors.red,
              // Colors.red,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.030),
          child: Column(
            children: [
              Text("Note: Database products are currently limited"),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: smartSearchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: isDesktop ? 30 : 10,
                              top: 10,
                              bottom: 10,
                              right: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            height: isDesktop ? 30 : 25,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3075c0),
                              border: Border.all(
                                color: const Color(0xFF3075c0),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BETA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      minLines: 1,
                      maxLines: 2,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: searchProduct,
                    child: Container(
                      width: getValueForScreenType<double>(
                        context: context,
                        mobile: 60,
                        tablet: 60,
                        desktop: 200,
                      ),
                      height: getValueForScreenType<double>(
                        context: context,
                        mobile: 55,
                        tablet: 60,
                        desktop: 60,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF70d5f8),
                          Color(0xFFd3c8ea),
                          Color(0xFFffc8a7),
                          Color(0xFFfea37b)
                        ]),
                        borderRadius: BorderRadius.circular(isMobile ? 20 : 20),
                      ),
                      child: getValueForScreenType<bool>(
                        context: context,
                        mobile: false,
                        tablet: true,
                      )
                          ? const Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const Center(child: Icon(Icons.search)),
                    ),
                  ),
                ],
              ),
              HeightSpace(10),
              hasTappedQuickSearch == false
                  ? Column(
                      children: [
                        SizedBox(height: 15),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Quick Searches",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.bolt,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 420,
                            tablet: 420,
                            desktop: 360,
                          ),
                          child: ListView.builder(
                            itemCount: qucikSearchContainerColor.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  smartSearchController.text =
                                      suggestionPrompts[index];
                                  smartSearchController.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                        offset:
                                            smartSearchController.text.length),
                                  );
                                  searchProduct();
                                },
                                child: Column(
                                  children: [
                                    QuickSearchContainer(
                                      borderColor:
                                          qucikSearchContainerColor[index],
                                      searchText: suggestionPrompts[index],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : isLoading
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: JumpingDots(
                              color: Color(0xFF70d5f8),
                              radius: 10,
                              numberOfDots: 3,
                              animationDuration: Duration(milliseconds: 200),
                            ),
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              height: 35,
                            ),
                            ChatBubble(
                              clipper: ChatBubbleClipper1(
                                type: BubbleType.receiverBubble,
                              ),
                              backGroundColor: Colors.white,
                              margin: EdgeInsets.only(top: 20),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: getValueForScreenType<double>(
                                    context: context,
                                    mobile: MediaQuery.of(context).size.width *
                                        0.75,
                                    tablet: 60,
                                    desktop:
                                        MediaQuery.of(context).size.width * 0.6,
                                  ),
                                ),
                                child: TypeWriterTexts(
                                  text: searchedProduct?.message ??
                                      'Error occurred!',
                                  duration: Duration(seconds: 4),
                                  onEnd: () {
                                    setState(() {
                                      responseHasEnded = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
              HeightSpace(15),
              hasTappedQuickSearch == false ||
                      searchedProduct == null ||
                      searchedProduct!.products.isEmpty
                  ? SizedBox()
                  : responseHasEnded
                      ? Expanded(
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getValueForScreenType<int>(
                                context: context,
                                mobile: 2,
                                tablet: 3,
                                desktop: 4,
                              ),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: searchedProduct!.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: ProductGrid(
                                  image: searchedProduct!
                                      .products[index].images[0],
                                  productName:
                                      searchedProduct!.products[index].name,
                                  productPrice: searchedProduct!
                                      .products[index].price
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
