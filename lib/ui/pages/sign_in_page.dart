part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool isLoading = false;

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
              SpinKitFadingCircle(
                size: 45, 
                color: mainColor,
              )
            ) : (
              RaisedButton(
                onPressed: () {},
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