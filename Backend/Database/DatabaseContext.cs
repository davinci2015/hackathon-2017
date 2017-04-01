using CoreApi.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace CoreApi.Database
{
    public class DatabaseContext : IdentityDbContext<User>
    {
        public DbSet<Event> Events { get; set; }
        public DbSet<RecycleItem> Items { get; set; }
        public DbSet<ItemPart> ItemParts { get; set; }
        public DbSet<Links> Links { get; set; }
        public DbSet<KidUser> Kids { get; set; }
        public DbSet<Tree> Trees { get; set; }
        public DbSet<Cleaning> Cleanings { get; set; }

        public DatabaseContext(DbContextOptions options) : base(options)
        { }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            
            builder.Entity<User>().ToTable("Users");
            builder.Entity<IdentityRole>().ToTable("Roles");
            builder.Entity<IdentityUserRole<string>>().ToTable("UserRoles");
            builder.Entity<IdentityUserClaim<string>>().ToTable("UserClaims");
            builder.Entity<IdentityUserLogin<string>>().ToTable("UserLogins");
            builder.Entity<IdentityUserToken<string>>().ToTable("UserTokens");
            builder.Entity<IdentityRoleClaim<string>>().ToTable("RoleClaims");

            var events = builder.Entity<Event>();
            events.Property(x => x.Lat)
                .HasColumnType("decimal(18,6)");
            events.Property(x => x.Lng)
                .HasColumnType("decimal(18,6)");

            builder.Entity<EventsUsers>()
                .HasKey(x => new { x.EventId, x.UserId });

            builder.Entity<EventsUsers>()
                .HasOne(x => x.User)
                .WithMany(x => x.EventUsers)
                .HasForeignKey(x => x.UserId);

            builder.Entity<EventsUsers>()
                .HasOne(x => x.Event)
                .WithMany(x => x.EventUsers)
                .HasForeignKey(x => x.EventId);

            builder.Entity<Tree>()
                .Property(x => x.Lat)
                .HasColumnType("decimal(18,6)");

            builder.Entity<Tree>()
                .Property(x => x.Lng)
                .HasColumnType("decimal(18,6)");

            var cleaning = builder.Entity<Cleaning>();
            cleaning.Property(x => x.Lat)
                .HasColumnType("decimal(18,6)");
            cleaning.Property(x => x.Lng)
                .HasColumnType("decimal(18,6)");

            //builder.Entity<KidUser>()
            //    .HasOne(x => x.Tree)
            //    .WithOne(x => x.Kid)
            //    .HasForeignKey<Tree>(x => x.KidId);
        }
    }
}
