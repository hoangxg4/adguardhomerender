# Sử dụng hình ảnh cơ sở Ubuntu
FROM ubuntu:latest

# Cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Tải và cài đặt AdGuard Home
RUN curl -s -S -L https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz | \
    tar xzC /opt && \
    mv /opt/AdGuardHome /opt/adguardhome

# Sử dụng thư mục làm thư mục làm việc
WORKDIR /opt/adguardhome

# Chạy AdGuard Home
CMD ["./AdGuardHome", "-s", "install"]
