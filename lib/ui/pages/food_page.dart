part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double listItemWidth = MediaQuery.of(context).size.width - 2 * defaultMargin;
    return ListView(
      children: [
        Column(
          children: [
            // HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Food Market", style: blackFontStyle1,),
                      Text(
                        "Let's get some foods", 
                        style: greyFontStyle.copyWith(fontWeight: FontWeight.w300)
                      ),
                    ],
                  ),
                  // Image
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          // Cara memanggil (User => picturePath) dari cubit/bloc setelah berada di state UserLoaded(user.picturePath)
                          (context.bloc<UserCubit>().state as UserLoaded).user.picturePath
                        ),
                        fit: BoxFit.cover
                      ),
                    ),
                  )
                ],
              ),
            ),

            //-------------------------------------------------------------------------------

            // LIST OF FOOD
            Container(
              height: 258,
              width: double.infinity,
              child: BlocBuilder<FoodCubit, FoodState>( // Cara mengecek berada di state mana
                builder: (_, state) => (state is FoodLoaded) ? ListView( // state <=> FoodLoaded
                  scrollDirection: Axis.horizontal, // scroll ke samping
                  children: [
                    Row(
                      children: state.foods.map((food) => Padding(
                        padding: EdgeInsets.only(
                          left: (food == mockFoods.first) ? // mockFoods => index 0 dari mockFoods
                          defaultMargin : 0,
                          right: defaultMargin
                        ),
                        child: GestureDetector( // Untuk click ke DetailFoodPage
                          onTap: (){
                            Get.to(FoodDetailPage( // FoodDetailPage membutuhkan parameter model Transaction yang ter-load dan onBackPreesed untuk kembali ke MainPage
                              transaction: Transaction( // di model Transaction membutuhkan model Food dan User yang ter-load
                                food: food,
                                user: (context.bloc<UserCubit>().state as UserLoaded).user
                              ),
                              onBackPressed: (){
                                Get.back();
                              },
                            ));
                          },
                          child: FoodCard(food)
                        ),
                      )).toList(), //Mapping data mockFood ke FoodCard,
                    ),
                  ],
                ) : Center(child: loadingIndicator,),
              ),
            ),

            //-------------------------------------------------------------------------------

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