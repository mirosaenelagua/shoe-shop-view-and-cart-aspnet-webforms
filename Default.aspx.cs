using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace DoAnShopBanGiay
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HienThiDanhSachGiay();
            }
        }

        public void HienThiDanhSachGiay()
        {
            string layGiayUnisex = @"SELECT TOP 4 COUNT(htsp.IDMauSP) OVER(PARTITION BY htsp.IDMauSP) as DemSoLuong, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP
                                    FROM HienThiSanPham htsp
                                    JOIN MauSanPham msp ON msp.IDMauSP = htsp.IDMauSP
                                    JOIN LoaiSanPham lsp ON lsp.IDLoaiSP = msp.IDLoaiSP
                                    WHERE lsp.IDLoaiSP = 'SneakerUnisex'
                                    GROUP BY htsp.IDMauSP, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP";

            string layGiayNu = @"SELECT TOP 4 COUNT(htsp.IDMauSP) OVER(PARTITION BY htsp.IDMauSP) as DemSoLuong, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP
                                    FROM HienThiSanPham htsp
                                    JOIN MauSanPham msp ON msp.IDMauSP = htsp.IDMauSP
                                    JOIN LoaiSanPham lsp ON lsp.IDLoaiSP = msp.IDLoaiSP
                                    WHERE lsp.IDLoaiSP = 'SneakerNu'
                                    GROUP BY htsp.IDMauSP, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP";

            string layGiayNam = @"SELECT TOP 4 COUNT(htsp.IDMauSP) OVER(PARTITION BY htsp.IDMauSP) as DemSoLuong, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP
                                    FROM HienThiSanPham htsp
                                    JOIN MauSanPham msp ON msp.IDMauSP = htsp.IDMauSP
                                    JOIN LoaiSanPham lsp ON lsp.IDLoaiSP = msp.IDLoaiSP
                                    WHERE lsp.IDLoaiSP = 'SneakerNam'
                                    GROUP BY htsp.IDMauSP, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP";

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ShoeData"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // UNISEX 
                    SqlDataAdapter giayNamNu = new SqlDataAdapter(layGiayUnisex, conn);
          
                    DataTable dtNamNu = new DataTable();
                    giayNamNu.Fill(dtNamNu);

                    unisexShoe.DataSource = dtNamNu;
                    unisexShoe.DataBind();

                    // GIÀY NỮ
                    SqlDataAdapter giayNu = new SqlDataAdapter(layGiayNu, conn);
                    DataTable dtNu = new DataTable();

                    giayNu.Fill(dtNu);
                    femaleShoe.DataSource = dtNu;
                    femaleShoe.DataBind();

                    // GIÀY NAM
                    SqlDataAdapter giayNam = new SqlDataAdapter(layGiayNam, conn);

                    DataTable dtNam = new DataTable();
                    giayNam.Fill(dtNam);

                    maleShoe.DataSource = dtNam;
                    maleShoe.DataBind();

                }

            }
            catch (Exception ex) {
                Console.WriteLine(ex.Message);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("pages/HienThiSanPham.aspx?category=SneakerNam");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("pages/HienThiSanPham.aspx?category=SneakerNu");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("pages/HienThiSanPham.aspx?category=SneakerUnisex");
        }
    }
}
