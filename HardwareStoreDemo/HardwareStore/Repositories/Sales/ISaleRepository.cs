using HardwareStore.Models;

namespace HardwareStore.Repositories.Sales
{
    public interface ISaleRepository
    {
        Task AddAsync(Sale sale);
        Task DeleteAsync(int id);
        Task EditAsync(Sale sale);
        Task<IEnumerable<Sale>> GetAllAsync();
        Task<IEnumerable<Employee>> GetAllEmployeesAsync();
        Task<IEnumerable<Product>> GetAllProductsAsync();
        Task<IEnumerable<Client>> GetAllClientsAsync();
        Task<Sale?> GetSaleByIdAsync(int id);
        Task<Product?> GetProductByIdAsync(int id);
        Task<IEnumerable<SaleDetails?>> GetSaleDetailsByIdAsync(int id);
    }
}