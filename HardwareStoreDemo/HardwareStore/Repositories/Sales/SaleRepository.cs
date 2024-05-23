using HardwareStore.Data;
using HardwareStore.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace HardwareStore.Repositories.Sales
{
    public class SaleRepository : ISaleRepository
    {
        private readonly ISqlDataAccess _dataAccess;

        public SaleRepository(ISqlDataAccess dataAccess)
        {
            _dataAccess = dataAccess;
        }

        public async Task<IEnumerable<Sale>> GetAllAsync()
        {
            return await _dataAccess.GetDataAsync<Sale, dynamic>(
                "dbo.spSale_GetAll",
                new { }
                );
        }

        public async Task<IEnumerable<Product>> GetAllProductsAsync()
        {
            return await _dataAccess.GetDataAsync<Product, dynamic>(
                "dbo.spProduct_GetAll",
                new { }
                );
        }

        public async Task<Product?> GetProductByIdAsync(int id)
        {
            try
            {
                var products = await _dataAccess.GetDataAsync<Product, dynamic>(
                    "dbo.spProduct_GetInfoForSaleById",
                    new { ProductID = id }
                );

                return products.FirstOrDefault();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw; 
            }
        }

        public async Task<IEnumerable<SaleDetails?>> GetSaleDetailsByIdAsync(int id)
        {
            return await _dataAccess.GetDataAsync<SaleDetails, dynamic>(
                "dbo.spSalesDetail_GetById",
                new { SaleId = id }
                );
        }



        public async Task<IEnumerable<Client>> GetAllClientsAsync()
        {
            return await _dataAccess.GetDataAsync<Client, dynamic>(
                "dbo.spClient_GetAll",
                new { }
                );
        }

        public async Task<IEnumerable<Employee>> GetAllEmployeesAsync()
        {
            return await _dataAccess.GetDataAsync<Employee, dynamic>(
                "dbo.spEmployee_GetAll",
                new { }
                );
        }



        public async Task<Sale?> GetSaleByIdAsync(int id)
        {
            var sale = await _dataAccess.GetDataAsync<Sale, dynamic>(
                "dbo.spSale_GetById",
                new { SaleId = id }
                );

            return sale.FirstOrDefault();
        }

        public async Task EditAsync(Sale sale)
        {
            await _dataAccess.SaveDataAsync(
                "dbo.spSale_Update",
                sale
                );
        }

        public async Task DeleteAsync(int id)
        {
            await _dataAccess.SaveDataAsync(
                "dbo.spSale_Delete",
                new { Id = id }
                );
        }

        public async Task AddAsync(Sale sale)
        {
            // Guardar la venta y obtener el ID generado
            var saleID = await _dataAccess.SaveDataWithReturnAsync(
                "dbo.spSale_Insert",
                new { sale.ClientID, sale.EmployeeID });

            foreach (var saleDetail in sale.SaleDetails)
            {
                saleDetail.SaleID = saleID; // Asignar el SaleID obtenido
                await _dataAccess.SaveDataAsync("dbo.spSalesDetail_Insert", 
                    new { saleDetail.SaleID, saleDetail.ProductID, saleDetail.Quantity});
            }
        }

    }
}
