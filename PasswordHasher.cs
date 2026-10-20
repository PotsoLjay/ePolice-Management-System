using System;
using System.Security.Cryptography;

namespace EPOLICE
{
    /// <summary>
    /// Password hashing using PBKDF2 (HMAC-SHA256) with a random salt per password.
    /// Stored format:  pbkdf2$iterations$base64(salt)$base64(hash)
    /// </summary>
    public static class PasswordHasher
    {
        private const string Prefix = "pbkdf2";
        private const int Iterations = 100000;
        private const int SaltSize = 16;
        private const int HashSize = 32;

        public static string Hash(string password)
        {
            byte[] salt = new byte[SaltSize];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            byte[] hash = Derive(password, salt, Iterations, HashSize);

            return Prefix + "$" + Iterations + "$" + Convert.ToBase64String(salt) + "$" + Convert.ToBase64String(hash);
        }

        /// <summary>True if the stored value is already in the hashed format.</summary>
        public static bool IsHashed(string stored)
        {
            return stored != null && stored.StartsWith(Prefix + "$", StringComparison.Ordinal);
        }

        /// <summary>Checks a password against a value produced by Hash().</summary>
        public static bool Verify(string password, string stored)
        {
            if (password == null || !IsHashed(stored))
            {
                return false;
            }

            string[] parts = stored.Split('$');
            if (parts.Length != 4)
            {
                return false;
            }

            int iterations;
            if (!int.TryParse(parts[1], out iterations) || iterations < 1)
            {
                return false;
            }

            byte[] salt;
            byte[] expected;
            try
            {
                salt = Convert.FromBase64String(parts[2]);
                expected = Convert.FromBase64String(parts[3]);
            }
            catch (FormatException)
            {
                return false;
            }

            if (expected.Length == 0)
            {
                return false;
            }

            byte[] actual = Derive(password, salt, iterations, expected.Length);
            return ConstantTimeEquals(actual, expected);
        }

        /// <summary>
        /// Used once per account to recognise passwords saved before hashing was added.
        /// On a successful match the caller should replace the stored value with Hash().
        /// </summary>
        public static bool LegacyPlainTextMatches(string password, string stored)
        {
            if (password == null || stored == null || IsHashed(stored))
            {
                return false;
            }

            return ConstantTimeEquals(
                System.Text.Encoding.UTF8.GetBytes(password),
                System.Text.Encoding.UTF8.GetBytes(stored));
        }

        /// <summary>Random temporary password (no look-alike characters like 0/O or 1/l).</summary>
        public static string GenerateTemporaryPassword(int length)
        {
            const string chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
            byte[] buffer = new byte[length];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(buffer);
            }

            char[] result = new char[length];
            for (int i = 0; i < length; i++)
            {
                result[i] = chars[buffer[i] % chars.Length];
            }
            return new string(result);
        }

        private static byte[] Derive(string password, byte[] salt, int iterations, int length)
        {
            using (Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(password, salt, iterations, HashAlgorithmName.SHA256))
            {
                return pbkdf2.GetBytes(length);
            }
        }

        private static bool ConstantTimeEquals(byte[] a, byte[] b)
        {
            if (a.Length != b.Length)
            {
                return false;
            }

            int diff = 0;
            for (int i = 0; i < a.Length; i++)
            {
                diff |= a[i] ^ b[i];
            }
            return diff == 0;
        }
    }
}
