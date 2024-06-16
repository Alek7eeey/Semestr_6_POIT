using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Lab_4.Models;

namespace Lab_4.Pages.Link
{
    public class DeleteModel : PageModel
    {
        private readonly Data.AppDbContext _context;

        public DeleteModel(Data.AppDbContext context)
        {
            _context = context;
        }

      [BindProperty]
      public Links Link { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Links == null)
            {
                return NotFound();
            }

            var link = await _context.Links.FirstOrDefaultAsync(m => m.Id == id);

            if (link == null)
            {
                return NotFound();
            }
            else 
            {
                Link = link;
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.Links == null)
            {
                return NotFound();
            }
            var link = await _context.Links.FindAsync(id);

            if (link != null)
            {
                Link = link;
                _context.Links.Remove(Link);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
