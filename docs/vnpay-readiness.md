# Điều kiện tích hợp VNPAY Sandbox

Tài liệu này chỉ ghi các điều kiện cần thử sớm. Kiến trúc server, cơ sở dữ liệu và giao thức socket sẽ được quyết định sau khi có kết quả thử nghiệm.

## Cần có trước khi viết luồng thanh toán

1. Đăng ký merchant sandbox để nhận `vnp_TmnCode` và `vnp_HashSecret` riêng. Không dùng mã demo làm cấu hình ứng dụng.
2. Có địa chỉ IPN HTTPS công khai, cố định trong thời gian thử nghiệm, nhận được lời gọi từ Internet. Xác nhận đường truyền, TLS và định tuyến tới chương trình C.
3. Có Return URL HTTPS để trình duyệt quay lại sau thanh toán. Return URL chỉ dùng để hiển thị; kết quả thanh toán được ghi nhận từ IPN hoặc API đối soát.
4. Cài thư viện phát triển OpenSSL để tạo/kiểm tra HMAC-SHA512 và hỗ trợ phần HTTPS. Xem README để cài gói còn thiếu.
5. Giữ thông tin thật trong `.env` cục bộ. `.env.example` chỉ chứa tên biến và URL mẫu.

Kiểm tra cấu hình cục bộ bằng `bash scripts/check-vnpay-config.sh`. Script không in secret và chưa chứng minh được IPN thực sự hoạt động; điều đó chỉ xác nhận được khi hoàn tất một giao dịch sandbox.

## Spike cần hoàn thành trước khi chốt kiến trúc

- [ ] Nhận thông tin merchant sandbox; kiểm tra mã merchant và secret được đọc từ môi trường.
- [ ] Tạo HTTPS endpoint công khai và nhận được một lời gọi GET thử nghiệm từ bên ngoài.
- [ ] Thực hiện một thanh toán bằng thẻ test trên VNPAY Sandbox.
- [ ] Nhận IPN, xác minh chữ ký, mã đơn và số tiền; phản hồi JSON `RspCode`/`Message` theo tài liệu VNPAY.
- [ ] Thử IPN gửi lặp và xác nhận chỉ ghi nhận giao dịch một lần.
- [ ] Thử `querydr` khi chưa có kết quả rõ ràng; kiểm tra luồng `refund` trước khi thiết kế hủy vé đã thanh toán.

Nếu thiếu IPN hoặc mạng gián đoạn, đơn hàng vẫn ở trạng thái chờ xác minh. Chỉ phát hành vé sau khi có kết quả thanh toán thành công đã được xác thực. Việc hết hạn giữ ghế và hoàn tiền sẽ được thiết kế sau spike này.

## Nguồn chính thức

- [Thanh toán PAY, IPN và Return URL](https://sandbox.vnpayment.vn/apis/docs/thanh-toan-pay/pay.html)
- [API querydr và refund](https://sandbox.vnpayment.vn/apis/docs/truy-van-hoan-tien/querydr%26refund.html)
- [Demo và thẻ test](https://sandbox.vnpayment.vn/apis/vnpay-demo/)
