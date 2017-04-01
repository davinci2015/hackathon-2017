using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

namespace CoreApi.Migrations
{
    public partial class multipletrees_kid : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trees_Kids_KidId",
                table: "Trees");

            migrationBuilder.DropIndex(
                name: "IX_Trees_KidId",
                table: "Trees");

            migrationBuilder.DropColumn(
                name: "TreeId",
                table: "Kids");

            migrationBuilder.AlterColumn<decimal>(
                name: "Lat",
                table: "Trees",
                type: "decimal(18,6)",
                nullable: false,
                oldClrType: typeof(decimal));

            migrationBuilder.AlterColumn<long>(
                name: "KidId",
                table: "Trees",
                nullable: true,
                oldClrType: typeof(long));

            migrationBuilder.CreateIndex(
                name: "IX_Trees_KidId",
                table: "Trees",
                column: "KidId");

            migrationBuilder.AddForeignKey(
                name: "FK_Trees_Kids_KidId",
                table: "Trees",
                column: "KidId",
                principalTable: "Kids",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trees_Kids_KidId",
                table: "Trees");

            migrationBuilder.DropIndex(
                name: "IX_Trees_KidId",
                table: "Trees");

            migrationBuilder.AlterColumn<decimal>(
                name: "Lat",
                table: "Trees",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,6)");

            migrationBuilder.AlterColumn<long>(
                name: "KidId",
                table: "Trees",
                nullable: false,
                oldClrType: typeof(long),
                oldNullable: true);

            migrationBuilder.AddColumn<long>(
                name: "TreeId",
                table: "Kids",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.CreateIndex(
                name: "IX_Trees_KidId",
                table: "Trees",
                column: "KidId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Trees_Kids_KidId",
                table: "Trees",
                column: "KidId",
                principalTable: "Kids",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
