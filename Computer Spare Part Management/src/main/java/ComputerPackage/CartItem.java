package ComputerPackage;

public class CartItem {
    private int id;
    private String name;
    private double price;
    private String image;
    private int quantity;

    public CartItem(int id, String name, double price, String image, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.quantity = quantity;
    }

    // Getters and setters
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getImage() { return image; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
