<%@ Page Title="" Language="C#" MasterPageFile="~/SieuGiaySneakers.Master" AutoEventWireup="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="DoAnShopBanGiay.pages.HienThiSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/chitietsanpham.css") %>" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- CHI TIẾT SẢN PHẨM -->
    <div class="container-fluid">

        <div class="row mt-4">
            <!-- ảnh sản phẩm -->
            <div class="col-md-7 d-flex justify-content-center">
                <div class="img-box">
                    <div class="img-sub">
                        <img id="SubImg1" class="sub-img" src="https://product.hstatic.net/1000230642/product/hsm007505trg__4__8358b995046e4e45adfaa2796006be9c_large.jpg" alt="Sub Image 1" onclick="changeMainImage(this)" />
                        <img id="SubImg2" class="sub-img" src="https://product.hstatic.net/1000230642/product/hsm007505trg__4__8358b995046e4e45adfaa2796006be9c_large.jpg" alt="Sub Image 2" onclick="changeMainImage(this)" />
                    </div>
                    <div class="img-main">
                        <img class="main-img" id="mainImage" src="https://product.hstatic.net/1000230642/product/hsm009000den__7__da9618a5793642219bfd25bbe0c8aae1_large.jpg" alt="Main Image" />
                    </div>
                </div>
            </div>

            <!-- thông tin sản phẩm -->
            <div class="col-md-5 product-info">
                <!-- name -->
                <asp:Label ID="ProductName" CssClass="product-name" runat="server" Text="Label"></asp:Label>
                <!-- price -->
                <asp:Label ID="ProductPrice" CssClass="product-price" runat="server" Text="Label"></asp:Label>
                <!-- unprice -->
                <span class="product-unprice"><s>
                    <asp:Label ID="ProductUnprice" runat="server" Text="Label"></asp:Label></s></span>


                <!-- PHẦN KHÔNG THAY ĐỔI -->

                <div class="return-reputable-shipping gap-4">
                    <div class="info">
                        <div class="img-box">
                            <img class="img-icon" src="https://bizweb.dktcdn.net/100/466/874/themes/921146/assets/product_poli_1.png?1734948255984" alt="" />
                        </div>
                        <div class="info-text">Đổi trả dễ dàng</div>
                    </div>
                    <div class="info">
                        <div class="img-box">
                            <img class="img-icon" src="https://bizweb.dktcdn.net/100/466/874/themes/921146/assets/product_poli_2.png?1734948255984" alt="" />
                        </div>
                        <div class="info-text">Uy tín chất lượng</div>
                    </div>
                    <div class="info">
                        <div class="img-box">
                            <img class="img-icon" src="https://bizweb.dktcdn.net/100/466/874/themes/921146/assets/product_poli_3.png?1734948255984" alt="" />
                        </div>
                        <div class="info-text">Giao hàng toàn quốc</div>
                    </div>
                </div>

                <!-- màu sản phẩm -->
                <!-- Danh sách các sản phẩm cùng Model (IDMau) -->
                <div class="color-list">
                    <div class="title">Màu sản phẩm</div>
                    <div class="list-box">
                        <asp:Repeater ID="FillColor" runat="server">
                            <ItemTemplate>
                                <a href='ChiTietSanPham.aspx?ID=<%# Eval("IDSanPham") %>&IDMau=<%# Eval("IDMauSP") %>'>
                                    <img class="color-img" src='<%# ResolveUrl("../" + Eval("UrlSP").ToString()) %>' alt='ảnh màu' />
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <!-- Size giày -->
                <div>
                    <span class="size-box">Chọn Size: </span>
                    <asp:DropDownList ID="ddlSize" runat="server" AutoPostBack="false" CssClass="quantity-select" Width="60px">
                        <asp:ListItem Text="36" Value="36" />
                        <asp:ListItem Text="37" Value="37" />
                        <asp:ListItem Text="38" Value="38" />
                        <asp:ListItem Text="39" Value="39" />
                        <asp:ListItem Text="40" Value="40" />
                        <asp:ListItem Text="41" Value="41" />
                        <asp:ListItem Text="42" Value="42" />
                        <asp:ListItem Text="43" Value="43" />
                        <asp:ListItem Text="44" Value="44" />
                    </asp:DropDownList>
                </div>

                <!-- Số lượng mua -->
                <div>
                    <span class="quantity-box">Số lượng: </span>
                    <asp:DropDownList ID="ddlSoLuong" runat="server" AutoPostBack="false" CssClass="quantity-select" Width="60px">
                        <asp:ListItem Text="1" Value="1" />
                        <asp:ListItem Text="2" Value="2" />
                        <asp:ListItem Text="3" Value="3" />
                        <asp:ListItem Text="4" Value="4" />
                        <asp:ListItem Text="5" Value="5" />
                        <asp:ListItem Text="6" Value="6" />
                        <asp:ListItem Text="7" Value="7" />
                        <asp:ListItem Text="8" Value="8" />
                        <asp:ListItem Text="9" Value="9" />
                        <asp:ListItem Text="10" Value="10" />
                    </asp:DropDownList>
                </div>

                <!-- Nút thêm vào giỏ hàng & Mua hàng -->
                <div class="mt-4 d-flex gap-3">
                    <!-- Nút thêm vào giỏ hàng -->
                    <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="btn-add-to-cart" OnClick="btnAddToCart_Click">
                        <i class='bx bx-cart-add'></i> Thêm vào giỏ hàng
                    </asp:LinkButton>
                    <!-- Nút mua hàng -->
                    <asp:LinkButton ID="btnBuy" runat="server" CssClass="btn-buy">Mua hàng</asp:LinkButton>
                </div>

                <!-- Khi bấm hàm button thì không bị đổi ảnh -->
                <asp:HiddenField ID="hfSelectedImage" runat="server" />
                <asp:HiddenField ID="hfSubImage1" runat="server" />
                <asp:HiddenField ID="hfSubImage2" runat="server" />

            </div>
        </div>

    </div>
    <script type="text/javascript">
        function changeMainImage(imgElement) {
            var mainChange = document.getElementById("mainImage");
            mainChange.src = imgElement.src;
        }
    </script>

</asp:Content>
