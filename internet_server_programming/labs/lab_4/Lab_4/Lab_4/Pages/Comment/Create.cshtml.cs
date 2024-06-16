using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text;
using Lab_4.Models;

namespace Lab_4.Pages.Comment
{
    public class CreateModel : PageModel
    {
        private readonly Data.AppDbContext _context;

        public CreateModel(Data.AppDbContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        [BindProperty]
        public Comments Comment { get; set; }


        public async Task<IActionResult> OnPostAsync(int id)
        {
            HttpContext.Session.Set("CreateComment", Encoding.UTF8.GetBytes("true"));

            var link = _context.Links.Where(x => x.Id == id).FirstOrDefault();
            if (_context.Comments == null || Comment == null || link == null)
            {
                return Page();
            }
            Comment.SessionId = this.HttpContext.Session.Id;
            Comment.Link = link;
            var a = this.HttpContext.Session.Get("isAdmin");
            if (this.HttpContext.Session.Get("isAdmin") == null)
            {
                Comment.Role = "user";
            }
            else
            {
                Comment.Role = "user";
            }
            _context.Comments.Add(Comment);
            await _context.SaveChangesAsync();

            return RedirectToPage("../Link/Index");
        }
    }
}
