part of 'pages.dart';

class PaymentPage extends StatefulWidget {
  final Transaction transaction;

  PaymentPage({this.transaction});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false; 

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Payment',
      subtitle: 'You deserve better meal',
      onBackButtonPressed: () {
        Get.back();
      },
      backColor: 'FAFAFC'.toColor(),

      // COLUMN ALL CONTENT
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,

            // COLUMN 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TITLE "ITEM ORDERED"
                Text(
                  'Item Ordered',
                  style: blackFontStyle3,
                ),
                SizedBox(
                  height: 12,
                ),

                // ROW => spaceBetwen (FOOD IMAGE, FOOD PRICE & FOOD NAME) <=> (QUANTITY)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // ROW (FOOD IMAGE) <=> (COLUMN(FOOD PRICE & FOOD NAME))
                    Row(
                      children: [

                        // FOOD IMAGE
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(widget.transaction.food.picturePath),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),

                        // COLUMN => (FOOD PRICE & FOOD NAME)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // FOOD NAME
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 
                              2 * defaultMargin - 
                              60 - 
                              12 - 
                              78, 
                              // Note : 
                              // lebar layar HP - 
                              // (2 * margin horizontal (24)) - 
                              // (width FOOD IMAGE) - 
                              // (margin FOOD IMAGE ke SizedBox FOOD NAME) - 
                              // (width QUANTITY) 
                              child: Text(
                                widget.transaction.food.name,
                                style: blackFontStyle2,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),

                            // FOOD PRICE
                            Text(
                              NumberFormat
                                .currency(
                                  locale: 'id-ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0
                                )
                                .format(
                                  widget.transaction.food.price
                                ),
                              style: greyFontStyle.copyWith(fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),

                    // QUANTITY
                    Text(
                      '${widget.transaction.quantity} item(s)',
                      style: greyFontStyle.copyWith(fontSize: 13),
                    ),

                  ],
                ),

                // TITLE "DETAILS TRANSACTION"
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    "Details Transaction",
                    style: blackFontStyle3,
                  ),
                ),

                // ROW "DETAILS TRANSACTION"

                // ROW <=> SPACE BETWEEN (FOOD NAME) <=> (TOTAL TRANSACTION)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        widget.transaction.food.name,
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ',
                            decimalDigits: 0
                          )
                          .format(
                            widget.transaction.total
                          ),
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (DRIVER) <=> (DELIVERY FEE)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "Driver",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ',
                            decimalDigits: 0
                          )
                          .format(
                            50000
                          ),
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (TAX 10%) <=> (TAX FEE)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "Tax 10%",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ',
                            decimalDigits: 0
                          )
                          .format(
                            widget.transaction.total * 0.1
                          ),
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (DRIVER) <=> (DELIVERY FEE)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "Total",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ',
                            decimalDigits: 0
                          )
                          .format(
                            widget.transaction.total * 1.1 + 50000 // 50.000 => Driver
                          ),
                        style: blackFontStyle3.copyWith(fontWeight: FontWeight.w500, color: '1ABC9C'.toColor()),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

              ],
            ),
          ),

          // --------------------------------------------------------------------------------------

          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,

            // COLUMN 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TITLE "DELIVER TO"
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    "Deliver to : ",
                    style: blackFontStyle3,
                  ),
                ),

                // ROW "DETAILS TRANSACTION"

                // ROW <=> SPACE BETWEEN (NAME) <=> (USER NAME)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "Name",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        widget.transaction.user.name,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (PHONE NO.) <=> (USER PHONE NUMBER)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "Phone No.",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        widget.transaction.user.phoneNumber,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (ADDRESS) <=> (USER ADDRESS)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "Address",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        widget.transaction.user.address,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (HOUSE NO.) <=> (USER HOUSE NUMBER)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "House No.",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        widget.transaction.user.houseNumber,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                // ROW <=> SPACE BETWEEN (CITY) <=> (USER CITY)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        "City",
                        style: greyFontStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, // (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)
                      child: Text(
                        widget.transaction.user.city,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

              ],
            ),
          ),

          // --------------------------------------------------------------------------------------
          
          // BUTTON "CHECKOUT NOW"
          (isLoading) ? 
            Center(child: loadingIndicator,) 
            : 
            Container(
            width: double.infinity,
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: RaisedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                bool result = await context.bloc<TransactionCubit>().submitTransaction(widget.transaction.copyWith(
                  dateTime: DateTime.now(),
                  total: (widget.transaction.total * 1.1).toInt() + 50000
                ));

                if (result == true){
                  Get.to(SuccessOrderPage());
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Get.snackbar(
                    "", "",
                    backgroundColor: "D9435E".toColor(),
                    icon: Icon(
                      MdiIcons.closeCircleOutline,
                      color: Colors.white
                    ),
                    titleText: Text(
                      "Transaction Failed",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    messageText: Text(
                      "Please try again later",
                      style: GoogleFonts.poppins(
                        color: Colors.white
                      ),
                    )
                  );
                }
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              color: mainColor,
              child: Text(
                'Checkout Now',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}