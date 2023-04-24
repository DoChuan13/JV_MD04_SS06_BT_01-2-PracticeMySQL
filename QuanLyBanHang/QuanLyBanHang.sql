-- Create a new database called 'QuanLyBanHang'
CREATE DATABASE QuanLyBanHang;

USE QuanLyBanHang;

-- Create the table 'KHACHHANG' in schema 'QuanlyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanlyBanHang.KHACHHANG
(
    -- Specify more columns here
    MaKH VARCHAR(4) PRIMARY KEY,
    TenKH VARCHAR(30) NOT NULL,
    DiaChi VARCHAR(50),
    NgaySinh DATETIME,
    SoDT VARCHAR(15) UNIQUE
);

-- Create the table 'NHANVIEN' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.NHANVIEN
(
    -- Specify more columns here
    MaNV VARCHAR(4) PRIMARY KEY,
    HoTen VARCHAR(30) NOT NULL,
    GioiTinh BIT NOT NULL,
    DiaChi VARCHAR(50) NOT NULL,
    NgaySinh DATETIME NOT NULL,
    DienThoai VARCHAR(15),
    Email TEXT,
    NoiSinh VARCHAR(20) NOT NULL,
    NgayVaoLam DATETIME,
    MaNQL VARCHAR(4)
);

-- Create the table 'NHACUNGCAP' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.NHACUNGCAP
(
    -- Specify more columns here
    MaNCC VARCHAR(5) PRIMARY KEY,
    TenNCC VARCHAR(50) NOT NULL,
    DiaChi VARCHAR(50) NOT NULL,
    DienThoai VARCHAR(50) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Website VARCHAR(30)
);

-- Create the table 'LOAISP' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.LOAISP
(
    -- Specify more columns here
    MaloaiSP VARCHAR(4) PRIMARY KEY,
    TenloaiSP VARCHAR(30) NOT NULL,
    Ghichu VARCHAR(100) NOT NULL
);

-- Create the table 'SANPHAM' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.SANPHAM
(
    -- Specify more columns here
    MaSP VARCHAR(4) PRIMARY KEY,
    MaloaiSP VARCHAR(4) NOT NULL,
    TenSP VARCHAR(50) NOT NULL,
    Donvitinh VARCHAR(10) NOT NULL,
    Ghichu VARCHAR(100),
    FOREIGN KEY(MaloaiSP) REFERENCES LOAISP(MaloaiSP)
);

-- Create the table 'PHIEUNHAP' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.PHIEUNHAP
(
    -- Specify more columns here
    SoPN VARCHAR(5) PRIMARY KEY,
    MaNV VARCHAR(4) NOT NULL,
    MaNCC VARCHAR(5) NOT NULL,
    NgayNhap DATETIME NOT NULL DEFAULT (CURRENT_DATE),
    Ghichu VARCHAR(100),
    FOREIGN KEY(MaNV) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY(MaNCC) REFERENCES NHACUNGCAP(MaNCC)
);

-- Create the table 'CTPHIEUNHAP' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.CTPHIEUNHAP
(
    -- Specify more columns here
    MaSP VARCHAR(4),
    SoPN VARCHAR(5),
    Soluong SMALLINT NOT NULL DEFAULT 0,
    Gianhap REAL NOT NULL CHECK (Gianhap >= 0),
    PRIMARY KEY(MaSP, SoPN),
    FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP),
    FOREIGN KEY(SoPN) REFERENCES PHIEUNHAP(SoPN)
);

-- Create the table 'PHIEUXUAT' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.PHIEUXUAT
(
    -- Specify more columns here
    SoPX VARCHAR(5) PRIMARY KEY,
    MaNV VARCHAR(4) NOT NULL,
    MaKH VARCHAR(4) NOT NULL,
    NgayBan DATETIME NOT NULL,
    Ghichu TEXT,
    FOREIGN KEY(MaNV) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY(MaKH) REFERENCES KHACHHANG(MaKH)

);

-- Create the table 'CTPHIEUXUAT' in schema 'QuanLyBanHang', if it not exists
CREATE TABLE IF NOT EXISTS QuanLyBanHang.CTPHIEUXUAT
(
    -- Specify more columns here
    SoPX VARCHAR(5),
    MaSP VARCHAR(4),
    Soluong SMALLINT NOT NULL CHECK (Soluong >= 0),
    GiaBan REAL NOT NULL CHECK (GiaBan >= 0),
    PRIMARY KEY(SoPX, MaSP),
    FOREIGN KEY(SoPX) REFERENCES PHIEUXUAT(SoPX),
    FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP)
);

insert into nhanvien(manv,hoten,gioitinh,diachi,ngaysinh,dienthoai,noisinh) values
('NV1','Nguyen Thi Ngan',0,'ha noi','1995-11-20','0350423056','thanh hoa'),
('NV2','Hoàng Thái',1,'ha noi','2000-10-12','0350423056','nghe an'),
('NV3','Trần Hiền',1,'ha noi','1998-10-30','0350423056','thái bình'),
('NV4','Phạm Mai Hương',0,'ha noi','1997-10-5','0350423056','Hà Tĩnh');

insert into nhacungcap(mancc,tenncc,diachi,dienthoai,email) values
('MCC1','nhã nam','cầu giấy','0253987265','nhanam@gmail.com'),
('MCC2','phương nam','đống đa','0253987265','phuongnam@gmail.com'),
('MCC3','nhà sách trẻ','mỹ đình','0253987265','mydinh@gmail.com'),
('MCC4','nhã nam 2','cầu giấy','0253987265','nhanam@gmail.com'),
('MCC5','nhã nam 3','cầu giấy','0253987265','nhanam@gmail.com');
insert into khachhang(makh,tenkh,diachi,ngaysinh,sodt) values
('MKH1','Hồ Văn Khánh','Nghệ An','1995-12-12','0356892152'),
('MKH2','Trần Văn Hiền','Hà Nội','1995-12-12','0356892112'),
('MKH3','Mai Văn Tuấn','Hà Tĩnh','1995-12-12','0356892179'),
('MKH4','Nguyễn Ngọc Huyền','Thái Bình','1995-12-12','0356892196'),
('MKH5','Nguyễn QuangTrung','Ninh Bình','1995-12-12','0356892178');
insert into loaisp(maloaisp,tenloaisp,ghichu) values
('LSP1','tiểu thuyết', 'kinh dị'),
('LSP2','tình cảm','tuổi teen'),
('LSP3','trinh thám','mạo hiểm');
insert into sanpham(masp,maloaisp,tensp,donvitinh) values
('SP1','LSP1','hôm nay tôi đi học','quyển'),
('SP2','LSP1','trời mưa','quyển'),
('SP3','LSP1','tóc nâu','quyển'),
('SP4','LSP2','quản lí tài chính','quyển'),
('SP5','LSP2','tên cậu là gì','quyển');
insert into phieunhap(sopn, manv,mancc) values 
('PN1','NV1','MCC1'),
('PN2','NV1','MCC1'),
('PN3','NV2','MCC2'),
('PN4','NV3','MCC3');
insert into phieuxuat(sopx, manv, makh, ngayban) values
('PX1','NV1','MKH1','2021-10-1'),
('PX2','NV4','MKH4','2022-4-1'),
('PX3','NV3','MKH3','2022-6-1'),
('PX4','NV2','MKH2','2023-2-1');
insert into ctphieunhap(masp,sopn,soluong,gianhap) values
('SP1','PN1',10,20000),
('SP2','PN1',12,30000),
('SP3','PN2',6,25000),
('SP4','PN1',5,23000);
insert into ctphieuxuat(sopx,masp,soluong,giaban) values
('PX1','SP1',10,52000),('PX2','SP2',7,53000),('PX3','SP4',4,54000),('PX4','SP5',9,55000);


-- insert into ctphieunhap(masp,sopn,soluong,gianhap) values
-- ('SP1','PN10',10,20000);
-- SELECT * FROM CTPHIEUNHAP ;
-- DESCRIBE phieuxuat ;