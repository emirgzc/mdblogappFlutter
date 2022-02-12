// ignore_for_file: constant_identifier_names

enum TabItem { AnaSayfa, OneCikanlar, MyBlogPage, Profil }

class TabItemData {
  final String title;
  final String icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.AnaSayfa:
        TabItemData("Ana Sayfa", "assets/icons/home_inactive.svg"),
    TabItem.OneCikanlar:
        TabItemData("Öne Çıkanlar", "assets/icons/search_inactive.svg"),
    TabItem.MyBlogPage:
        TabItemData("Bloglarım", "assets/icons/heart_inactive.svg"),
    TabItem.Profil: TabItemData("Profil", "assets/icons/cart_inactive.svg"),
  };
}
