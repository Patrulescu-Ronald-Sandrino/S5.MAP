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
        return await _context.Books.ToListAsync();
    }
    
    [HttpPost("add-all-and-get-all")]
    public async Task<ActionResult<IEnumerable<Book>>> AddAllAndGetAll([FromBody] List<Book> books)
    {
        _logger.LogInformation("[POST] Adding books {books}", books);
        _context.Books.AddRange(books);
        await _context.SaveChangesAsync();
        return await _context.Books.ToListAsync();
    }
    
    
    [HttpGet("{id:int}")]
    public async Task<ActionResult<Book>> Get(int id)
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
        _context.Books.Add(book);
        await _context.SaveChangesAsync();
        _logger.LogInformation("Book with id {id} created", book.Id);
        return CreatedAtAction(nameof(Get), new { id = book.Id }, book);
    }
    
    [HttpPut("{id:int}")]
    public async Task<IActionResult> Put(int id, Book book)
    {
        if (id != book.Id)
        {
            return BadRequest("[PUT] Book id does not match");
        }
        _context.Entry(book).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        _logger.LogInformation("[PUT] Book with id {id} updated", id);
        return Ok();
    }
    
    [HttpDelete("{id:int}")]
    public async Task<IActionResult> Delete(int id)
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