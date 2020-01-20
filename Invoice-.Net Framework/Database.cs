using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Data;
using System.Runtime.ExceptionServices;
using System.IO;

namespace InvoiceAppV2.Model
{
    class Database
    {
        private OleDbConnection connection = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:--file Path Goes Here--;Persist Security Info=False;");
        
        [HandleProcessCorruptedStateExceptions]
        public void OpenConnection()
        {
            try
            {
                connection.Open();
            }
            catch (AccessViolationException ex)
            {
                connection.Close();
                throw new Exception(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    connection.Close();
                }
            }
            
        }

        public void CloseConnection()
        {
            connection.Close();
        }

        public void ExuteQueries(OleDbCommand ole)
        {
            //command = new OleDbCommand(queryString, connection);
            //command.ExecuteNonQuery();

            ole.Connection = connection;
            ole.ExecuteNonQuery();
        }

        public OleDbDataReader DbDataReader(OleDbCommand ole)
        {
            ole.Connection = connection;

            return ole.ExecuteReader();
        }

        public object ShowDataInGridView(string query)
        {
            OleDbDataAdapter dataAdapter = new OleDbDataAdapter(query, connection);
            DataSet dataSet = new DataSet();
            dataAdapter.Fill(dataSet);
            object data = dataSet.Tables[0];

            return data;
        }

        public int QueryExcuteScalar(OleDbCommand ole)
        {
            ole.Connection = connection;
            return (int)ole.ExecuteScalar();
        }

        public int QueryExcuteScaler2(string query)
        {
            OleDbCommand command = new OleDbCommand(query, connection);
            OpenConnection();

            int queryCounrt = 0;
            queryCounrt += (int)command.ExecuteScalar();
            CloseConnection();

            return queryCounrt;
        }

        public void IsConnectionClose()
        {
            if (connection != null && connection.State == ConnectionState.Open)
            {
                connection.Close();
            }
        }
    }
}
