using Oracle.ManagedDataAccess.Client;

namespace clothin_sotre_project_with_winForms
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //string user = "HW";
            //string pass = "123";
            //string host = "localhost";
            //string port = "1521";
            //string serviceName = "XE"; // „Â„ Ãœ«

            
             string conString =
                                "User Id=HR;Password=Sys;" +
                                "Data Source=localhost:1521/XE;";


            // 2. „Õ«Ê·… «·« ’«·
            using (OracleConnection con = new OracleConnection(conString))
            {
                try
                {
                    con.Open();
                    MessageBox.Show(" „ «·« ’«· »ﬁ«⁄œ… »Ì«‰«  √Ê—«ﬂ· »‰Ã«Õ!", "‰Ã«Õ", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    // ≈€·«ﬁ «·« ’«·  ·ﬁ«∆Ì« ⁄‰œ «·Œ—ÊÃ „‰ «·‹ using
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Œÿ√ ›Ì «·« ’«·: " + ex.Message, "›‘·", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}
