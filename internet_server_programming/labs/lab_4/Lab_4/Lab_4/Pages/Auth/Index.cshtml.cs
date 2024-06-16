using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text;

namespace Lab_4.Pages.Auth
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
            if (HttpContext.Session.Get("isAdmin") != null)
            {
                return Redirect("https://localhost:7048/");
            }

            if (Request.Query.TryGetValue("shortcut", out var shortcutValues))
            {
                if (shortcutValues == "ctrl 1")
                {
                    return Page();
                }
            }
            return RedirectToPage("/Error");
        }


        [BindProperty]
        public string Password { get; set; } = default!;

        public async Task<IActionResult> OnPostAsync()
        {
            var defaultPassword = "1";  
            if (_context.Links == null || Password == null)
            {
                return Page();
            }

            if (Password == defaultPassword)
            {
                HttpContext.Session.Set("isAdmin", Encoding.UTF8.GetBytes("true"));
            }

            return Redirect("https://localhost:7048/");
        }
    }
}
