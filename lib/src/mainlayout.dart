import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final Widget? bottomNavigationBar;
  final Widget? body;
  final bool? showDefaultBottom;
  final VoidCallback? onFabTap;
  final String? fabTitle;
  final bool? showFloatingActionButton;
  final String? title;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  int ctx;
  MainLayout({
    super.key,
    this.onFabTap,
    this.bottomNavigationBar,
    this.showDefaultBottom = false,
    this.ctx = 0,
    this.fabTitle,
    this.body,
    this.showFloatingActionButton = false,
    this.title,
    this.appBar,
    this.backgroundColor,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingFactor = screenWidth < 600 ? 0.05 : 0.03;

    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: true,

      appBar: widget.appBar,

      body: widget.body,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.showFloatingActionButton == true
          ? Container(
              // width: 150,
              // height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                
                onPressed: widget.onFabTap,
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  widget.fabTitle ?? 'Add',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar: (widget.showDefaultBottom != true)
          ? null
          : ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,

                selectedFontSize: screenWidth * 0.03,
                unselectedFontSize: screenWidth * 0.03,

                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,

                selectedLabelStyle: TextStyle(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w400,
                ),

                currentIndex: widget.ctx,
                onTap: (int value) async {
                  switch (value) {
                    case 0:
                      if (widget.ctx != 0) {
                        Navigator.pushNamed(context, '/home');
                      }
                      break;
                    case 1:
                      if (widget.ctx != 1) {
                        Navigator.pushNamed(context, '/analytics');
                      }
                      break;
                    case 2:
                      if (widget.ctx != 2) {
                        Navigator.pushNamed(context, '/transactions');
                      }
                      break;

                    case 3:
                      if (widget.ctx != 3) {
                        Navigator.pushNamed(context, '/profile');
                      }
                      break;
                  }
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/home.png',
                      height: 24,
                      width: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/home.png',
                      height: 24,
                      width: 24,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/trend.png',
                      height: 24,
                      width: 24,
                    ),

                    activeIcon: Image.asset(
                      'assets/icons/trend.png',
                      height: 24,
                      width: 24,
                    ),
                    label: 'Trend',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/transaction.png',
                      height: 24,
                      width: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/transaction.png',
                      height: 24,
                      width: 24,
                    ),
                    label: 'Transactions',
                  ),

                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/user.png',
                      height: 24,
                      width: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/user.png',
                      height: 24,
                      width: 24,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
    );
  }
}
