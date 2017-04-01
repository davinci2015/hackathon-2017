using AutoMapper;
using CoreApi.Config;
using CoreApi.Config.Options;
using CoreApi.Database;
using CoreApi.Helpers.Authorization;
using CoreApi.Helpers.Notifications;
using CoreApi.Models;
using CoreApi.Services;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.SignalR.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Text;

namespace CoreApi
{
    public class Startup
    {
        public IConfigurationRoot Configuration { get; private set; }

        public Startup()
        {
            this.Configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("./files/config.json", false)
                .Build();
        }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddOptions();
            services.Configure<ConfigOptions>(Configuration);
            services.AddSwaggerGen();
            services.AddCors();
            services.AddDbContext<DatabaseContext>(opts => opts.UseSqlServer(Configuration["db:azure"]));
            services.AddIdentity<User, IdentityRole>()
                .AddEntityFrameworkStores<DatabaseContext>()
                .AddDefaultTokenProviders();
            services.AddSignalR();

            services.AddSingleton<IMapper>(_ => AutoMapperConfig.Config.CreateMapper());
            services.AddSingleton<SymmetricSecurityKey>(_ => new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["tokens:key"])));
            services.AddScoped<JwtSecurityTokenHandler>();
            services.AddScoped<IConnectionManager, ConnectionManager>();
            services.AddScoped<JwtTokenService>();
            services.AddScoped<FacebookTokenExchanger>();
            services.AddScoped<GoogleTokenExchanger>();
            services.AddScoped<NotificationService>();

            //services.AddMvc();
            services.AddMvcCore()
                .AddJsonFormatters()
                .AddApiExplorer()
                .AddAuthorization();
        }

        public void Configure(IApplicationBuilder app, SymmetricSecurityKey key, DatabaseContext ctx)
        {
            RecycleItem.CreateDefault(ctx);

            app.UseDeveloperExceptionPage();
            app.UseCors(opts => opts.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin().AllowCredentials());
            app.UseDefaultFiles();
            app.UseStaticFiles();
            app.UseSwagger();
            app.UseSwaggerUi();
            app.UseJwtBearerAuthentication(new JwtBearerOptions {
                AutomaticAuthenticate = true,
                AutomaticChallenge = true,
                RequireHttpsMetadata = false,
                TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = key,
                    ValidIssuer = Configuration["tokens:issuer"],
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidAudience = Configuration["tokens:audience"],
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                }
            });
            app.UseIdentity();
            app.UseSignalR();
            app.UseMvc();
        }
    }
}
