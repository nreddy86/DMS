using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DentalManagement.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        public ActionResult Index()
        {
            Session["IsAuthenticated"] = false;
            Session["UserName"] = null;
            return View();
        }

        // POST: Account
        [HttpPost]
        public ActionResult LogOn(string inputEmail, string inputPassword)
        {
            Session["IsAuthenticated"] = true;
            Session["UserName"] = inputEmail;
            return RedirectToAction("Patients", "Home");
        }

        public ActionResult LogOut()
        {
            Session["IsAuthenticated"] = false;
            Session["UserName"] = null;
            return RedirectToAction("Index", "Account");
        }
    }
}