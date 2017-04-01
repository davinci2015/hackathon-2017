using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Config.Options
{
    public class ConfigOptions
    {
        public DbConfigOptions Db { get; set; }
        public TokenConfigOptions Tokens { get; set; }
        public FirebaseOptions Firebase { get; set; }
    }

    public class FirebaseOptions
    {
        public string ApiKey { get; set; }
    }

    public class TokenConfigOptions
    {
        public string Key { get; set; }
        public string Issuer { get; set; }
        public string Audience { get; set; }
    }

    public class DbConfigOptions
    {
        public string Azure { get; set; }
        public string AppHarbor { get; set; }
        public string Local { get; set; }
    }
}
