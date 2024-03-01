using Microsoft.AspNetCore.Mvc;

public class StatusController : Controller
{
    private readonly Random random;
    public StatusController() 
    {
        random = new Random();
    }

    public IActionResult S200()
    {
        return StatusCode(random.Next(200, 299));
    }

    public IActionResult S300()
    {
        return StatusCode(random.Next(300, 399));
    }

    public IActionResult S500()
    {
        try
        {
            int zero = 0;
            int result = 100 / zero;
        }
        catch
        {
            return StatusCode(random.Next(500, 599));
        }

        return Ok();
    }
}
