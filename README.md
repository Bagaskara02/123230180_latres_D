# Toko Online - Latihan Responsi Praktikum Mobile

Aplikasi toko online berbasis Flutter yang menampilkan produk dari API eksternal (dummyjson.com), dengan fitur login, keranjang belanja per-user, dan profil.

**NIM:** 123230180

---

## 📁 Struktur Folder Project

```
lib/
├── main.dart                          # Entry point aplikasi
│                                       # - Inisialisasi Hive & register adapter
│                                       # - Setup GetX controllers
│                                       # - Routing berdasarkan session login
│
├── models/                            # Data models
│   ├── product_model.dart             # Model Product dari API dummyjson.com
│   │                                   # Fields: id, title, description, category,
│   │                                   # price, rating, stock, brand, thumbnail, images
│   └── cart_item_model.dart           # Model CartItem untuk Hive local database
│                                       # + Manual TypeAdapter (CartItemAdapter)
│                                       # Fields: productId, title, price, thumbnail,
│                                       # quantity, username
│
├── services/                          # Layer service (API & local storage)
│   ├── api_service.dart               # HTTP service ke dummyjson.com
│   │                                   # - fetchProducts(): GET /products?limit=50
│   │                                   # - fetchProductDetail(id): GET /products/{id}
│   └── session_service.dart           # SharedPreferences service untuk session
│                                       # - saveSession(), getSession(), clearSession()
│                                       # - isLoggedIn()
│
├── controllers/                       # GetX Controllers (State Management)
│   ├── auth_controller.dart           # Controller autentikasi
│   │                                   # - Login dengan validasi NIM sebagai password
│   │                                   # - Cek session saat app dibuka
│   │                                   # - Logout & clear session
│   ├── product_controller.dart        # Controller produk
│   │                                   # - Fetch list produk dari API
│   │                                   # - Handle loading & error state
│   └── cart_controller.dart           # Controller keranjang belanja
│                                       # - Add/remove item ke Hive (per-username)
│                                       # - Load cart items sesuai user yang login
│                                       # - Hitung total harga
│
└── pages/                             # Halaman-halaman UI
    ├── login_page.dart                # Halaman Login
    │                                   # - Input username (bebas)
    │                                   # - Input password (wajib NIM: 123230180)
    │                                   # - Validasi & redirect ke MainPage
    ├── main_page.dart                 # Container utama dengan BottomNavigationBar
    │                                   # - 2 tab: Home & Profile
    │                                   # - IndexedStack untuk persistensi halaman
    ├── home_page.dart                 # Halaman Home
    │                                   # - AppBar: "Hi, {username}" + tombol Cart
    │                                   # - ListView produk dari API
    │                                   # - Tap item → Detail Produk
    ├── product_detail_page.dart       # Halaman Detail Produk
    │                                   # - Gambar, judul, brand, kategori, harga
    │                                   # - Rating & stok
    │                                   # - Deskripsi produk
    │                                   # - Qty selector (1 s/d stok)
    │                                   # - Tombol "Add to Cart" → simpan ke Hive
    ├── cart_page.dart                 # Halaman Keranjang Belanja
    │                                   # - List item cart sesuai username login
    │                                   # - Tiap item ada tombol hapus
    │                                   # - Total harga di bagian bawah
    └── profile_page.dart              # Halaman Profil
                                        # - Avatar & username
                                        # - Kesan & Pesan
                                        # - Tombol Logout (merah)
```

---

## 🛠️ Library yang Digunakan

| Library | Fungsi |
|---------|--------|
| `http` | HTTP request ke API dummyjson.com |
| `hive` & `hive_flutter` | Local database untuk menyimpan cart items |
| `shared_preferences` | Menyimpan session login (username) |
| `get` (GetX) | State management & navigasi |
| `path_provider` | Path untuk Hive storage |