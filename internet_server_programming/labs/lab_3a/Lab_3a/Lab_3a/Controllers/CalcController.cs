using Lab_3a.Constants;
using Microsoft.AspNetCore.Mvc;

namespace Lab_3a.Controllers
{
    public class CalcController : Controller
    {
        private readonly string _operations = "+-*/";
        public ActionResult Index(string? press, float? x, float? y)
        {
            try
            {
                float? z = 0;
                string errorsDescr = string.Empty;
                if (press is not null && !_operations.Contains(press))
                {
                    errorsDescr += Constant.operationInvalid + "<br>";
                }

                if (errorsDescr.Length > 0)
                {
                    throw new(errorsDescr);
                }

                ViewBag.press = press;
                ViewBag.x = x;
                ViewBag.y = y;
                ViewBag.z = z;
            }
            catch (Exception ex)
            {
                float? z = 0;
                ViewBag.Error = ex.Message;
                ViewBag.z = z;
            }
            finally
            {
                ViewBag.x = x;
                ViewBag.y = y;
            }

            return View();
        }
        [HttpPost]
        public ActionResult Sum(string? press, float? x, float? y)
        {
            float? z = 0;
            string errorsDescr = string.Empty;
            try
            {
                if (press is null || !_operations.Contains(press))
                {
                    errorsDescr +=  Constant.strIsNotSymbolPlusError + "<br>";
                }
                if (x is null)
                {
                    x = 0;
                    errorsDescr += Constant.xIsNotFloatError + "<br>";
                }
                if (y is null)
                {
                    y = 0;
                    errorsDescr += Constant.yIsNotFloatError + "<br>";
                }
                if(errorsDescr.Length > 0) 
                {
                    throw new(errorsDescr);
                }

                ViewBag.z = x + y;
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.z = z;
            }
            finally
            {
                ViewBag.press = press;
                ViewBag.x = x;
                ViewBag.y = y;
            }
            return View("Index");
        }
        [HttpPost]
        public ActionResult Sub(string? press, float? x, float? y)
        {
            float? z = 0;
            string errorsDescr = string.Empty;
            try
            {
                if (press is null || !_operations.Contains(press))
                {
                    errorsDescr += Constant.strIsNotSymbolPlusError + "<br>";
                }

                if (x is null)
                {
                    x = 0;
                    errorsDescr += Constant.xIsNotFloatError + "<br>";
                }
                if (y is null)
                {
                    y = 0;
                    errorsDescr += Constant.yIsNotFloatError + "<br>";
                }
                if (errorsDescr.Length > 0)
                {
                    throw new(errorsDescr);
                }

                ViewBag.z = x - y;
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.z = z;
            }
            finally
            {
                ViewBag.press = press;
                ViewBag.x = x;
                ViewBag.y = y;
            }
            return View("Index");
        }
        [HttpPost]
        public ActionResult Mul(string? press, float? x, float? y)
        {
            float? z = 0;
            string errorsDescr = string.Empty;
            try
            {
                if (press is null || !_operations.Contains(press))
                {
                    errorsDescr += Constant.strIsNotSymbolPlusError + "<br>";
                }
                if (x is null)
                {
                    x = 0;
                    errorsDescr += Constant.xIsNotFloatError + "<br>";
                }
                if (y is null)
                {
                    y = 0;
                    errorsDescr += Constant.yIsNotFloatError + "<br>";
                }
                if (errorsDescr.Length > 0)
                {
                    throw new(errorsDescr);
                }

                ViewBag.z = x * y;
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.z = z;
            }
            finally
            {
                ViewBag.press = press;
                ViewBag.x = x;
                ViewBag.y = y;

                //ViewBag.z == ViewData["z"];
            }
            return View("Index");
        }
        [HttpPost]
        public ActionResult Div(string? press, float? x, float? y)
        {
            float? z = 0;
            string errorsDescr = string.Empty;
            try
            {
                if (press is null || !_operations.Contains(press))
                {
                    errorsDescr += Constant.strIsNotSymbolPlusError + "<br>";
                }
                if (x is null)
                {
                    x = 0;
                    errorsDescr += Constant.xIsNotFloatError + "<br>";
                }
                if (y is null)
                {
                    y = 0;
                    errorsDescr += Constant.yIsNotFloatError + "<br>";
                    throw new(errorsDescr);
                }

                if (y == 0)
                {
                    y = 0;
                    errorsDescr += Constant.divisionByZeroError + "<br>";
                }
                if (errorsDescr.Length > 0)
                {
                    throw new(errorsDescr);
                }

                ViewBag.z = x / y;
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.z = z;
            }
            finally
            {
                ViewBag.press = press;
                ViewBag.x = x;
                ViewBag.y = y;
            }
            return View("Index");
        }


    }
}
