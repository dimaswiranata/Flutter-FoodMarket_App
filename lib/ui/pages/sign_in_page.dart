part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return GeneralPage(
      title: 'Sign In',
      subtitle: 'Find your best ever meal',
      child: Column(
        children: [
          // Container Text "Email Address"
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text('Email Addres', style: blackFontStyle2),
          ),
          // Container TextField "Email Address"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField( 
              controller: emailController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your email address" //placeholder
              ),
            ),
          ),
          // Container Text "Password"
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('Password', style: blackFontStyle2),
          ),
          // Container TextField "Password"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your password" //placeholder
              ),
            ),
          ),
          // button Sign In
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: isLoading ? 
            (
              loadingIndicator
            ) : (
              RaisedButton(
                onPressed: () async {
                  setState(() { // set untuk menampilkan loadingIndicaotr
                    isLoading = true;
                  });
                  
                  // memanggil method signIn di cubit UserCubit 
                  await context.bloc<UserCubit>().signIn(emailController.text, passwordController.text);
                  // memanggil berada dimana UserState saat ini
                  UserState state = context.bloc<UserCubit>().state;
                  
                  // jika state UserCubit di UserLoaded / data berhasil didapatkan maka
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
                  'Sign In',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            )
          ),
          // button ke Sign Up Page
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: isLoading ? 
            (
              SpinKitFadingCircle(
                size: 45, 
                color: mainColor,
              )
            ) : (
              RaisedButton(
                onPressed: () {
                  Get.to(SignUpPage());
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                color: greyColor,
                child: Text(
                  'Create New Account',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            )
          )
        ],
      ),
    );
  }
}