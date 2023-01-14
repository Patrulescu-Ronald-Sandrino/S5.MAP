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
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
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
                    { 1, "Author 1", false, "Book 1", 2001 },
                    { 2, "Author 2", true, "Book 2", 2002 },
                    { 3, "Author 3", false, "Book 3", 2003 },
                    { 4, "Author 4", true, "Book 4", 2004 },
                    { 5, "Author 5", false, "Book 5", 2005 },
                    { 6, "Author 6", true, "Book 6", 2006 },
                    { 7, "Author 7", false, "Book 7", 2007 },
                    { 8, "Author 8", true, "Book 8", 2008 },
                    { 9, "Author 9", false, "Book 9", 2009 },
                    { 10, "Author 10", true, "Book 10", 2010 }
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
