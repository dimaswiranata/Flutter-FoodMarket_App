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
                          'https://kprofiles.com/wp-content/uploads/2018/07/cweknagte.jpg'
                        ),
                        fit: BoxFit.cover
                      ),
                    ),
                  )
                ],
              ),
            ),
            // LIST OF FOOD
            Container(
              height: 258,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal, // scroll ke samping
                children: [
                  Row(
                    children: mockFoods.map((food) => Padding(
                      padding: EdgeInsets.only(
                        left: (food == mockFoods.first) ? // mockFoods => index 0 dari mockFoods
                        defaultMargin : 0,
                        right: defaultMargin
                      ),
                      child: FoodCard(food),
                    )).toList(), //Mapping data mockFood ke FoodCard,
                  ),
                ],
              ),
            ),
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
                  Builder(builder: (_) { // Builder untuk  Content Custom Tab Bar berdasarkan 
                  // selectedIndex yang didapatkan dari props onTap dari CustomTabBar
                    List<Food> foods = (selectedIndex == 0) 
                      ? mockFoods
                      :  (selectedIndex == 1)
                        ? []
                        : [];

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
                  }),
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