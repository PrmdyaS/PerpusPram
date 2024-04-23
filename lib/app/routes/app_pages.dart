import 'package:get/get.dart';
import 'package:perpus_pram/app/modules/LaporanDenda/bindings/laporan_denda_binding.dart';
import 'package:perpus_pram/app/modules/LaporanDenda/views/laporan_denda_view.dart';

import '../modules/AllPage/bindings/all_page_binding.dart';
import '../modules/AllPage/views/all_page_view.dart';
import '../modules/DetailBook/bindings/detail_book_binding.dart';
import '../modules/DetailBook/views/detail_book_view.dart';
import '../modules/EditProfile/bindings/edit_profile_binding.dart';
import '../modules/EditProfile/views/edit_profile_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/LaporanPeminjaman/bindings/laporan_peminjaman_binding.dart';
import '../modules/LaporanPeminjaman/views/laporan_peminjaman_view.dart';
import '../modules/ListBook/bindings/list_book_binding.dart';
import '../modules/ListBook/views/list_book_view.dart';
import '../modules/ListUlasan/bindings/list_ulasan_binding.dart';
import '../modules/ListUlasan/views/list_ulasan_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/ManagementUser/bindings/management_user_binding.dart';
import '../modules/ManagementUser/views/management_user_view.dart';
import '../modules/MenuBuku/bindings/menu_buku_binding.dart';
import '../modules/MenuBuku/views/menu_buku_view.dart';
import '../modules/Peminjaman/bindings/peminjaman_binding.dart';
import '../modules/Peminjaman/views/peminjaman_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/ProfileEdit/bindings/profile_edit_binding.dart';
import '../modules/ProfileEdit/views/profile_edit_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/RegisterUsername/bindings/register_username_binding.dart';
import '../modules/RegisterUsername/views/register_username_view.dart';
import '../modules/Review/bindings/review_binding.dart';
import '../modules/Review/views/review_view.dart';
import '../modules/RiwayatPeminjaman/bindings/riwayat_peminjaman_binding.dart';
import '../modules/RiwayatPeminjaman/views/riwayat_peminjaman_view.dart';
import '../modules/Scan/bindings/scan_binding.dart';
import '../modules/Scan/views/scan_view.dart';
import '../modules/SearchPage/bindings/search_page_binding.dart';
import '../modules/SearchPage/views/search_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ALL_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.ALL_PAGE,
      page: () => const AllPageView(),
      binding: AllPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_USERNAME,
      page: () => RegisterUsernameView(),
      binding: RegisterUsernameBinding(),
    ),
    GetPage(
      name: _Paths.LIST_BOOK,
      page: () => ListBookView(),
      binding: ListBookBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BOOK,
      page: () => DetailBookView(),
      binding: DetailBookBinding(),
    ),
    GetPage(
      name: _Paths.PEMINJAMAN,
      page: () => const PeminjamanView(),
      binding: PeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PEMINJAMAN,
      page: () => const RiwayatPeminjamanView(),
      binding: RiwayatPeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => const SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => const ProfileEditView(),
      binding: ProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW,
      page: () => const ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.LIST_ULASAN,
      page: () => const ListUlasanView(),
      binding: ListUlasanBinding(),
    ),
    GetPage(
      name: _Paths.MENU_BUKU,
      page: () => const MenuBukuView(),
      binding: MenuBukuBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEMENT_USER,
      page: () => ManagementUserView(),
      binding: ManagementUserBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_PEMINJAMAN,
      page: () => const LaporanPeminjamanView(),
      binding: LaporanPeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_DENDA,
      page: () => const LaporanDendaView(),
      binding: LaporanDendaBinding(),
    ),
  ];
}
