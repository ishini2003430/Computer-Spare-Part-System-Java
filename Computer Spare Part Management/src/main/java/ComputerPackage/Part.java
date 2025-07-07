package ComputerPackage;

public class Part {
    private int id;
    private String partName;
    private String category;
    private String supplier;
    private int quantity;
    private int minStock;
    private double price;

    // Constructor without ID (for INSERT)
    public Part(String partName, String category, String supplier, int quantity, int minStock, double price) {
        this.partName = partName;
        this.category = category;
        this.supplier = supplier;
        this.quantity = quantity;
        this.minStock = minStock;
        this.price = price;
    }

    // Constructor with ID (for UPDATE / FETCH)
    public Part(int id, String partName, String category, String supplier, int quantity, int minStock, double price) {
        this.id = id;
        this.partName = partName;
        this.category = category;
        this.supplier = supplier;
        this.quantity = quantity;
        this.minStock = minStock;
        this.price = price;
    }

    // Getters
    public int getId() { return id; }
    public String getPartName() { return partName; }
    public String getCategory() { return category; }
    public String getSupplier() { return supplier; }
    public int getQuantity() { return quantity; }
    public int getMinStock() { return minStock; }
    public double getPrice() { return price; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setPartName(String partName) { this.partName = partName; }
    public void setCategory(String category) { this.category = category; }
    public void setSupplier(String supplier) { this.supplier = supplier; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setMinStock(int minStock) { this.minStock = minStock; }
    public void setPrice(double price) { this.price = price; }
}
