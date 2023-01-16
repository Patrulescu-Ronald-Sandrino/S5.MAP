using BooksAppAPI.Extensions;
using BooksAppAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BooksAppAPI.Controllers;

[ApiController]
[Route("[controller]")]
[Produces("application/json")]
public class BooksController : ControllerBase
{
    #region fields and constructors

    private readonly DatabaseContext _context;
    private readonly ILogger<BooksController> _logger;
    
    public BooksController(DatabaseContext context, ILogger<BooksController> logger)
    {
        _context = context;
        _logger = logger;
    }

    #endregion
    
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Book>>> Get()
    {
        _logger.LogInformation($"[GET] Getting all books");
        return await _context.Books.OrderBy(book => book.Year).ToListAsync();
    }
    
    [HttpPost("add-all-and-get")]
    public async Task<ActionResult<IEnumerable<Book>>> AddAllAndGet([FromBody] List<Book> books)
    {
        _logger.LogInformation("[POST] Adding books {books}", books);
        var newBooks = books.Select(book => { book.Id = Guid.NewGuid(); return book; }).ToList();
        _context.Books.AddRange(newBooks);
        await _context.SaveChangesAsync();
        _logger.LogInformation("[POST] Added books {books}", newBooks);
        return newBooks;
    }
    
    
    [HttpGet("{id:guid}")]
    public async Task<ActionResult<Book>> Get(Guid id)
    {
        _logger.LogInformation("[GET] Looking for book with id {id}", id);
        var book = await _context.Books.FindAsync(id);
        if (book == null)
        {
            _logger.LogInformation("[GET] Book with id {id} not found", id);
            return NotFound();
        }
        _logger.LogInformation("[GET] Found book with id {id}", id);
        return book;
    }
    
    [HttpPost]
    public async Task<ActionResult<Book>> Post(Book book)
    {
        book.Id = Guid.NewGuid();
        _context.Books.Add(book);
        await _context.SaveChangesAsync();
        _logger.LogInformation("Book with id {id} created", book.Id);
        return CreatedAtAction(nameof(Get), new { id = book.Id }, book);
    }
    
    [HttpPut("")]
    public async Task<ActionResult<Book>> Put(Book book)
    {
        _context.Entry(book).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        _logger.LogInformation("[PUT] Book with id {id} updated", book.Id);
        return book;
    }
    
    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var book = await _context.Books.FindAsync(id);
        if (book == null)
        {
            _logger.LogInformation("[DELETE] Book with id {id} not found", id);
            return NotFound();
        }
        _context.Books.Remove(book);
        await _context.SaveChangesAsync();
        _logger.LogInformation("[DELETE] Book with id {id} deleted", id);
        return Ok();
    }
    
}