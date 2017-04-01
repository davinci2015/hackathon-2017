using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace CoreApi.Database
{
    public class DatabaseContextFactory : IDbContextFactory<DatabaseContext>
    {
        public IConfigurationRoot Configuration { get; private set; }

        public DatabaseContext Create(DbContextFactoryOptions options)
        {
            var dir = new DirectoryInfo(Directory.GetCurrentDirectory());

            this.Configuration = new ConfigurationBuilder()
                .SetBasePath(dir.Parent.Parent.Parent.FullName)
                .AddJsonFile("./files/config.json", false)
                .Build();

            var opts = new DbContextOptionsBuilder<DatabaseContext>();
            opts.UseSqlServer(Configuration["db:azure"]);

            return new DatabaseContext(opts.Options);
        }
    }
}
