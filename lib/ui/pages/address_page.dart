part of 'pages.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController houseNumController = TextEditingController();

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
              isExpanded: true,
              underline: SizedBox(),
              items: [
                DropdownMenuItem(child: 
                  Text(
                    'Bandung',
                    style: blackFontStyle3,
                  ),
                ),
                DropdownMenuItem(child: 
                  Text(
                    'Jakarta',
                    style: blackFontStyle3,
                  ),
                ),
                DropdownMenuItem(child: 
                  Text(
                    'Surabaya',
                    style: blackFontStyle3,
                  ),
                ),
              ],
              onChanged: (item){},
            ),
          ),
          // button Sign Up
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: RaisedButton(
              onPressed: () {
                Get.to(MainPage());
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
          ),
        ],
      ),
    );
  }
}