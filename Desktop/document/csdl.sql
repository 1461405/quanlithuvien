
create database QUANLITHUVIEN
use QUANLITHUVIEN
go

--tạo bảng quản lí user và password--
create table QlUser
(
username nvarchar(10) not null,
pass nchar(10) not null
primary key(username, pass)
)

--tạo bảng quản lí độc giả--
create table DocGia
(
maDG int not null,
tenDG nvarchar(50),
loaiDG int,
CMND varchar(9),
SDT nvarchar(12),
gioitinh nchar(3),
diachi nvarchar(50),

primary key(maDG)
)

--tạo bảng quản lí loại độc giả--
create table LoaiDG
(
maloai int  not null,
tenloai nvarchar(20),
SLmuontoida int,
TLdacbiet bit,
songaymuontoida int
primary key(maloai)
)

--tạo bảng quản lí các khoản phí--
create table ThuPhi
(
maphi int  not null, 
tenphi nvarchar(20),
maloai int,
mucphi float
primary key(maphi)
)

--tạo bảng quản lí việc mượn sách--
create table Muon
(
mamuon int,
madocgia int,
ngaymuon datetime,
hanmuon int,
SLsachmuon int
primary key(mamuon)
)

--tạo bảng quản lí việc trả sách--
create table Tra
(
matra int  not null,
mamuon int,
maDG int,
ngaytra datetime,
sosachtra int,
maphi int,
primary key(matra)
)

--tạo bảng quản lí tài liệu--
create table TaiLieu
(
maTL int  not null,
tenTL nvarchar(50)  not null,
TLDB bit, --Có phải tài liệu đặc biệt hay không?--
tacgia nvarchar(35),
theloai nvarchar(20),
nhaxuatban nvarchar(50),
namXB int,
gia float,
SLuong int,
Tinhtrang nchar(3)
primary key(maTL)
)

--tạo bảng số tài liệu mượn--
create table MuonTL
(
mamuon int,
maTL int
)

--tạo bảng số tài liệu trả--
create table TraTL
(
matra int,
maTL int, 
maTLmat bit
)
drop table TraTL
--Khoa ngoai LoaiDg vs DocGia--
alter table DocGia
add constraint FK_DG_ML1
foreign key (loaiDG)
references LoaiDG(maloai)

--Khoa ngoai MucPhi vs LoaDG--
alter table ThuPhi
add constraint FK_MP_ML
foreign key (maloai)
references LoaiDG(maloai)

--Khoa ngoai Tra vs DG--
alter table Tra
add constraint FK_Tra_DG
foreign key (maDG)
references DocGia(maDG)

--Khoa ngoai Muon vs DocGia--
alter table Muon
add constraint FK_Muon_DG
foreign key (madocgia)
references DocGia(maDG)

--Khoa ngoai Tra vs Muon--
alter table Muon
add constraint FK_Tra_Muon
foreign key (mamuon)
references Muon(mamuon)


--Khoa ngoai muon va muonTL--
alter table MuonTL
add constraint FK_TL_TL
foreign key (mamuon)
references Muon(mamuon)

--Khoa ngoai tra vatraTL--
alter table TraTL
add constraint FK_Tra_TLieu
foreign key (matra)
references Tra(matra)

--Khoa ngoai muonTL vs TL--
alter table MuonTL
add constraint FK_TL_TL1
foreign key (maTL)
references TaiLieu(maTL)

--Khoa ngoai TraTL vs TL--
alter table TraTL
add constraint FK_Tra_TL
foreign key (maTL)
references TaiLieu(maTL)

--Nhập liệu bảng user vs pass word--
insert into QlUser values('1461101', 'NgocTuyet')
insert into QlUser values('1461405', 'ThiKhanh')
insert into QlUser values('1460630', 'KimNgan')
insert into QlUser values('1461703', 'MaiTruc')
insert into QlUser values('0101010', 'DucNgo')

--Nhập liệu bảng quản lí độc giả--
insert into DocGia values('1101', N'Nguyễn Hoài An',NULL, '264464242', '01641234567', N'Nam', N'25/3 Lạc ng Quân, Q.10, TP HCM')
insert into DocGia values('1102', N'Nguyễn Ngọc Ánh',NULL, '26412560', '01688415182', N'Nữ', N'12/21 Võ Văn Ngân Thủ Đức, TP HCM')
insert into DocGia values('1103', N'Trương Nam Sơn',NULL, '264123264', '01653673874', N'Nam', N'22/5 Nguyễn Xí, Q.Bình Thạnh, TPHCM')
insert into DocGia values('1104', N'Trần Trung Hiếu',NULL, '26466342', '09146374631', N'Nam', N'234 Trấn não, An Phú, TPHCM')
insert into DocGia values('1105', N'Trần Bạch Tuyết',NULL, '26475244', '01635425635', N'Nam', N'221 hùng Vương, Q.5, TPHCM')

--Nhập liệu bảng loại độc giả--
insert into LoaiDG values('1001', N'Vip', 5, 'True',14)
insert into LoaiDG values('1002', N'Thường', 3, 'false',5)

--Nhập dữ liệu bảng thu phí--
insert into ThuPhi values('100', N'Phí thường niên','1001',20000)
insert into ThuPhi values('101', N'Phí trễ hạn trả','1001',30000)
insert into ThuPhi values('102', N'Phí mất tài liệu','1001',50000)
insert into ThuPhi values('103', N'Phí thường niên','1002',30000)
insert into ThuPhi values('104', N'Phí trễ hạn trả','1002',40000)
insert into ThuPhi values('105', N'Phí mất tài liệu','1002',500000)


--Nhập dữ liệu bảng mượn--
insert into Muon values('210','1101', '2016-11-20',NULL,4)
insert into Muon values('211','1103', '2016-11-21',NULL,2)
insert into Muon values('212','1105', '2016-11-30',NULL,7)
insert into Muon values('213','1102', '2016-12-10',NULL,3)
insert into Muon values('214','1104', '2016-12-19',NULL,1)

--Nhập dữ liệu bảng trả--
insert into Tra values('310', '210', '1101','2016-11-25',4,'103')
insert into Tra values('311', '211', '1103', '2016-12-06',2,'100')
insert into Tra values('312', '212','1105', '2016-12-02',4,'105')
insert into Tra values('313', '213','1102', '2016-12-15',3,'100')
insert into Tra values('314', '214','1104', '2016-12-25',1,'103')

--Nhập dữ liệu bảng tài liệu--
insert into TaiLieu values(1, 'Code Complete 2', 'true','Steve McConnell','CNTT','Microsoft', 2004, 873181,3,N'còn')
insert into TaiLieu values(2, N'Học Nhanh Đồ Họa', 'false',N'Không rõ','CNTT',N'Văn Hóa Thông Tin', 2010, 229000,10,N'còn')
insert into TaiLieu values(3, N'Những Cánh Thư Chưa Khép', 'false','Jenny Han',N'Báo sinh viên','NXB Thanh Niên', 2016, 75000,5,N'còn')
insert into TaiLieu values(4, N'Nhật Bản Có Điều Kỳ Diệu', 'false',N'Nhiều Tác Giả',N'Hồi kí',N'Báo Sinh Viên VN - Hoa Học Trò', 2015, 53000,10,N'hết')
insert into TaiLieu values(5, N'Einstein - Cuộc Đời Và Vũ Trụ', 'true','Walter Isaacson','CNTT','NXB Thế Giới', 2016, 239000,2,N'còn')

--Nhập dữ liệu bảng MuonTL--
insert into MuonTL values('210','1')
insert into MuonTL values('210','3')
insert into MuonTL values('210','5')
insert into MuonTL values('211','2')
insert into MuonTL values('211','1')
insert into MuonTL values('211','4')
insert into MuonTL values('212','3')
insert into MuonTL values('212','5')
insert into MuonTL values('213','2')
insert into MuonTL values('213','4')
insert into MuonTL values('214','5')
insert into MuonTL values('214','3')
insert into MuonTL values('214','2')

--Nhập dữ liệu bảng TraTL--
insert into TraTL values('310','1','false')
insert into TraTL values('310','3','false')
insert into TraTL values('310','5','false')
insert into TraTL values('311','2','false')
insert into TraTL values('311','1','false')
insert into TraTL values('311','4','false')
insert into TraTL values('312','3','false')
insert into TraTL values('312','5','true')
insert into TraTL values('313','2','false')
insert into TraTL values('313','4','false')
insert into TraTL values('314','5','false')
insert into TraTL values('314','3','false')
insert into TraTL values('314','2','false')

--update bảng độc giả--
update DocGia set loaiDG='1002' where maDG='1101'
update DocGia set loaiDG='1001' where maDG='1102'
update DocGia set loaiDG='1001' where maDG='1103'
update DocGia set loaiDG='1002' where maDG='1104'
update DocGia set loaiDG='1002' where maDG='1105'

--update bảng mượn--
update Muon set hanmuon= '14' where madocgia= '1102' or madocgia='1103'
update Muon set hanmuon= '5' where madocgia= '1101' or madocgia= '1104' or madocgia= '1105'




