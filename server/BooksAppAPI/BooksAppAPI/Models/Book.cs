using System.ComponentModel.DataAnnotations;

namespace BooksAppAPI.Models;

public class Book
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public string Author { get; set; }
    public int Year { get; set; }
    public bool Lent { get; set; }
}

public class PartialBook
{
    public int Guid { get; set; }
    public string? Title { get; set; }
    public string? Author { get; set; }
    public int? Year { get; set; }
    public bool? Lent { get; set; }
}