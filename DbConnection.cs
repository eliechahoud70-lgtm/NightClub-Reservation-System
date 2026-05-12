using MySql.Data.MySqlClient;

namespace nightclubReservation
{
    public class DbConnection
    {
        private static string connectionString = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclub_db";

        public static MySqlConnection GetConnection()
        {
            MySqlConnection conn = new MySqlConnection(connectionString);
            return conn;
        }
    }
}
