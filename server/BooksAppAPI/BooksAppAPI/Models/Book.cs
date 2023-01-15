using System.ComponentModel.DataAnnotations;

namespace BooksAppAPI.Models;

public class Book
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string Author { get; set; }
    public int Year { get; set; }
    public bool Lent { get; set; }
}

public class PartialBook
{
    public int Id { get; set; }
    public string? Title { get; set; }
    public string? Author { get; set; }
    public int? Year { get; set; }
    public bool? Lent { get; set; }
}