# Forum Specs

## Mô tả

Một trang forum với các chức năng cơ bản. Có các chức năng cơ bản như cho phép user tạo thread, post, vv.

## Các loại user

Gồm `người dùng`, `moderator` và `admin`.
`người dùng` là các user thông thường, tự đăng kí qua email.
`moderator` là người quản lý các mục nhỏ, là `người dùng` được `admin` cho phép.
`admin` là người quản lý cấp cao nhất, có quyền quản lý các user.

## Các chức năng

### Post

Người dùng tạo ra các **post**, là một đoạn văn bản, có thể đính kèm hình ảnh.

### Thread

Các **post** của người dùng về cùng một vấn đề được gộp vào một **thread**. Người dùng tạo **post** đầu tiên cũng đồng thời tạo **thread**.

### Category

Các **thread** được gộp chung vào các **category** do `admin` tạo ra và quản lý. Mỗi **category** cũng được quản lý bởi một hoặc vài `moderator`. Người quản lý có thể xóa các **thread** không hợp lệ, không cho tạo thêm **post** trong một **thread** hoặc cấm một `người dùng` tương tác với một **category**.

### Vote

`người dùng` có thể vote `up` hoặc `down` với một **thread** hay **post**. Số **vote** có thể ảnh hưởng đến thứ tự hiển thị của **thread** và **post**.

### Search

Các **thread** và **post** có thể được tìm kiếm qua các thông tin như: người đăng, tên, nội dung, category, ngày tháng

### Thống kê

Có thể xem được các thông tin thống kê, ví dụ:

- **category** được quan tâm nhất, nhiều thread nhất
- **thread** được quan tâm nhất, nhiều upvote nhất, nhiều **post** nhất
- **post** được quan tâm nhất, nhiều upvote nhất
- số `người dùng` đang online
- vv
