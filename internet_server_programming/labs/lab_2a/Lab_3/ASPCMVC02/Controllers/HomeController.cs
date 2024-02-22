using Microsoft.AspNetCore.Mvc;

namespace ASPCMVC02.Controllers
{
    public class HomeController : Controller
    {
        public HomeController() {  }

        public IActionResult Index()
        {
            return View();
        }
    }
}