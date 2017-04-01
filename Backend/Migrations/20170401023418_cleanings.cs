using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Metadata;

namespace CoreApi.Migrations
{
    public partial class cleanings : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Money",
                table: "Users",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Nfc",
                table: "Users",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Cleanings",
                columns: table => new
                {
                    Id = table.Column<long>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    ImageAfter = table.Column<string>(nullable: true),
                    ImageBefore = table.Column<string>(nullable: true),
                    Lat = table.Column<decimal>(type: "decimal(18,6)", nullable: false),
                    Lng = table.Column<decimal>(type: "decimal(18,6)", nullable: false),
                    Name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cleanings", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Cleanings");

            migrationBuilder.DropColumn(
                name: "Money",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "Nfc",
                table: "Users");
        }
    }
}
