class NewsData {
  String? title;
  String? author;
  String? content;
  String? urlToImage;
  String? date;

  NewsData(
    this.title,
    this.author,
    this.content,
    this.date,
    this.urlToImage,
  );

  static List<NewsData> hotNewsData = [
    NewsData(
        "Tindak Korupsi Terbongkar, Otoritas Gencarkan Penyelidikan dan Langkah Hukum",
        "Charli Palangan",
        "Dalam pengembangan terbaru, kasus korupsi yang melibatkan sejumlah pejabat pemerintah dan tokoh bisnis ternama terungkap ke publik. Otoritas penegak hukum telah gencar melakukan penyelidikan menyeluruh dan mengambil langkah-langkah tegas untuk menangani skandal ini.",
        "2023-11-30",
        "https://i0.wp.com/www.kobarksb.com/wp-content/uploads/2021/10/KPK-Tetapkan-10-Orang-Anggota-DPRD-Sebagai-Tersangka-Korupsi-Pengadaan-BarangJasa-dan-Pengesahan-APBD-Gelar-Perkara-Kasus-Korupsi-KPK-2.jpg?fit=664%2C478&ssl=1"),
    NewsData(
        "Kisah Pasangan Muda yang Sulit Move On, Perjuangan Mencari Kembali Kebahagiaan",
        "Fernando Putra",
        "Dalam sebuah kisah yang mengharukan, pasangan muda yang pernah menjalani kisah cinta indah harus menghadapi kesulitan untuk move on setelah putus cinta. Keduanya, yang sebelumnya dikenal sebagai pasangan yang serasi, kini berjuang untuk menemukan kedamaian dan kebahagiaan masing-masing setelah berpisah.",
        "2022-08-11",
        "https://i.pinimg.com/originals/4a/df/02/4adf02d2fc52ebad4783d90a81504ca1.jpg"),
    NewsData(
        "Reuni Kembali PDI 10 dekadu",
        "Owi",
        "Dalam suasana keceriaan dan kehangatan, anggota PDI 10 DKD (Dusun, Kelurahan, Desa) merayakan reuni yang penuh kenangan di tempat yang sarat makna. Acara yang dihadiri oleh puluhan alumni dan anggota PDI 10 DKD ini menjadi momen berharga untuk memperkuat tali persaudaraan dan merayakan prestasi bersama. \n Acara ini diadakan di area terbuka yang dipenuhi dengan dekorasi meriah dan nuansa khas keakraban PDI 10 DKD. Tawa, sapaan, dan pelukan hangat memenuhi udara, menciptakan atmosfer yang penuh keceriaan.",
        "2022-08-11",
        "https://berita.99.co/wp-content/uploads/2023/08/logo-banteng-pdip.jpg"),
  ];

  static List<NewsData> recommendedNewsData = [
    NewsData(
        "Keindahan Candi Borobudur, Pesona Sejarah Indonesia yang Abadi",
        "Zuxxy",
        "Candi Borobudur, salah satu keajaiban dunia di Jawa Tengah, Indonesia, terus mempesona pengunjung dengan keindahan arsitekturnya yang megah dan makna sejarah yang mendalam. Pada pagi hari ini, ribuan wisatawan lokal maupun mancanegara berkumpul untuk menyaksikan matahari terbit yang memukau di sekitar Candi Borobudur. \n Pagi ini, suasana sejuk dan hening di sekitar Candi Borobudur semakin menambah keistimewaan momen ini. Wisatawan yang berkumpul dengan penuh semangat membawa kamera dan smartphone mereka untuk menangkap keindahan matahari terbit yang melukis langit dengan warna-warna hangat.",
        "2023-11-11",
        "https://www.anadventurousworld.com/wp-content/uploads/2016/11/temples-in-indonesia-768x512.jpg.webp"),
    NewsData(
        "Mekar dari Kelompok PBP News, Pesona Wajah Mirip dengan Luxxy, Pro Player PUBG Terkenal",
        "Kelompok 4",
        "Dalam sebuah perbandingan yang mencolok, Mekar, salah satu anggota terkemuka dari kelompok PBP News, menjadi sorotan karena kemiripan pesonanya dengan Luxxy, pro player PUBG yang terkenal. Meskipun Mekar bukanlah seorang pemain profesional PUBG, banyak yang memperhatikan kemiripan wajah mereka yang menambah daya tarik tersendiri pada kelompok berita ini. \n Mekar, dengan paras wajah yang mencuri perhatian, telah menjadi ikon visual di antara penggemar PBP News. Banyak yang menyoroti kesamaan wajahnya dengan Luxxy, menciptakan kisah menarik di balik layar kelompok berita yang semakin menonjol.",
        "2023-12-9",
        "https://i.pinimg.com/originals/4a/ef/cb/4aefcbb57e83fe09b80f5477aa7a8f6e.jpg"),
    NewsData(
        "News PBP kelompok 4, Telah menamatkan PBP",
        "Kelompok 4",
        "Dalam sebuah pencapaian luar biasa, kelompok News 4 telah sukses menyelesaikan proyek pemrograman berbasis platform mereka. Proyek ini merupakan bagian dari upaya kelompok tersebut untuk terus berkembang dan menyajikan informasi terkini dengan pendekatan teknologi terbaru Kelompok News 4, yang terdiri dari sejumlah profesional berbakat di bidang jurnalistik dan teknologi informasi, bekerja sama selama berbulan-bulan untuk menghasilkan platform pemrograman yang inovatif. Proyek ini bertujuan untuk meningkatkan pengalaman pengguna dalam mengakses berita secara online, sekaligus memperluas jangkauan audiens mereka.",
        "2023-12-9",
        "https://i.pinimg.com/originals/08/08/c7/0808c70a23b9b64eb2603110dda1aa8a.jpg"),
    NewsData(
        "Reuni Cinta di Cafe Lestari, Mahasiswa Temui Pujaan Hati Lama",
        "Yohanes Beryand Fernando Putra Palangan",
        "Dalam suatu kejadian yang penuh romantika, seorang mahasiswa, Andi Pratama, tanpa sengaja bertemu dengan pujaan hati lamanya, Nisa Azhari, di Cafe Lestari, tempat yang menjadi saksi banyak kenangan indah mereka dahulu.",
        "2023-12-9",
        "https://i.pinimg.com/originals/af/8a/a0/af8aa06eae97f9f7f1720ac968002d1d.jpg"),
  ];

  get id => null;
}
