using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using LibraryManagement.Forms;
using LibraryManage;
using FormLoaiDocGia;

namespace LibraryManagementTest
{
    [TestClass]
    public class ManageReaderTest
    {
        [TestMethod]
        public void AddReader1()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = true;
            actual = form1.SaveReaderInfo(
                "Nguyễn Văn A",
                "Giảng viên", 
                "30/06/2002", 
                "Thủ Đức", 
                "20521554@gm.uit.edu.vn", 
                "12/10/2023");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void AddReader2()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.SaveReaderInfo(
                "",
                "Giảng viên",
                "30/06/2002",
                "Thủ Đức",
                "20521554@gm.uit.edu.vn",
                "12/10/2023");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void AddReader3()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.SaveReaderInfo(
                "Nguyễn Văn B",
                "Giảng viên",
                "30/06/2002",
                "Thủ Đức",
                "abc@xyz",
                "12/10/2023");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void UpdateReader1()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = true;
            actual = form1.UpdateReader(
                "Nguyễn Trung", 
                "Hồ Chí Minh",
                "Sinh Viên",
                "20520831@gm.uit.edu.vn");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void UpdateReader2()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.UpdateReader(
                "Nguyễn Trung",
                "",
                "Sinh Viên",
                "20520831@gm.uit.edu.vn");


            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void UpdateReader3()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.UpdateReader(
                "Nguyễn Trung",
                "Thủ Đức",
                "Sinh Viên",
                "abc@gmail");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void RemoveReader1()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = true;
            actual = form1.RemoveReader("DG020");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void RemoveReader2()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = false;
            actual = form1.RemoveReader("DG001");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void PrintReaderCard()
        {
            bool expect, actual;
            Form1 form1 = new Form1();

            expect = true;
            actual = form1.PrintReaderCard();

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void AddNewReaderType1()
        {
            //Thêm mới loại độc giả
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = true;
            actual = form1.AddNewReaderType("Trường Ngoài");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void AddNewReaderType2()
        {
            //Thêm loại độc giả đã có
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = false;
            actual = form1.AddNewReaderType("Sinh Viên");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void AddNewReaderType3()
        { 
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = false;
            actual = form1.AddNewReaderType("");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void UpdateReaderType1()
        {
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = true;
            actual = form1.UpdateReaderType("MLDG005", "Mã độc giả mới");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void UpdateReaderType2()
        {
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = false;
            actual = form1.UpdateReaderType("MLDG001", "Sinh Viên");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void UpdateReaderType3()
        {
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = false;
            actual = form1.UpdateReaderType("MLDG001", "");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void RemoveReaderType1()
        {
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = true;
            actual = form1.RemoveReaderType("MLDG005");

            Assert.AreEqual(expect, actual);
        }

        [TestMethod]
        public void RemoveReaderType2()
        {
            bool expect, actual;
            FormLoaiDocGia.FormLoaiDocGia form1 = new FormLoaiDocGia.FormLoaiDocGia();

            expect = false;
            actual = form1.RemoveReaderType("MLDG001");

            Assert.AreEqual(expect, actual);
        }
    }
}
