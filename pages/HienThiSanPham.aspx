<%@ Page Title="" Language="C#" MasterPageFile="~/SieuGiaySneakers.Master" AutoEventWireup="true" CodeBehind="HienThiSanPham.aspx.cs" Inherits="DoAnShopBanGiay.pages.HienThiSanPham1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/hienthisanpham.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bộ lọc -->
    <div class="container show-some mt-4">
        <div class="row g-4">
            <div>
                <span class="sort-by-price">Sắp xếp theo (Giá):</span>
                <asp:DropDownList ID="ddlSize" runat="server" AutoPostBack="false" CssClass="quantity-select" Width="60px">
                    <asp:ListItem Text="Mặc định" Value="36" />
                    <asp:ListItem Text="Tăng dần" Value="37" />
                    <asp:ListItem Text="Giảm dần" Value="38" />
                </asp:DropDownList>
            </div>

        </div>
        </div>

        <!-- hiển thị sản phẩm -->
        <div class="container show-some mt-4">
            <div class="row g-4">
                <asp:Repeater ID="ShowByCategory" runat="server">
                    <ItemTemplate>
                        <div class="col col-md-3">
                            <a href="./ChiTietSanPham.aspx?ID=<%# Eval("IDSanPham") %>&IDMau=<%# Eval("IDMauSP")%>" style="text-decoration: none; color: inherit;">
                                <div class="product-card">
                                    <div class="product-img">
                                        <img src="<%# "../" + Eval("UrlSP") %>" alt="<%# Eval("TenSanPham") %>" />
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
</asp:Content>
