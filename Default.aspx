<%@ Page Title="SIEUGIAYSNEAKERS" Language="C#" MasterPageFile="~/SieuGiaySneakers.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DoAnShopBanGiay.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/trangchu.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- CAROUSEL BANNER -->
    <div id="carouselExampleIndicators" class="carousel slide">
        <div class="carousel-indicators">
            <button
                type="button"
                data-bs-target="#carouselExampleIndicators"
                data-bs-slide-to="0"
                class="active"
                aria-current="true"
                aria-label="Slide 1">
            </button>
            <button
                type="button"
                data-bs-target="#carouselExampleIndicators"
                data-bs-slide-to="1"
                aria-label="Slide 2">
            </button>
            <button
                type="button"
                data-bs-target="#carouselExampleIndicators"
                data-bs-slide-to="2"
                aria-label="Slide 3">
            </button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img
                    src="<%= ResolveUrl("assets/images/banner_images/banner1.png") %>"
                    class="d-block w-100"
                    alt="Slide 1" />
            </div>
            <div class="carousel-item">
                <img
                    src="<%= ResolveUrl("assets/images/banner_images/banner2.png") %>"
                    class="d-block w-100"
                    alt="Slide 2" />
            </div>
            <div class="carousel-item">
                <img
                    src="<%= ResolveUrl("assets/images/banner_images/banner3.png") %>"
                    class="d-block w-100"
                    alt="Slide 3" />
            </div>
        </div>
        <button
            class="carousel-control-prev"
            type="button"
            data-bs-target="#carouselExampleIndicators"
            data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Trước</span>
        </button>
        <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#carouselExampleIndicators"
            data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Tiếp</span>
        </button>
    </div>

    <!-- GIỚI THIỆU -->
    <section class="about-us my-5">
        <div
            class="about-us-icon d-flex align-items-center justify-content-center">
            <i class="bx bx-group"></i>
        </div>
        <div class="about-us-text text-center">
            <h6 class="mt-3">Về SIEUGIAYSNEAKERS</h6>
            <p class="mt-2">
                <strong>SIEUGIAYSNEAKERS</strong> được thành lập năm 2025, là địa chỉ
          uy tín cho tín đồ sneaker tại Việt Nam, chuyên cung cấp giày hot
          trend, chính hãng với chất lượng đảm bảo và giá hợp lý.<br />
                Tại đây, bạn dễ dàng tìm thấy các mẫu sneaker nổi tiếng từ Nike,
          Adidas, Converse, New Balance, Puma...<br />
                Tất cả sản phẩm đều mới 100%, cam kết chính hãng hoặc có chế độ bảo
          hành uy tín.<br />
                Chúng tôi giao hàng toàn quốc, hỗ trợ kiểm tra trước khi thanh toán và
          thường xuyên có nhiều ưu đãi, quà tặng hấp dẫn cho khách hàng thân
          thiết.
            </p>
        </div>
    </section>

    <!-- DÀNH CHO NAM -->
    <div class="show-some-product text-center my-5">
        <img src="<%= ResolveUrl("assets/images/others/558047.png") %>" alt="Danh mục Nam" />
    </div>

    <!-- hiển thị sản phẩm -->
    <div class="container show-some mt-4">
        <div class="row g-4">
            <asp:Repeater ID="maleShoe" runat="server">
                <ItemTemplate>
                    <div class="col col-md-3">
                        <a href="./pages/ChiTietSanPham.aspx?ID=<%# Eval("IDSanPham") %>&IDMau=<%# Eval("IDMauSP")%>" style="text-decoration: none; color: inherit;">
                            <div class="product-card">
                                <div class="product-img">
                                    <img src="<%# Eval("UrlSP") %>" alt="<%# Eval("TenSanPham") %>" />
                                </div>
                                <h6 class="product-name"><%# Eval("TenSanPham") %></h6>
                                <p class="color-quantity"><%# Eval("DemSoLuong") %> màu</p>
                                <div class="price-box d-flex align-items-center justify-content-center">
                                    <div class="p-price"><%# Eval("GiaSanPham", "{0:N0} VNĐ") %></div>
                                    <div class="p-unprice"><s><%# Eval("GiaSPCu", "{0:N0} VNĐ") %></s></div>
                                </div>
                            </div>
                        </a>
                    </div>


                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- nút xem thêm -->
    <div
        class="show-more-box d-flex mt-3 align-items-center justify-content-center">
        <asp:Button ID="Button1" CssClass="btn-show-more" runat="server" Text="Xem thêm giày cho nam" OnClick="Button1_Click" />
    </div>

    <!-- DÀNH CHO NỮ -->
    <div class="show-some-product text-center my-5">
        <img src="<%= ResolveUrl("assets/images/others/545429.png") %>" alt="Danh mục Nam" />
    </div>

    <!-- hiển thị sản phẩm -->
    <div class="container show-some mt-4">
        <div class="row g-4">
            <asp:Repeater ID="femaleShoe" runat="server">
                <ItemTemplate>
                    <div class="col col-md-3">
                        <a href="./pages/ChiTietSanPham.aspx?ID=<%# Eval("IDSanPham") %>&IDMau=<%# Eval("IDMauSP")%>" style="text-decoration: none; color: inherit;">
                            <div class="product-card">
                                <div class="product-img">
                                    <img src="<%# Eval("UrlSP") %>" alt="<%# Eval("TenSanPham") %>" />
                                </div>
                                <h6 class="product-name"><%# Eval("TenSanPham") %></h6>
                                <p class="color-quantity"><%# Eval("DemSoLuong") %> màu</p>
                                <div class="price-box d-flex align-items-center justify-content-center">
                                    <div class="p-price"><%# Eval("GiaSanPham", "{0:N0} VNĐ") %></div>
                                    <div class="p-unprice"><s><%# Eval("GiaSPCu", "{0:N0} VNĐ") %></s></div>
                                </div>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- nút xem thêm -->
    <div
        class="show-more-box d-flex mt-3 align-items-center justify-content-center">
        <asp:Button ID="Button2" CssClass="btn-show-more" runat="server" Text="Xem thêm giày cho nữ" OnClick="Button2_Click" />
    </div>

    <!-- UNISEX -->
    <div class="show-some-product text-center my-5">
        <img src="<%= ResolveUrl("assets/images/others/405925.png") %>" alt="Danh mục Nam" />
    </div>

    <!-- hiển thị sản phẩm -->
    <div class="container show-some mt-4">
        <div class="row g-4">
            <asp:Repeater ID="unisexShoe" runat="server">
                <ItemTemplate>
                    <div class="col col-md-3">
                        <a href="./pages/ChiTietSanPham.aspx?ID=<%# Eval("IDSanPham") %>&IDMau=<%# Eval("IDMauSP")%>" style="text-decoration: none; color: inherit;">
                            <div class="product-card">
                                <div class="product-img">
                                    <img src="<%# Eval("UrlSP") %>" alt="<%# Eval("TenSanPham") %>" />
                                </div>
                                <h6 class="product-name"><%# Eval("TenSanPham") %></h6>
                                <p class="color-quantity"><%# Eval("DemSoLuong") %> màu</p>
                                <div class="price-box d-flex align-items-center justify-content-center">
                                    <div class="p-price"><%# Eval("GiaSanPham", "{0:N0} VNĐ") %></div>
                                    <div class="p-unprice"><s><%# Eval("GiaSPCu", "{0:N0} VNĐ") %></s></div>
                                </div>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>


    <!-- nút xem thêm -->
    <div
        class="show-more-box d-flex mt-3 align-items-center justify-content-center">
        <asp:Button ID="Button3" CssClass="btn-show-more" runat="server" Text="Xem thêm giày Nam/Nữ" OnClick="Button3_Click" />
    </div>
</asp:Content>
