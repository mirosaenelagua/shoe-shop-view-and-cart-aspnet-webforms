using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnShopBanGiay.pages
{
    public partial class HienThiSanPham1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string category = Request.QueryString["category"];
                if (category != null)
                {
                    HienThiTheoCategory(category);
                }
            }
        }

        public void HienThiTheoCategory(string category)
        {
            string query = @"SELECT COUNT(htsp.IDMauSP) OVER(PARTITION BY htsp.IDMauSP) as DemSoLuong, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP
                                    FROM HienThiSanPham htsp
                                    JOIN MauSanPham msp ON msp.IDMauSP = htsp.IDMauSP
                                    JOIN LoaiSanPham lsp ON lsp.IDLoaiSP = msp.IDLoaiSP
                                    WHERE lsp.IDLoaiSP = @category
                                    GROUP BY htsp.IDMauSP, htsp.IDSanPham, htsp.TenSanPham, htsp.UrlSP, htsp.GiaSanPham, htsp.GiaSPCu, htsp.IDMauSP";
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ShoeData"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr)) {
                    conn.Open();
                    
                    SqlDataAdapter query_to_category = new SqlDataAdapter(query, conn);
                    query_to_category.SelectCommand.Parameters.AddWithValue("@category", category);
                    DataTable qtc = new DataTable();

                    query_to_category.Fill(qtc);

                    ShowByCategory.DataSource = qtc;
                    ShowByCategory.DataBind();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

        }

        }
    }

