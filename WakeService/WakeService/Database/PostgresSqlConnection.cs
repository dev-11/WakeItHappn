using System.Data;
using Npgsql;

namespace WakeService.Database
{
    public class PostgresSqlConnection
    {
        public NpgsqlConnection GetConnection()
        {
            var connstring =
                $"Server=localhost;Port=5432;User Id=wakeithappen;Password=wakeithappen;Database=wakeithappen;";
            // Making connection with Npgsql provider
            var conn = new NpgsqlConnection(connstring);
            conn.Open();
            return conn;
            
            /*
            // quite complex sql statement
            string sql = "SELECT * FROM simple_table";
            // data adapter making request from our connection
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sql, conn);
            // i always reset DataSet before i do
            // something with it.... i don't know why :-)
            ds.Reset();
            // filling DataSet with result from NpgsqlDataAdapter
            da.Fill(ds);
            // since it C# DataSet can handle multiple tables, we will select first
            dt = ds.Tables[0];
            // connect grid to DataTable
            dataGridView1.DataSource = dt;
            // since we only showing the result we don't need connection anymore
            conn.Close();
            */           
        }
        
        
    }
}