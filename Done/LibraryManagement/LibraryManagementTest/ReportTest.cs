using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using DemoDesign;

namespace LibraryManagementTest
{
    [TestClass]
    public class ReportTest
    {
        [TestMethod]
        public void CreateReport1()
        {
            bool expect, actual;
            Report form = new Report();

            expect = true;
            actual = form.CreateReportFile(12,2023,"MyReport");

            Assert.AreEqual(expect, actual);
        }
    }
}
