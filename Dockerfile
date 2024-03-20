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

# Đọc các biến môi trường từ tập tin .env
ARG DNS_PORT
ARG DHCP_PORT
ARG DHCPv6_PORT
ARG HTTPS_PORT
ARG DNS_OVER_TLS_PORT
ARG HTTP_PORT
ARG DNS_OVER_HTTPS_PORT

# Mở các cổng của AdGuard Home sử dụng các biến môi trường
EXPOSE $DNS_PORT/tcp $DNS_PORT/udp \
       $DHCP_PORT/udp $DHCPv6_PORT/udp \
       $HTTPS_PORT/tcp $DNS_OVER_TLS_PORT/tcp \
       $HTTP_PORT/tcp $DNS_OVER_HTTPS_PORT/tcp

# Chạy AdGuard Home với các cổng được cấu hình từ các biến môi trường
CMD ["./AdGuardHome", "-s", "install", "-l", "0.0.0.0:$DNS_PORT,0.0.0.0:$DHCP_PORT,0.0.0.0:$DHCPv6_PORT,0.0.0.0:$HTTPS_PORT,0.0.0.0:$DNS_OVER_TLS_PORT,0.0.0.0:$HTTP_PORT,0.0.0.0:$DNS_OVER_HTTPS_PORT"]
