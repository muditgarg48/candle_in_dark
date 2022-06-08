import "package:flutter/material.dart";

var customAppBar1 = AppBar(
  title: const Text("App Bar"),
  actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.search_off_outlined,
        color: Colors.blue,
      ),
    )
  ],
  bottom: const PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: SizedBox(),
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(1000),
      bottomLeft: Radius.circular(500),
    ),
  ),
);

//Sliver App Bar
class customAppBar2 extends StatelessWidget {
  final String pageTitle;
  const customAppBar2({Key? key, required this.pageTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: false,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          pageTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        background: Image.asset("assets/imgs/trinity.jpg", fit: BoxFit.cover),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: SizedBox(),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_off_outlined,
            color: Colors.black,
          ),
        )
      ],
      toolbarHeight: 50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(100),
        ),
      ),
    );
  }
}
