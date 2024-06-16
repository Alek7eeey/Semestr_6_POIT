using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Lab_4.Models;
using System.Text;

namespace Lab_4.Pages.Link
{
    public class IndexModel : PageModel
    {
        private readonly Data.AppDbContext _context;
        public IndexModel(Data.AppDbContext context)
        {
            _context = context;
        }

        public IList<Links> Link { get;set; } = default!;

        public async Task OnGetAsync()
        {
            if (_context.Links != null)
            {
                Link = await _context.Links.ToListAsync();
            }
        }

        public IActionResult OnPostClearCookies()
        {
            HttpContext.Session.Remove("isAdmin");
            return RedirectToPage();
        }
    }
}
