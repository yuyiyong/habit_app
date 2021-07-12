/*
 * @LastEditors:  
 * @LastEditTime: 2021-07-09 10:01:29
 * @FilePath: /habit_app/lib/views/notes_screen.dart
 */
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habit_app/component/full_screenimagepage.dart';
import 'package:habit_app/test_const/consts.dart';


class NotesScreen extends StatefulWidget {
  NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
 List<Habit> habits = List.generate(Consts.habitList.length, (index) => Consts.habitList[index],growable:true) ;
  // List<String> _list = List.generate(10, (i) => '原始数据${i + 1}');

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController? _scrollController;
  ScrollController? _scrollController2;
  bool isLoading = false; // 是否正在加载，防止多次请求加载下一页

  // 加载更多布局
  Widget _buildLoadMoreItem() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("加载中..."),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title:Text('瀑布流')),
      body: RefreshIndicator(
                key: _refreshIndicatorKey,
                child:CustomScrollView(
                  controller: _scrollController2,
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.pink,
                        pinned: true,
                        snap: true,
                        floating: true,
                        leading: Icon(Icons.home),
                        actions: <Widget>[Icon(Icons.menu),Icon(Icons.add)],
                        title: Text("量化"),
                        expandedHeight: 250,
                        flexibleSpace: FlexibleSpaceBar(
                          /* title:Row(children: [
                            IconButton(icon: Icon(Icons.add), onPressed: (){}),
                            IconButton(icon: Icon(Icons.home), onPressed: (){}),
                          ],), */
                          background: Stack(
                            children: <Widget>[
                              Container(
                                color: Colors.yellow,
                                width: MediaQuery.of(context).size.width,
                                child: Expanded(
                                  /* child:Image.asset(
                                    'asset/image/hgYwoT.jpeg',
                                    // 'https://www.ffblog.cn/wp-content/uploads/2021/01/20210109_5ff8ddebdde04.jpg',
                                    fit: BoxFit.cover,
                                    // alignment: Alignment.topCenter,
                                  ), */
                                  child:Image.network(
                                    // 'asset/image/hgYwoT.jpeg',
                                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fqqpublic.qpic.cn%2Fqq_public%2F0%2F0-2190251037-BDA2B1F08C866E35B5337AED7886F441%2F0%3Ffmt%3Djpg%26size%3D59%26h%3D468%26w%3D700%26ppv%3D1.jpg&refer=http%3A%2F%2Fqqpublic.qpic.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1628244203&t=eb66d885c70851d34163dd3c71330050',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                              ),
                              ),
                               Padding(padding: EdgeInsets.only(top: 70),child: Container(
                                width: MediaQuery.of(context).size.width,
                               
                                child: GridView(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, //数量
                                    // mainAxisSpacing: 1.0,
                                    // crossAxisSpacing: 2.0, //列间距
                                    childAspectRatio: 1.5, //横竖比
                                  ),
                                  children: [
                                    IconButton(icon: Icon(Icons.add), onPressed: (){},color: Colors.white,),
                                    IconButton(icon: Icon(Icons.home), onPressed: (){},color: Colors.white),
                                    IconButton(icon: Icon(Icons.calendar_view_day), onPressed: (){},color: Colors.white),
                                    IconButton(icon: Icon(Icons.desktop_mac), onPressed: (){},color: Colors.white),
                                    IconButton(icon: Icon(Icons.mail), onPressed: (){},color: Colors.white),
                                    IconButton(icon: Icon(Icons.radio), onPressed: (){},color: Colors.white),
                                  ],
                                )
                              )
                              ,)

                             
                            ],
                          ),
                        ),),
                       SliverToBoxAdapter(
                        child: StaggeredGridView.countBuilder(
                                  controller: _scrollController,
                            
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(10.0),
                                  crossAxisCount: 4,
                                  itemCount: habits.length,
                                  itemBuilder: (context, i) {
                                    return itemWidget(i);
                                  },
                                //  staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                                  staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(2),    //
                                  // new StaggeredTile.count(2, habits[index].size),    //
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ), 
                        
                      
              
                      )
                    
                    ],
        ),
      
              onRefresh: _handleRefresh,
      ),
      
      
        
      
      
      
      
      
    
    );
  }

  @override
  void initState() {
    super.initState();
    // 显示加载进度圈
    _showRefreshLoading();

    // 初始化ScrollController
    _scrollController2 = ScrollController();
    _scrollController = ScrollController();
    // 监听ListView是否滚动到底部
    _scrollController!.addListener(() {
      
      if (_scrollController!.position.pixels >=
          _scrollController!.position.maxScrollExtent) {
        // 滑动到了底部
        print('滑动到了底部');
        // 这里可以执行上拉加载逻辑
        // _loadMore();
      }
    });
    _scrollController2!.addListener(() {
      
      if (_scrollController2!.position.pixels >=
          _scrollController2!.position.maxScrollExtent) {
        // 滑动到了底部
        print('滑动到了底部2');
        // 这里可以执行上拉加载逻辑
        _loadMore();
      }
    });
    
  }
  @override
  void dispose() {
    super.dispose();
    // 这里不要忘了将监听移除
    _scrollController!.dispose();
    _scrollController2!.dispose();
  }

  // 显示加载进度圈
  _showRefreshLoading() {
    // 这里使用延时操作是由于在执行刷新操作时_refreshIndicatorKey还未与RefreshIndicator关联
    Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState!.show();
    });
  }

  // 下拉刷新方法
  Future<Null> _handleRefresh() async {
    print("刷新 ---------------");
      print(Consts.habitList.length);

    // 模拟数据的延迟加载
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        
        // 在列表开头添加几条数据
        List<Habit> _refreshData = List.generate(Consts.habitList.length,(index)=>Consts.habitList[index],growable:true);
        // _list.insertAll(0, _refreshData);
        // _list = _refreshData;
        
        habits = _refreshData;
      });
    });
  }

  // 上拉加载
  Future<Null> _loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      // 模拟数据的延迟加载
      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
          List<Habit> _loadMoreData =
              List.generate(5, (i) => new Habit(Colors.yellow, '下拉刷新数据${i + 1}', "http://nimg.ws.126.net/?url=http%3A%2F%2Fdingyue.ws.126.net%2F2021%2F0609%2Fa4d4e136j00que6ox001bc000hs00loc.jpg&thumbnail=650x2147483647&quality=80&type=jpg", 4));
          habits.addAll(_loadMoreData);
        });
      });
    }
  }
  Widget  itemWidget(int index){
     Habit habit = habits[index];
     
    //  String imageurl="http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg";
     Color imgcolor=Colors.blue;
     return new Material(
       elevation: 8.0,
       borderRadius: new BorderRadius.all(
         new Radius.circular(8.0),
       ),
       child: new InkWell(
         onTap: () {
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (context) {
                 return new FullScreenImagePage(imageurl: habit.img);
               },
             ),
           );
         },
         child:  Container(
           decoration: BoxDecoration(
             color: Colors.white,
            //  border: Border.all(width: 1,color: imgcolor),
             border: Border.all(width: 1,color: habit.color),
             borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
             boxShadow: [
              BoxShadow(
                // color: imgcolor,
                color: habit.color,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              ),
              // BoxShadow(color: Color(0x990090FF), offset: Offset(1.0, 1.0)),
              // BoxShadow(color: Color(0xFF0099FF))
            ] 
           ),
           child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.network(habit.img, fit: BoxFit.fitWidth,),
            //  Image.network(habit.img, fit: BoxFit.fitWidth,),
             Text(habit.content!)
            //  Text(habit.content!)
           ],
         ),
       ),
         )
     );
   }
  

  
  /* 
  List<Habit> habits = Consts.habitList;
  
  List imgList = [
    "http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg",
    "http://yanxuan.nosdn.127.net/8b30eeb17c831eba08b97bdcb4c46a8e.png",
    "http://yanxuan.nosdn.127.net/a196b367f23ccfd8205b6da647c62b84.png",
    "http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png",
    "http://yanxuan.nosdn.127.net/88dc5d80c6f84102f003ecd69c86e1cf.png",
    "http://yanxuan.nosdn.127.net/8b9328496990357033d4259fda250679.png",
    "http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png",
    "http://yanxuan.nosdn.127.net/ee92704f3b8323905b51fc647823e6e5.png",
    "http://yanxuan.nosdn.127.net/e564410546a11ddceb5a82bfce8da43d.png",
    "http://yanxuan.nosdn.127.net/56f4b4753392d27c0c2ccceeb579ed6f.png",
    "http://yanxuan.nosdn.127.net/6a54ccc389afb2459b163245bbb2c978.png",
    'https://picsum.photos/id/101/548/338',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569842561051&di=45c181341a1420ca1a9543ca67b89086&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201504%2F17%2F20150417212547_VMvrj.jpeg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1570437233&di=9239dbc3237f1d21955b50e34d76c9d5&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201508%2F30%2F20150830095308_UAQEi.thumb.700_0.jpeg'
  ];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
   ScrollController? _scrollController;
   bool isLoading = false; // 是否正在加载，防止多次请求加载下一页
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('瀑布流')),
      body: CustomScrollView(
        // controller:  _scrollController,
        slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Demo'),
          ),
        ),
    SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 9)],
            child: Text('Grid Item ${habits[index].content}'),
          );
        },
        childCount: habits.length,
      ),
    ),

    SliverToBoxAdapter(
      child:  RefreshIndicator(
          key: _refreshIndicatorKey,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index < habits.length) {
                return ListTile(
                  title: Text('1111'),
                );
              } else {
                // 最后一项，显示加载更多布局
                return _buildLoadMoreItem();
              }
            },
            itemCount: habits.length + 1,
            controller: _scrollController,
          ),
          onRefresh: _handleRefresh,
        ),
    ),
    SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('List Item $index'),
          );
        },
      ),
    ),
  ],
)
      // body: StaggeredGridView.countBuilder(
      //   shrinkWrap: true,
      //   //controller: _scrollController,
      //   padding: const EdgeInsets.all(10.0),
      //   crossAxisCount: 4,
      //   itemCount: habits.length,
      //   itemBuilder: (context, i) {
      //     return itemWidget(i);
      //   },
      // //  staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
      //   staggeredTileBuilder: (int index) =>
      //   new StaggeredTile.fit(2),    //
      //   // new StaggeredTile.count(2, habits[index].size),    //
      //   mainAxisSpacing: 8.0,
      //   crossAxisSpacing: 8.0,
      // ),
    );
  }
  // 下拉刷新方法
  Future<Null> _handleRefresh() async {
    // 模拟数据的延迟加载
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // 在列表开头添加几条数据
        List<Habit> _refreshData = List.generate(25, (i) => new Habit(Colors.red, '下拉刷新数据${i + 1}', "http://nimg.ws.126.net/?url=http%3A%2F%2Fdingyue.ws.126.net%2F2021%2F0609%2Fa4d4e136j00que6ox001bc000hs00loc.jpg&thumbnail=650x2147483647&quality=80&type=jpg", 4));
        // _list.insertAll(0, _refreshData);
        habits = _refreshData;
      });
    });
  }
  
  Widget  itemWidget(int index){
     Habit habit = habits[index];
     
     print("------");
     print(habit.img);
     String imageurl="http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg";
     return new Material(
       elevation: 8.0,
       borderRadius: new BorderRadius.all(
         new Radius.circular(8.0),
       ),
       child: new InkWell(
         onTap: () {
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (context) {
                 return new FullScreenImagePage(imageurl: habit.img);
               },
             ),
           );
         },
         child:  Container(
           decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(width: 1,color: habit.color),
             borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
             boxShadow: [
              BoxShadow(
                color: habit.color,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              ),
              // BoxShadow(color: Color(0x990090FF), offset: Offset(1.0, 1.0)),
              // BoxShadow(color: Color(0xFF0099FF))
            ] 
           ),
           child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.network(habit.img, fit: BoxFit.fitWidth,),
             Text(habit.content!)
           ],
         ),
       ),
         )
     );
   }


  // 加载更多布局
  Widget _buildLoadMoreItem() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("加载中..."),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 显示加载进度圈
    _showRefreshLoading();
    //初始化
    _scrollController = ScrollController();
    // 监听ListView是否滚动到底部
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels >=
          _scrollController!.position.maxScrollExtent) {
        // 滑动到了底部
        print('滑动到了底部');
        // 这里可以执行上拉加载逻辑
        _loadMore();
      }
    });
  }
  
  @override
  void dispose(){
    super.dispose();
    _scrollController!.dispose();
  }

    _showRefreshLoading() {
    // 这里使用延时操作是由于在执行刷新操作时_refreshIndicatorKey还未与RefreshIndicator关联
    Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState!.show();
    });
  }
    // 上拉加载
  Future<Null> _loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      // 模拟数据的延迟加载
      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
          List<Habit> _loadMoreData =
              List.generate(5, (i) => new Habit(Colors.yellow, 'content 上拉加载数据${i + 1}', "http://nimg.ws.126.net/?url=http%3A%2F%2Fdingyue.ws.126.net%2F2021%2F0609%2Fa4d4e136j00que6ox001bc000hs00loc.jpg&thumbnail=650x2147483647&quality=80&type=jpg", 5));
          habits.addAll(_loadMoreData);
        });
      });
    }
  }
 */
}