using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using LibraryManagement;
using LibraryManagement.Forms;
using LibraryManage;

namespace LibraryManagementTest
{
    [TestClass]
    public class DOBValidationTest
    {
        
        [TestMethod]
        public void DOBValidation1()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = true;
            actual = form1.DOBValidation("30/07/2002");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void DOBValidation2()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.DOBValidation("18/8/2022");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void DOBValidation3()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = true;
            actual = form1.DOBValidation("1/8/2004");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void DOBValidation4()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.DOBValidation("31/04/2003");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void DOBValidation5()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.DOBValidation("29/02/2015");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void DOBValidation6()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.DOBValidation("29/2/2018");

            Assert.AreEqual(expect, actual);
        }
    }
}
