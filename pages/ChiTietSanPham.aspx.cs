using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using Microsoft.SqlServer.Server;

namespace DoAnShopBanGiay.pages
{
    public partial class HienThiSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ModelShoe = Request.QueryString["IDMau"];
            string IDShoe = Request.QueryString["ID"];

            // Kiểm tra có tồn tại ModelShoe và IDShoe
            if (ModelShoe != null && IDShoe != null)
            {
                LayIDGiayVaIDMau(ModelShoe, IDShoe);

                if (!IsPostBack)
                {
                    DSMauGiay(ModelShoe); // Chỉ gọi 1 lần
                }
            }

            // Gán lại các ảnh sau khi PostBack
            if (IsPostBack)
            {
                string mainImage = hfSelectedImage.Value;
                string subImage1 = hfSubImage1.Value;
                string subImage2 = hfSubImage2.Value;

                if (!string.IsNullOrEmpty(mainImage))
                {
                    string script = $@"
                        document.getElementById('mainImage').src = '{mainImage}';
                        document.getElementById('SubImg1').src = '{mainImage}';
                        document.getElementById('SubImg2').src = '{subImage2}';
                    ";
                    ScriptManager.RegisterStartupScript(this, GetType(), "restoreImages", script, true);
                }
            }
        }

        // Lấy thông tin giày và màu
        public void LayIDGiayVaIDMau(string ModelShoe, string IDShoe)
        {
            string query = @"SELECT htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, hasp.UrlSub, 
                                    htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP
                             FROM HienThiSanPham htsp
                             JOIN MauSanPham msp ON msp.IDMauSP = htsp.IDMauSP
                             JOIN LoaiSanPham lsp ON lsp.IDLoaiSP = msp.IDLoaiSP
                             JOIN HinhAnh_IDSanPham hasp ON htsp.IDSanPham = hasp.IDSanPham
                             WHERE htsp.IDMauSP = @ModelShoe AND htsp.IDSanPham = @IDShoe";

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ShoeData"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@IDShoe", IDShoe);
                    cmd.Parameters.AddWithValue("@ModelShoe", ModelShoe);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ProductName.Text = reader["TenSanPham"].ToString();
                            ProductPrice.Text = string.Format("{0:#,##0} VNĐ", Convert.ToDecimal(reader["GiaSanPham"]));
                            ProductUnprice.Text = string.Format("{0:#,##0} VNĐ", Convert.ToDecimal(reader["GiaSPCu"]));

                            string mainImg = reader["UrlSP"].ToString();
                            string subImg = reader["UrlSub"].ToString();

                            // Lần đầu tải trang
                            if (!IsPostBack)
                            {
                                // Cập nhật URL ảnh
                                string script = $@"
                                    document.getElementById('mainImage').src = '../{mainImg}';
                                    document.getElementById('SubImg1').src = '../{mainImg}';
                                    document.getElementById('SubImg2').src = '../{subImg}';
                                    document.getElementById('{hfSelectedImage.ClientID}').value = '../{mainImg}';
                                    document.getElementById('{hfSubImage1.ClientID}').value = '../{mainImg}';
                                    document.getElementById('{hfSubImage2.ClientID}').value = '../{subImg}';
                                ";
                                ScriptManager.RegisterStartupScript(this, GetType(), "loadProduct", script, true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        // Lấy danh sách màu giày
        public void DSMauGiay(string modelShoe)
        {
            string query = @"SELECT IDSanPham, IDMauSP, UrlSP
                             FROM HienThiSanPham
                             WHERE IDMauSP = @ModelShoe";

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ShoeData"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    SqlDataAdapter dsm = new SqlDataAdapter(query, conn);
                    dsm.SelectCommand.Parameters.AddWithValue("@ModelShoe", modelShoe);

                    DataTable dt_dsm = new DataTable();
                    dsm.Fill(dt_dsm);

                    FillColor.DataSource = dt_dsm;
                    FillColor.DataBind();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Lấy thông tin sản phẩm từ query string và dropdown list
            string shoeID = Request.QueryString["ID"]; // ID sản phẩm
            string colorID = Request.QueryString["IDMauSP"]; // ID màu sản phẩm
            string sizeSelected = ddlSize.SelectedValue; // Kích thước người dùng chọn
            int quantitySelected = int.Parse(ddlSoLuong.SelectedValue); // Số lượng người dùng chọn

            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["UserName"] == null) // Nếu người dùng chưa đăng nhập
            {
                // Kiểm tra xem giỏ hàng tạm có tồn tại không
                if (Session["TempCart"] == null)
                {
                    Session["TempCart"] = new List<Dictionary<string, object>>();  // Nếu không, tạo giỏ hàng mới
                }

                // Lấy giỏ hàng tạm từ Session
                List<Dictionary<string, object>> tempCart = (List<Dictionary<string, object>>)Session["TempCart"];

                // Thêm một món hàng mới vào giỏ hàng tạm
                var productInfo = new Dictionary<string, object>
                {
                    { "ProductID", shoeID },
                    { "ColorID", colorID },
                    { "Size", sizeSelected },
                    { "Quantity", quantitySelected }
                 };


                tempCart.Add(productInfo);
                // Cập nhật lại giỏ hàng trong Session (mặc dù nếu bạn sử dụng Session, không cần phải cập nhật lại thủ công ở đây)
                Session["TempCart"] = tempCart;


                string jsonData = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(Session["TempCart"]);
                string script = $"<script>console.log({jsonData});</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LogSession", script);
                ClientScript.RegisterStartupScript(this.GetType(), "AddSuccess", "alert('Thêm vào giỏ hàng thành công!');", true);


            }
        }

    }
}
