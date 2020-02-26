using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DentalManagement.Models
{
    public class Patient
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Surname { get; set; }
        public string DateOfBirth { get; set; }
        public string Email { get; set; }
        public string ContactNo { get; set; }
        public string Status { get; set; }
    }
}