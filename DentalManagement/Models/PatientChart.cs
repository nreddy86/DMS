using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DentalManagement.Models
{
    public class PatientChart
    {
        public string CreatedOn { get; set; }
        public int Tooth { get; set; }
        public string Surface { get; set; }
        public string Description { get; set; }
        public double Amount { get; set; }
        public string Status { get; set; }
        public string Action { get; set; }
        public string Dentist { get; set; }
        public int PatientId { get; set; }
    }
}