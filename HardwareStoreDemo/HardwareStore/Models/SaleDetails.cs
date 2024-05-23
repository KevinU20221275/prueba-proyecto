namespace HardwareStore.Models
{
    public class SaleDetails
    {
        public int Id { get; set; }

        public int SaleID { get; set; }

        public int ProductID { get; set; }

        public string ProductName { get; set; }

        public int Quantity { get; set; }

        public decimal UnitPrice { get; set; }

        public decimal DetailTotal {  get; set; }
    }
}
