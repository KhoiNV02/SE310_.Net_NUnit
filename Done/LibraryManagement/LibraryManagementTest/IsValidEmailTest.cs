using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using LibraryManagement;
using LibraryManagement.Forms;
using LibraryManage;

namespace LibraryManagementTest
{
    [TestClass]
    public class IsValidEmailTest
    {
        [TestMethod]
        public void IsValidEmail1()
        {
            bool expect, actual;
            Form1 form1 = new Form1();
            
            expect = true;
            actual = form1.checkIsMail("khoingvan123@gmail.com");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void IsValidEmail2()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.checkIsMail("ngtrung09@gmial.com");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void IsValidEmail3()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = "" != "";

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void IsValidEmail4()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.checkIsMail("aaa");

            Assert.AreEqual(expect, actual);
        }
    }
}
