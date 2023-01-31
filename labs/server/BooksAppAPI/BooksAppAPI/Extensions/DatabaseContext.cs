using BooksAppAPI.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace BooksAppAPI.Extensions;

public class DatabaseContext : DbContext
{
    public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
    {
    }

    public DbSet<Book> Books { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Book>(BookConfigure);
    }

    private static void BookConfigure(EntityTypeBuilder<Book> builder)
    {
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasValueGenerator<SequentialGuidValueGenerator>();
        builder.HasData(Enumerable.Range(1, 10).Select(i => new Book
        {
            Id = Guid.NewGuid(), 
            Title = $"Book {i:00}",
            Author = $"Author {i:00}",
            Year = i + 2000,
            Lent = i % 2 == 0
        }));
        
    }
}