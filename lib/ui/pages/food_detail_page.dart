part of 'pages.dart';

class FoodDetailPage extends StatefulWidget {
  final Function onBackPressed;
  final Transaction transaction; // Karena diinisialisasi Transaction 
  // jadi membutuhkan Transaction.Food parsing data saat pindah
  // dari food_page.dart ke food_detail_page.dart

  FoodDetailPage({this.onBackPressed, this.transaction});
  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Stack child => background sampai ke atas(sinyal, jam dll)
          Container(
            color: mainColor,
          ),
          // Stack child => background dengan custom color hanya untuk screen app
          SafeArea(
            child: Container(
              color: Colors.white
            ),
          ),
          // Stack Child => Food Image Background
          SafeArea(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.transaction.food.picturePath), // widget.transaction dan widget.onBackPressed, it means memanggil transaction/onBackPressed yang didefinisikan (khusus statefull) karena ditaruh diatas hehe...
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          // Stack Child => Content Depan Background
          SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    //BACK BUTTON
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            if(widget.onBackPressed != null){
                              widget.onBackPressed();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12
                            ),
                            child: Image.asset('lib/assets/back_arrow_white.png'),
                          ),
                        ),
                      ),
                    ),
                    // BODY
                    Container(
                      margin: EdgeInsets.only(top: 180), // Untuk jarak agar keliatan si Food Image
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        ),
                        color: Colors.white
                      ),
                      // COLUMN UNTUK KESELURUHAN CONTENT BODY
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ROW UNTUK (Food Name, Rating) dan (Counter)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //COLUMN UNTUK FOOD NAME AND RATING
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 32 - 102, // 32 margin Container Parent dan 102 dari total width Counter
                                    child: Text(
                                      widget.transaction.food.name,
                                      style: blackFontStyle2
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  RatingStars(widget.transaction.food.rate)
                                ],
                              ),
                              // COUNTER ROW
                              Row(
                                children: [
                                  // BUTTON MIN
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        quantity = max(1, quantity - 1); // 1 minimal pembelian
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "lib/assets/btn_min.png"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // TEXT QUANTITY
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      quantity.toString(),
                                      textAlign: TextAlign.center,
                                      style: blackFontStyle2
                                    ),
                                  ),
                                  // BUTTON ADD
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity = min(99, quantity + 1); // 99 batas pembelian
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "lib/assets/btn_add.png"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // DESCRIPTION
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 14, 0, 16),
                            child: Text(
                              widget.transaction.food.description,
                              style: greyFontStyle
                            ),
                          ),
                          // Ingredients Title
                          Text(
                            'Ingredients',
                            style: blackFontStyle3
                          ),
                          // INGREDIENT
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 41),
                            child: Text(
                              widget.transaction.food.ingredients,
                              style: greyFontStyle,
                            ),
                          ),
                          // Row (TOTAL PRICE) dan (BUTTON ORDER)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // TOTAL PRICE TEXT
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: greyFontStyle.copyWith(fontSize: 13)
                                  ),
                                  Text(
                                    NumberFormat
                                      .currency(
                                        locale: 'id-ID',
                                        symbol: 'IDR ',
                                        decimalDigits: 0
                                      ).format(quantity * widget.transaction.food.price),
                                    style: blackFontStyle2.copyWith(fontSize: 18)
                                  )
                                ],
                              ),
                              // BUTTON ORDER
                              SizedBox(
                                width: 163,
                                height: 45,
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: mainColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Text(
                                    'Order Now',
                                    style: blackFontStyle3.copyWith(
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}