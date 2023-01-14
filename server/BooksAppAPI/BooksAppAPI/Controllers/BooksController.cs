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
        return await _context.Books.ToListAsync();
    }
}