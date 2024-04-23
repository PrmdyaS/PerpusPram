import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/modules/Home/views/home_view.dart';
import 'package:perpus_pram/app/modules/Peminjaman/views/peminjaman_view.dart';
import 'package:perpus_pram/app/modules/Profile/views/profile_view.dart';
import 'package:perpus_pram/app/modules/RiwayatPeminjaman/views/riwayat_peminjaman_view.dart';
import '../controllers/all_page_controller.dart';

class AllPageView extends GetView<AllPageController> {
  const AllPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.put(AllPageController());

    List<Widget> pageViewModel() {
      if (allPageController.role.value == "1") {
        return [
          HomeView(),
          const PeminjamanView(),
          const RiwayatPeminjamanView(),
          ProfileView(),
        ];
      } else if (allPageController.role.value == "2") {
        return [
          HomeView(),
          const PeminjamanView(),
          const RiwayatPeminjamanView(),
          ProfileView(),
        ];
      } else if (allPageController.role.value == "3") {
        return [
          HomeView(),
          const PeminjamanView(),
          const RiwayatPeminjamanView(),
          ProfileView(),
        ];
      } else {
        return [
          HomeView(),
          ProfileView(),
        ];
      }
    }

    List<Widget> guestDestinations() {
      return <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Primary),
          icon: const Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2, color: Primary),
          icon: const Icon(Icons.person_2_outlined),
          label: 'Profil',
        ),
      ];
    }

    List<Widget> userDestinations() {
      return <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Primary),
          icon: const Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.article, color: Primary),
          icon: const Icon(Icons.article_outlined),
          label: 'Peminjaman',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.calendar_today, color: Primary),
          icon: const Icon(Icons.calendar_today_outlined),
          label: 'Riwayat',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2, color: Primary),
          icon: const Icon(Icons.person_2_outlined),
          label: 'Profil',
        ),
      ];
    }

    List<Widget> officerDestinations() {
      return <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Primary),
          icon: const Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.article, color: Primary),
          icon: const Icon(Icons.article_outlined),
          label: 'Peminjaman',
        ),
        Container(
            decoration: BoxDecoration(
              color: Primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: ElevatedButton(
                onPressed: () {
                  allPageController.scanQR();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.qr_code_2,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      "SCAN",
                      style: GoogleFonts.getFont(
                        'Bebas Neue',
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ))),
        NavigationDestination(
          selectedIcon: Icon(Icons.calendar_today, color: Primary),
          icon: const Icon(Icons.calendar_today_outlined),
          label: 'Riwayat',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2, color: Primary),
          icon: const Icon(Icons.person_2_outlined),
          label: 'Profil',
        ),
      ];
    }

    List<Widget> adminDestinations() {
      return <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Primary),
          icon: const Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.article, color: Primary),
          icon: const Icon(Icons.article_outlined),
          label: 'Peminjaman',
        ),
        Container(
            decoration: BoxDecoration(
              color: Primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: ElevatedButton(
                onPressed: () {
                  allPageController.scanQR();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.qr_code_2,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      "SCAN",
                      style: GoogleFonts.getFont(
                        'Bebas Neue',
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ))),
        NavigationDestination(
          selectedIcon: Icon(Icons.calendar_today, color: Primary),
          icon: const Icon(Icons.calendar_today_outlined),
          label: 'Riwayat',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2, color: Primary),
          icon: const Icon(Icons.person_2_outlined),
          label: 'Profil',
        ),
      ];
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() => PageView(
            physics: const BouncingScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: (index) {
              if (allPageController.role.value == "2") {
                if (index > 1) {
                  index = index + 1;
                }
              } else if (allPageController.role.value == "3") {
                if (index > 1) {
                  index = index + 1;
                }
              }
              allPageController.currentNavIndex.value = index;
            },
            children: pageViewModel(),
          )),
      bottomNavigationBar: Obx(() {
        List<Widget> destinations = [];
        if (allPageController.role.value == "1") {
          destinations = userDestinations();
        } else if (allPageController.role.value == "2") {
          destinations = officerDestinations();
        } else if (allPageController.role.value == "3") {
          destinations = adminDestinations();
        } else {
          destinations = guestDestinations();
        }
        return NavigationBar(
          elevation: 0,
          onDestinationSelected: (int index) {
            allPageController.currentNavIndex.value = index;
            if (allPageController.role.value == "2") {
              if (index > 2) {
                index = index - 1;
              }
            } else if (allPageController.role.value == "3") {
              if (index > 2) {
                index = index - 1;
              }
            }
            allPageController.currentPageIndex.value = index;
            controller.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          indicatorColor: Colors.transparent,
          selectedIndex: allPageController.currentNavIndex.value,
          destinations: destinations,
        );
      }),
    );
  }
}
