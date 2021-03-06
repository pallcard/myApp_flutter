import 'package:flutter/material.dart';
import 'package:myapp/constants.dart' show AppColors;
import 'package:myapp/constants.dart' show Constants;
import './conversationPage.dart';


enum ActionItems {
  GROUP_CHAT, ADD_FRIEND,QR_SCAN,PAYMENT,HELP,
}

class NavigationIconView {
  final String _title;
//  final IconData _icon;
//  final IconData _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, IconData icon, IconData activeIcon}) :
    _title = title,
//    _icon = icon,
//    _activeIcon = activeIcon,
    item = new BottomNavigationBarItem(
//      icon: Icon(icon, color: Color(AppColors.TabIconNormal),),
//      activeIcon: Icon(activeIcon, color: Color(AppColors.TabIconActive),),
      icon: Icon(icon,),
      activeIcon: Icon(activeIcon),
      title: Text(title,style: TextStyle(
        fontSize: 14.0,
//        color: Color(AppColors.TabIconNormal),
      ),),
      backgroundColor: Colors.white,
    );

}

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;

  int _currentIndex = 0;

  List<NavigationIconView> _navigationViews;

  List<Widget> _pages;

  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: '微信',
//        icon: Icon(Icons.ac_unit),
        icon: IconData(
            0xe600,
            fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
            0xe61b,
            fontFamily: Constants.IconFontFamily,
        )
      ),
      NavigationIconView(
          title: '通讯录',
          icon: IconData(
            0xe655,
            fontFamily: Constants.IconFontFamily,
          ),
          activeIcon: IconData(
            0xe6c2,
            fontFamily: Constants.IconFontFamily,
          )
      ),
      NavigationIconView(
          title: '发现',
          icon: IconData(
            0xe629,
            fontFamily: Constants.IconFontFamily,
          ),
          activeIcon: IconData(
            0xe62a,
            fontFamily: Constants.IconFontFamily,
          )
      ),
      NavigationIconView(
          title: '我',
          icon: IconData(
            0xe63b,
            fontFamily: Constants.IconFontFamily,
          ),
          activeIcon: IconData(
            0xe693,
            fontFamily: Constants.IconFontFamily,
          )
      ),
    ];

    _pageController = PageController(initialPage: _currentIndex);

    _pages = [
//      Container(color: Colors.red,),
      ConversationPage(),
      Container(color: Colors.blue,),
      Container(color: Colors.white,),
      Container(color: Colors.green,),
    ];
  }

  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(IconData(
              iconName,
              fontFamily: Constants.IconFontFamily,
            ),
          size: 22.0,
          color: const Color(AppColors.AppBarPopupMenuColor),//const 编译时就确定内容加const可以提高编译效率
        ),
        Container(width: 16.0,),
        Text(title,style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        //通过setState方法，当_currentIndex的值发生改变时重绘界面
        setState(() {
          _currentIndex = index;

          _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
//        print('第$index个按钮');
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        elevation: 0.0, //去阴影
//        backgroundColor: Color(0xff303030),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print('点击搜索');
            },
          ),
          Container(width: 16.0,),
          PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<ActionItems>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61b,"发起群聊"),
                    value: ActionItems.GROUP_CHAT,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61b,"添加朋友"),
                    value: ActionItems.ADD_FRIEND,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61b,"扫一扫"),
                    value: ActionItems.QR_SCAN,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61b,"收付款"),
                    value: ActionItems.PAYMENT,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61b,"帮助与反馈"),
                    value: ActionItems.HELP,
                  ),

                ];
              },
              icon: Icon(Icons.add),
              onSelected: (ActionItems selected) {
                print('点击的是$selected');
              },
           ),
//          IconButton(
//            icon: Icon(Icons.add),
//            onPressed: (){
//              print('下拉');
//            },
//          ),
          Container(width: 16.0,),
        ],
      ),
      body: PageView.builder(
          itemBuilder: (BuildContext buildContext, int index){
            return _pages[index];
          },
          controller: _pageController,
          itemCount: _pages.length,
        onPageChanged: (int index){
            setState(() {
              _currentIndex = index;
            });
            print('当前显示的是第${index}');
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
