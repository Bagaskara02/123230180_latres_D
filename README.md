# Toko Online - Latihan Responsi Praktikum Mobile

Aplikasi toko online berbasis Flutter yang menampilkan produk dari API eksternal (dummyjson.com), dengan fitur login, keranjang belanja per-user, dan profil.

**NIM:** 123230180

---

## 📁 Struktur Folder Project

```
lib/
├── main.dart                          
├── models/                            
│   ├── product_model.dart             
│   └── cart_item_model.dart           
├── services/                          
│   ├── api_service.dart              
│   └── session_service.dart           
├── controllers/                       
│   ├── auth_controller.dart           
│   ├── product_controller.dart       
│   └── cart_controller.dart           
└── pages/                             
    ├── login_page.dart                
    ├── main_page.dart                 
    ├── home_page.dart                 
    ├── product_detail_page.dart       
    ├── cart_page.dart                 
    └── profile_page.dart
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
