part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final String password;
  final File pictureFile;

  AddressPage(this.user, this.password, this.pictureFile);
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  bool isLoading = false;
  List<String> cities;
  String selectedCity;

  @override
  void initState(){
    super.initState();

    cities = ["Bandung", "Jakarta", "Surabaya", "Bengkulu"];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {

    return GeneralPage(
      title: 'Address',
      subtitle: "Make sure it's valid",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          // Container Text "Phone Number"
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text('Phone No.', style: blackFontStyle2),
          ),
          // Container TextField "Phone Number"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField( 
              controller: phoneController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your phone number" //placeholder
              ),
            ),
          ),
          // Container Text "Address"
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('Address', style: blackFontStyle2),
          ),
          // Container TextField "Address"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField( 
              controller: addressController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your address" //placeholder
              ),
            ),
          ),
          // Container Text "House Number"
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('House No.', style: blackFontStyle2),
          ),
          // Container TextField "House Number"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField(
              controller: houseNumController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your house number" //placeholder
              ),
            ),
          ),
          // Container Text "House Number"
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('City.', style: blackFontStyle2),
          ),
          // Container TextField "House Number"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: DropdownButton(
              value: selectedCity,
              // isExpanded: true,
              underline: SizedBox(),
              items: cities.map(
                (city) => 
                DropdownMenuItem(
                  value: city,
                  child: Text(
                    city,
                    style: blackFontStyle3,
                  ),
                )
              ).toList(),
              onChanged: (item){ // item salah satu dari value di items
                setState(() {
                  selectedCity = item;
                });
              },
            ),
          ),
          // button Sign Up
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: (isLoading == true) ?
              (
                Center(
                  child: loadingIndicator,
                )
              ):(
                RaisedButton(
                  onPressed: () async {
                    // todo: menerima data user dari sign_up_page.dart dan menambahkan dari TextField address_page.dart
                    User user = widget.user.copyWith(
                      phoneNumber: phoneController.text,
                      address: addressController.text,
                      houseNumber: houseNumController.text,
                      city: selectedCity
                    );

                    // todo: mengubah isLoading menjadi True
                    setState(() {
                      isLoading = true;
                    });

                    // memanggil method signUp di cubit UserCubit 
                    await context.bloc<UserCubit>().signUp(user, widget.password, pictureFile: widget.pictureFile);
                    // memanggil berada dimana UserState saat ini
                    UserState state = context.bloc<UserCubit>().state;
                      
                    // jika state UserCubit di UserLoaded / response berhasil didapatkan maka
                    // memanggil method getFoods di cubit FoodCubit & getTransactions di TransactionCubit
                    // dan Navigation ke MainPage();
                    if (state is UserLoaded){
                      context.bloc<FoodCubit>().getFoods();
                      context.bloc<TransactionCubit>().getTransactions();
                      Get.to(MainPage());
                    } else { // jika state UserCubit di UserLoadingFailed / gagal mendapatkan data maka
                      // Notify/Pop Up dari Get
                      Get.snackbar(
                        "", "",
                        backgroundColor: "D9435E".toColor(),
                        icon: Icon( // Icon X
                          MdiIcons.closeCircleOutline,
                          color: Colors.white
                        ),
                        titleText: Text(
                          "Sign In Failed",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight : FontWeight.w600
                          ),
                        ),
                        messageText: Text(
                          // Cara memanggil message dari cubit/bloc jika berada di state UserLoadingFailed(UserLoadingFailed.message)
                          (state as UserLoadingFailed).message,
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  color: mainColor,
                  child: Text(
                    'Sign Up Now',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              )
          ),
        ],
      ),
    );
  }
}