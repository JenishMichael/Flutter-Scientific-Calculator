import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  //Creating a variable of type TabController
  final TabController tabController;
  //Creating the constructor, it takes _tabController from main.dart
  const CustomAppBar({required this.tabController, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.unfold_less,
          color: Colors.white,
        ),
      ),

      //TabBar contains 2 Tab (Calculator,Converter)
      title: TabBar(
        dividerColor: Colors.black,
        indicatorColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        //in controller added  tabController
        controller: tabController,
        tabs: const [
          Tab(
            child: Text(
              "Calculator",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Converter",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  //As appBar accepts PreferredSizeWidget, so we hv to implement PreferredSizeWidget
  //And assign Default Size
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
