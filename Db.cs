using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace EPOLICE
{
    /// <summary>
    /// Single place that knows how to reach the database.
    /// The connection string lives in ConnectionStrings.config (not committed to Git).
    /// </summary>
    public static class Db
    {
        public static string ConnectionString
        {
            get
            {
                ConnectionStringSettings setting = ConfigurationManager.ConnectionStrings["ePoliceDb"];

                if (setting == null || string.IsNullOrWhiteSpace(setting.ConnectionString))
                {
                    throw new InvalidOperationException(
                        "Connection string 'ePoliceDb' was not found. " +
                        "Copy ConnectionStrings.config.example to ConnectionStrings.config " +
                        "and fill in your MySQL details.");
                }

                return setting.ConnectionString;
            }
        }

        public static MySqlConnection CreateConnection()
        {
            return new MySqlConnection(ConnectionString);
        }
    }
}
