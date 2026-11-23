# PRJ_Network_Programming

Project môn Thực hành Lập trình mạng (IT4062): ứng dụng đặt vé máy bay bằng C.

## Môi trường phát triển

Mã socket trong bài giảng dùng POSIX trên Ubuntu. Trên Windows, mở project trong Ubuntu qua WSL2:

```powershell
wsl -d Ubuntu
```

```sh
cd /mnt/d/PRJ_Network_Programming
bash scripts/check-env.sh
```

Các công cụ cần dùng: `gcc`, `make`, `gdb`, `pkg-config`, OpenSSL headers và SQLite headers. Công cụ dòng lệnh `sqlite3` hữu ích để xem dữ liệu nhưng không bắt buộc để biên dịch. Nếu thiếu gói trong Ubuntu:

```sh
sudo apt update
sudo apt install build-essential gdb pkgconf libssl-dev libsqlite3-dev
sudo apt install sqlite3  # tùy chọn
```

Script kiểm tra sẽ trả mã lỗi khác 0 khi môi trường còn thiếu thành phần. Chưa có lệnh build project vì mã nguồn chưa được tạo.

## Trạng thái kiểm tra ngày 23/11/2026

- Ubuntu 26.04.1 trên WSL2; project được gắn tại `/mnt/d/PRJ_Network_Programming`.
- Đã có GCC, GNU Make và GDB.
- Đã cài `pkgconf`, `libssl-dev` và `libsqlite3-dev`.
- Công cụ dòng lệnh `sqlite3` chưa cài được do tải gói lỗi; phần build không bị ảnh hưởng.

Xem [điều kiện tích hợp VNPAY Sandbox](docs/vnpay-readiness.md) trước khi triển khai thanh toán.
