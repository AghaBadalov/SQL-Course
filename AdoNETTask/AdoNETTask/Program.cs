using System.Data.SqlClient;

namespace AdoNETTask
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("MELLIME OZUVUZ KOMMENTDEN CIXARIB QIYMET ID  ZEHMET OLMAZSA :)");
            //GetData(5);
            GetAllDatas();
            //Console.WriteLine("a");
            //Insert();
            //Delete(6);
            //Update(8);

        }
        public static void GetData(int id)
        {
            string connection = "Server=AGHAMALI\\SQLEXPRESS;Database=MYCourseTask;Trusted_Connection=True";
            using (SqlConnection sqlConnection = new SqlConnection(connection))
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand($"SELECT * FROM Students WHERE Students.Id={id} ", sqlConnection);
                SqlDataReader reader=cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Console.WriteLine($"{reader[0]} - {reader[1]}-{reader[2]}-{reader[3]}-{reader[4]}-{reader[5]}");
                    }
                }
                else
                {
                    Console.WriteLine("There is no student like that");
                }

            }
        }
        public static void GetAllDatas()
        {
            string connection = "Server=AGHAMALI\\SQLEXPRESS;Database=MYCourseTask;Trusted_Connection=True";
            using (SqlConnection sqlConnection = new SqlConnection(connection))
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Students  ", sqlConnection);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Console.WriteLine($"{reader[0]} - {reader[1]}-{reader[2]}-{reader[3]}-{reader[4]}-{reader[5]}");
                    }
                }
                else
                {
                    Console.WriteLine("There is no student like that");
                }

            }
        }
        public static void Insert()
        {
            string connection = "Server=AGHAMALI\\SQLEXPRESS;Database=MYCourseTask;Trusted_Connection=True";
            using (SqlConnection sqlConnection = new SqlConnection(connection))
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Students VALUES ('Agha','Bada',17,'False',1)  ", sqlConnection);
                int check = cmd.ExecuteNonQuery();
                if (check > 0)
                {
                    Console.WriteLine($"1 row added");
                }
                else
                {
                    Console.WriteLine("Error");
                }
                

            }

        }
        public static void Delete(int id)
        {
            string connection = "Server=AGHAMALI\\SQLEXPRESS;Database=MYCourseTask;Trusted_Connection=True";
            using (SqlConnection sqlConnection = new SqlConnection(connection))
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand($"Delete FROM Students WHERE Id={id} ", sqlConnection);
                int check = cmd.ExecuteNonQuery();
                if (check > 0)
                {
                    Console.WriteLine("deleted");
                }
                else
                {
                    Console.WriteLine("Error");
                }


            }

        }

        public static void Update(int id)
        {
            string connection = "Server=AGHAMALI\\SQLEXPRESS;Database=MYCourseTask;Trusted_Connection=True";
            using (SqlConnection sqlConnection = new SqlConnection(connection))
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand($"UPDATE Students SET Name='Name changed' Where Id={id} ", sqlConnection);
                int check = cmd.ExecuteNonQuery();
                if (check > 0)
                {
                    Console.WriteLine("Updated");
                }
                else
                {
                    Console.WriteLine("Error");
                }


            }

        }
    }
}