part of 'widgets.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  final List<String> titles;

  CustomTabBar({
    this.selectedIndex = 0,
    this.onTap,
    @required this.titles
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // tinggi tabbar
      child: Stack(
        children: [
          // Stack Child => Garis abu dibawah
          Container(
            margin: EdgeInsets.only(top: 48), // height 50 paddingTop 48 berarti Continer berada di bawah
            height: 1,
            color: "F2F2F2".toColor(),
          ),
          // Stack Child => Row Title
          Row(
            children: titles.map((title) => 
              Padding(
                padding: EdgeInsets.only(left: defaultMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Menaruh ke paling bawah stack
                  children: [
                    GestureDetector(
                      onTap: (){ //Jika diklik maka akan mengubah onTap(index) sesuai index si Title
                        if(onTap != null){
                          onTap(titles.indexOf(title));
                        }
                      },
                      child: Text(
                        title,
                        style: (titles.indexOf(title) == selectedIndex) // Jika index dari list Title yang terpilih (index = selectedIndex)
                          ? (
                              blackFontStyle3.copyWith(fontWeight: FontWeight.w500)
                            ) : (
                              greyFontStyle
                          )
                      ),
                    ),
                    // Garis Horizontal Sesuai OnTab(index)
                    Container(
                      width: 40,
                      height: 3,
                      margin: EdgeInsets.only(top: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.5),
                        color: (titles.indexOf(title) == selectedIndex) ? (
                          "020202".toColor()
                        ) : (
                          Colors.transparent
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}