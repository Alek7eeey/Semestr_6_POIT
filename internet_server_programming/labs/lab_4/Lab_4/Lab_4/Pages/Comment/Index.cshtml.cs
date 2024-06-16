using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Lab_4.Models;

namespace Lab_4.Pages.Comment
{
    public class IndexModel : PageModel
    {
        private readonly Data.AppDbContext _context;
        public IndexModel(Data.AppDbContext context)
        {
            _context = context;
        }

        public IList<Comments> Comment { get;set; } = default!;

        public async Task OnGetAsync()
        {
            if (_context.Comments == null) return;
            
            Comment = await _context.Comments.ToListAsync();
        }

        public IActionResult OnPostClearCookies()
        {
            HttpContext.Session.Remove("isAdmin");
            return RedirectToPage();
        }
    }
}
