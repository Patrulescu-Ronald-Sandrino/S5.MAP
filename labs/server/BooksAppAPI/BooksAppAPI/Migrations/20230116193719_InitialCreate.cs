using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace BooksAppAPI.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Books",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Author = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Year = table.Column<int>(type: "int", nullable: false),
                    Lent = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Books", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "Books",
                columns: new[] { "Id", "Author", "Lent", "Title", "Year" },
                values: new object[,]
                {
                    { new Guid("066acf19-6f1e-4005-bb1e-98e4258a12ff"), "Author 04", true, "Book 04", 2004 },
                    { new Guid("160042ef-06a4-4691-98c0-5258abfb0e27"), "Author 08", true, "Book 08", 2008 },
                    { new Guid("362c6052-3fad-4f31-89bd-b9384a469df1"), "Author 01", false, "Book 01", 2001 },
                    { new Guid("50765f55-4f78-4995-b575-ea7de3ed6799"), "Author 03", false, "Book 03", 2003 },
                    { new Guid("766bb44e-17c6-4b30-be61-af3ea05be518"), "Author 09", false, "Book 09", 2009 },
                    { new Guid("7bad80d8-8dba-4102-a053-39d4fa4d3160"), "Author 06", true, "Book 06", 2006 },
                    { new Guid("96f98c22-bc6e-48c0-9d01-833571cb8dcd"), "Author 02", true, "Book 02", 2002 },
                    { new Guid("d36daa61-2418-4240-9bb4-c1cbaf2e1592"), "Author 07", false, "Book 07", 2007 },
                    { new Guid("e92639c3-81d2-4624-bf17-c7e75632a834"), "Author 10", true, "Book 10", 2010 },
                    { new Guid("f39e6d05-f6e6-49fb-a995-f3bb9507d903"), "Author 05", false, "Book 05", 2005 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Books");
        }
    }
}
