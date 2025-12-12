# **Game Catalog – Flutter App**

Aplikasi **Game Catalog** adalah aplikasi mobile berbasis Flutter yang menampilkan daftar game gratis dari API FreeToGame dan menyediakan fitur CRUD untuk data game lokal. Aplikasi ini dirancang sebagai latihan implementasi **API, Provider, State Management, CRUD, Routing, dan Error Handling** dalam Flutter.

---

## 📱 **Fitur Utama**

### ✔️ **1. Fetch Data dari API**

Aplikasi mengambil daftar game dari API FreeToGame:

* Semua game
* Game per kategori (RPG, Shooter, dll)
* Detail game berdasarkan ID

### ✔️ **2. CRUD Data Lokal**

Pengguna dapat melakukan:

* **Tambah** game buatan sendiri
* **Edit** game lokal
* **Hapus** game lokal

Data lokal tidak tersimpan ke API, tetapi tersimpan di memori aplikasi (runtime).

### ✔️ **3. Pencarian (Search)**

Mendukung pencarian game berdasarkan judul pada:

* Data API
* Data lokal

### ✔️ **4. Halaman Detail Game**

Menampilkan:

* thumbnail
* deskripsi
* genre
* platform
* link game

Untuk game lokal, halaman detail menampilkan tombol:

* **Edit**
* **Delete**

### ✔️ **5. Error Handling**

Aplikasi menangani beberapa kondisi error:

* API gagal (no internet / server down)
* Gambar gagal dimuat (invalid URL)
* Input form kosong atau tidak valid

### ✔️ **6. UI Responsive & Navigasi**

Menggunakan Flutter Material:

* HomeScreen
* GameListScreen
* DetailScreen
* GameFormScreen

---

## 🏗️ **Arsitektur Aplikasi**

Struktur folder aplikasi:

```
lib/
│
├── models/
│     └── game.dart
│
├── providers/
│     └── game_provider.dart
│
├── screens/
│     ├── home_screen.dart
│     ├── game_list_screen.dart
│     ├── detail_screen.dart
│     └── game_form_screen.dart
│
├── widgets/
│     └── game_card.dart
│
└── main.dart
```

Arsitektur ini memisahkan:

* **Model** → Struktur data
* **Provider** → Manajemen state & logic CRUD/API
* **Screen** → Tampilan halaman
* **Widget** → Komponen UI terpisah

---

## 🌐 **API yang Digunakan**

Aplikasi menggunakan API dari **FreeToGame**:

| Kebutuhan                        | Endpoint                                                   |
| -------------------------------- | ---------------------------------------------------------- |
| Daftar semua game                | `https://www.freetogame.com/api/games`                     |
| Daftar game berdasarkan kategori | `https://www.freetogame.com/api/games?category={category}` |
| Detail game tertentu             | `https://www.freetogame.com/api/game?id={id}`              |

---

## 🧪 **Hasil Pengujian**

### ✅ **1. Fetch API Berhasil**

Data game dari API tampil dengan baik pada halaman Home dan List.

### ✅ **2. Tambah, Edit, Hapus Game Lokal**

CRUD berfungsi penuh:

* Tambah data → muncul di daftar game
* Edit data → perubahan langsung terlihat
* Hapus data → item hilang dari list

### ❗ **3. Error Handling Gambar**

Jika URL thumbnail salah, aplikasi menampilkan ikon error.

### ❗ **4. Form Validation**

Jika input kosong → muncul pesan peringatan.

### ❗ **5. Error Fetch API**

Jika koneksi gagal → pesan gagal memuat ditampilkan.

---

## 🛠️ **Teknologi yang Digunakan**

* Flutter
* Dart
* Provider (state management)
* HTTP package
* Navigator Routing
* Material UI

---

## 🚀 **Cara Menjalankan Proyek**

### 1. Clone Repositori

```bash
git clone https://github.com/Annisa165/uas-final.git
cd game_catalog
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Jalankan Aplikasi

```bash
flutter run
```

---

## 📸 **Screenshot Aplikasi**
<img width="240" height="480" alt="image" src="https://github.com/user-attachments/assets/1213b88b-d3c0-46c0-83d4-8d0fd4d7671f" />


## 📄 **Lisensi**

Proyek ini bebas digunakan untuk keperluan belajar dan pengembangan pribadi.

---

## 🙌 **Kontribusi**

Pull request, laporan bug, atau saran fitur sangat diterima.

