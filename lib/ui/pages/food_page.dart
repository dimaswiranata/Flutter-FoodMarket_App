part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0; //* selectedIndex untuk index dari CustomTabbar ['New Taste', 'Popular, 'Recomended']
  @override
  Widget build(BuildContext context) {
    double listItemWidth = MediaQuery.of(context).size.width - 2 * defaultMargin; //* listItemWidth untuk width FoodListItem
    return ListView( // todo: ListView biar screen bisa di Scroll
      children: [

        // todo: Column untuk keseluruhan widget Isi Content
        Column(
          children: [

            // todo ------------------------------ HEADER ----------------------------------

            // todo: Container untuk HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white, //* Background Color dari Container Header
              height: 100, //* height dari Header
              width: double.infinity,  //* width Header Container sesuai layar

              // todo: Row untuk Column(title, subtitle) dan Container(User.picturePath)
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween  
                children: [
                  
                  // todo: Text Row untuk Column(title, subtitle)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                    mainAxisAlignment: MainAxisAlignment.center, //* Column (MainAxisAlignment/Vertical) <=> center
                    children: [

                      // todo: title Text("Food Market")
                      Text("Food Market", style: blackFontStyle1,),
                      
                      // todo: subtitle Text("Let's get some foods")
                      Text(
                        "Let's get some foods", 
                        style: greyFontStyle.copyWith(fontWeight: FontWeight.w300)
                      ),
                    ],
                  ),

                  // todo: Container untuk Image (User.picturePath)
                  Container(
                    width: 50,
                    height: 50,
                     //* Container decoration => BoxDecoration bisa punya background Image dengan DecorationImage
                    decoration: BoxDecoration( //* decoration -> BoxDecoration untuk Container,
                      borderRadius: BorderRadius.circular(8), //* untuk Style Container
                      image: DecorationImage( //*
                        image: NetworkImage(
                          // todo: Memanggil secara langsung User.picturePath melalui bloc apabila UserState sudah berada di UserLoaded
                          //* note: tidak perlu di cek UserState berada dimana karena sudah diload di Sign In/Sign Up
                          (context.bloc<UserCubit>().state as UserLoaded).user.picturePath
                        ),
                        fit: BoxFit.cover
                      ),
                    ),
                  )
                ],
              ),
            ),

            // todo ------------------------------ LIST OF FOOD ----------------------------------

            // todo: Container untuk LIST FOOD Scrool Horizontal
            Container(
              height: 258,
              width: double.infinity,
              
              // todo: BlocBuilder untuk menghubungkan widget2 dengan BlocProvider, 
              //* menghubungkan widget dengan FoodCubit dan FoodState
              child: BlocBuilder<FoodCubit, FoodState>( 
                
                // todo: cek Berada dimana FoodState parameter 'state' di builder adalah FoodState
                builder: (_, state) => (state is FoodLoaded) ? // todo: cek jika state sekarang adalah FoodLoaded maka
                ( 
                  // todo: menampilkan ListView scroll Horizontal dengan Widget Component FoodCard 
                  ListView(
                    scrollDirection: Axis.horizontal, //* scroll ke samping
                    children: [
                      // todo: Row untuk FoodCard
                      Row(
                        // todo: Memapping state.foods <=> FoodLoaded.foods ke FoodCard
                        children: state.foods.map((food) => Padding( //todo: FoodCard dibungkus Padding biar berjarak antar FoodCard
                          padding: EdgeInsets.only(
                            left: (food == state.foods.first) ? // todo: paddingLeft ditentukan apabila index ke [0] maka menggunakan defaultMargin
                            defaultMargin : 0, //! jika tidak maka 0
                            right: defaultMargin
                          ),
                          child: GestureDetector( // todo: FoodCard dibungkus lagi dengan GestureDetector untuk navigasi ke FoodDetailPage
                            onTap: (){
                              Get.to(FoodDetailPage( //* FoodDetailPage membutuhkan parameter model Transaction yang ter-load dan onBackPreesed untuk kembali ke MainPage
                                transaction: Transaction( //* di model Transaction membutuhkan model Food dan User yang ter-load
                                  food: food,
                                  // todo: Memanggil secara langsung User melalui bloc/cubit apabila UserState sudah berada di UserLoaded
                                  user: (context.bloc<UserCubit>().state as UserLoaded).user
                                ),
                                onBackPressed: (){
                                  Get.back(); // todo: Navigasi kembali ke MainPage()
                                },
                              ));
                            },
                            child: FoodCard(food) //todo: FoodCard diisi state.foods
                          ),
                        )).toList(), //* Mapping data mockFood ke FoodCard,
                      ),
                    ],
                  )
                ) : Center(child: loadingIndicator,),
              ),
            ),

            // todo -----------------------------LIST OF FOOD WITH TAB BAR---------------------------------

            // LIST OF FOOD (TAB BAR)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  // CUSTOM TAB BAR
                  CustomTabBar(
                    titles: ["New Taste", "Popular", "Recomended"], 
                    selectedIndex: selectedIndex,
                    // Cara menggunakan props Function dari widget dengan ANONYMOUS FUNCTION
                    onTap: (index){ // untuk mendaoatkan index dari onTap di CustomTabBar kemudian di set di selected index untuk 
                      // menentukan title active dan body active di Builder
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  // GAP KE LIST FOOD
                  SizedBox(
                    height: 16,
                  ),
                  // LIST FOOD
                  BlocBuilder<FoodCubit, FoodState>(builder: (_, state) // Cara mengecek berada di state mana
                    {
                      if(state is FoodLoaded) { 
                      // Content Custom Tab Bar berdasarkan 
                      // selectedIndex yang didapatkan dari props onTap dari CustomTabBar
                        List<Food> foods = state.foods.where(
                          (element) => element.types.contains(
                            (selectedIndex == 0) 
                              ? FoodType.new_food
                              :  (selectedIndex == 1)
                                ? FoodType.popular
                                : FoodType.recommended
                          )
                        ).toList();

                        return Column(
                          children: 
                            foods.map(
                              (food) => 
                                Padding(
                                  padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
                                  child: FoodListItem(
                                    food: food, 
                                    itemWidth: listItemWidth
                                  ),
                                )
                            ).toList(),
                        );
                      } else {
                        return Center(child: loadingIndicator,);
                      }
                    }
                  ),
                ]
              )
            ),
            SizedBox(height: 80)
          ]
        ),
      ],
    );
  }
}