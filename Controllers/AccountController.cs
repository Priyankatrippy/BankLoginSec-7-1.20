using Microsoft.AspNetCore.Mvc;

namespace BankLoginPage1._20.Controllers
{
    public class AccountController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(string username, string password)
        {
         
            return RedirectToAction("Index", "Home"); 
        }

        public IActionResult Logout()
        {
            
            return RedirectToAction("Login");
        }
    }
}
