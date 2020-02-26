using DentalManagement.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DentalManagement.Controllers
{
    public class HomeController : Controller
    {
        readonly string connStr = ConfigurationManager.ConnectionStrings["DCMS"].ConnectionString;

        public ActionResult Index(int Id)
        {
            ChartVm chartVm = new ChartVm();
            var patient = GetPatient(Id);
            chartVm.PatientId = patient.Id;

            chartVm.PatientName = patient.FirstName + " " + patient.Surname;
            return View(chartVm);
        }

        public ActionResult Patients()
        {
            DataTable dataTable = new DataTable();
            var con = new SqlConnection(connStr);
            SqlCommand cm = new SqlCommand("Get_Patients", con);
            cm.CommandType = System.Data.CommandType.StoredProcedure;
            // Opening Connection  
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cm);
            // this will query your database and return the result to your datatable
            da.Fill(dataTable);
            con.Close();
            da.Dispose();

            PatientsVm patientsVm = new PatientsVm();
            patientsVm.patients = new List<Patient>();

            foreach (DataRow item in dataTable.Rows)
            {
                patientsVm.patients.Add(new Patient
                {
                    Id = Convert.ToInt32(item["Id"]),
                    FirstName = Convert.ToString(item["FirstName"]),
                    LastName = Convert.ToString(item["LastName"]),
                    Surname = Convert.ToString(item["Surname"]),
                    DateOfBirth = Convert.ToString(item["DateOfBirth"]),
                    Email = Convert.ToString(item["Email"]),
                    ContactNo = Convert.ToString(item["ContactNo"]),
                    Status = Convert.ToString(item["Status"])
                });
            }
            return View(patientsVm);
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        [HttpPost]
        public ActionResult SaveChart(string payload, string patientId)
        {
            var model = JsonConvert.DeserializeObject<List<PatientChart>>(payload);

            foreach (var item in model)
            {

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cm = new SqlCommand("Save_PatientProcedure", con);
                    cm.CommandType = System.Data.CommandType.StoredProcedure;
                    cm.Parameters.AddWithValue("@Tooth", item.Tooth);
                    cm.Parameters.AddWithValue("@Description", item.Description);
                    cm.Parameters.AddWithValue("@Surface", item.Surface);
                    cm.Parameters.AddWithValue("@Status", item.Status);
                    cm.Parameters.AddWithValue("@Dentist", Session["UserName"] != null ? (string)Session["UserName"] : string.Empty);
                    cm.Parameters.AddWithValue("@CreatedOn", DateTime.Now);
                    cm.Parameters.AddWithValue("@Amount", item.Amount);
                    cm.Parameters.AddWithValue("@Action", string.Empty);
                    cm.Parameters.AddWithValue("@PatientId", Convert.ToInt32(patientId));
                    // Opening Connection  
                    con.Open();
                    cm.ExecuteNonQuery();
                }
            }

            return View();
        }

        public ActionResult Treatments()
        {
            DataTable dataTable = new DataTable();
            var con = new SqlConnection(connStr);
            SqlCommand cm = new SqlCommand("Get_Treatments", con);
            cm.CommandType = System.Data.CommandType.StoredProcedure;
            // Opening Connection  
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cm);
            // this will query your database and return the result to your datatable
            da.Fill(dataTable);
            con.Close();
            da.Dispose();

            ProcedureVm procedureVm = new ProcedureVm();
            procedureVm.procedures = new List<Procedure>();

            foreach (DataRow item in dataTable.Rows)
            {
                procedureVm.procedures.Add(new Procedure
                {
                    Id = Convert.ToInt32(item["Id"]),
                    Tooth = Convert.ToInt32(item["Tooth"]),
                    Description = Convert.ToString(item["Description"]),
                    Surface = Convert.ToString(item["Surface"]),
                    Status = Convert.ToString(item["Status"]),
                    Dentist = Convert.ToString(item["Dentist"]),
                    CreatedOn = Convert.ToDateTime(item["CreatedOn"]).ToString("MM/dd/yyyy h:mm tt"),
                    Amount = Convert.ToDouble(item["Amount"]),
                    PatientName = Convert.ToString(item["PatientName"])
                });
            }

            return View(procedureVm);
        }

        private Patient GetPatient(int id)
        {
            DataTable dataTable = new DataTable();
            var con = new SqlConnection(connStr);
            SqlCommand cm = new SqlCommand("Get_PatientDetails", con);
            cm.CommandType = System.Data.CommandType.StoredProcedure;
            cm.Parameters.AddWithValue("@PatientId", id);
            // Opening Connection  
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cm);
            // this will query your database and return the result to your datatable
            da.Fill(dataTable);
            con.Close();
            da.Dispose();

            Patient patient = null;
            foreach (DataRow item in dataTable.Rows)
            {
                patient = new Patient
                {
                    Id = Convert.ToInt32(item["Id"]),
                    FirstName = Convert.ToString(item["FirstName"]),
                    LastName = Convert.ToString(item["LastName"]),
                    Surname = Convert.ToString(item["Surname"]),
                    DateOfBirth = Convert.ToString(item["DateOfBirth"]),
                    Email = Convert.ToString(item["Email"]),
                    ContactNo = Convert.ToString(item["ContactNo"]),
                    Status = Convert.ToString(item["Status"])
                };
            }

            return patient;
        }
    }
}