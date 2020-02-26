using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DentalManagement.Models
{
    public class Procedure
    {
        public int Id { get; set; }
        public int Tooth { get; set; }
        public string Description { get; set; }
        public string Surface { get; set; }
        public string Status { get; set; }
        public string Dentist { get; set; }
        public string CreatedOn { get; set; }
        public string PatientName { get; set; }
        public double Amount { get; set; }
    }
}
