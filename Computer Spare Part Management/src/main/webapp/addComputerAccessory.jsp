<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Add Computer Accessory</title>
  <style>
    body {
      font-family: Arial;
      background-color: #f4f4f4;
    }

    form {
      background: #fff;
      padding: 20px;
      margin: 50px auto;
      width: 500px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    label {
      display: block;
      margin-top: 10px;
      font-weight: bold;
    }

    input, select, textarea {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    button {
      margin-top: 20px;
      padding: 10px 20px;
      background: #111827;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    button:hover {
      background: #1e293b;
    }

    a.back-btn {
      display: inline-block;
      margin-bottom: 15px;
      padding: 8px 14px;
      background-color: #6b7280;
      color: white;
      text-decoration: none;
      border-radius: 6px;
      font-size: 14px;
    }

    a.back-btn:hover {
      background-color: #4b5563;
    }
  </style>
</head>
<body>
  <a href="ManagerDashboard.jsp" class="back-btn">Back</a>
  <form action="AddAccessoryServlet" method="post">
    <h2>Add New Computer Accessory</h2>

    <label for="name">Accessory Name</label>
    <input type="text" name="name" id="name" placeholder="e.g. GAMDIAS GC6 Mid-Tower" required>

    <label for="category">Category</label>
    <select name="category" id="category" required>
      <option value="Casing & Power Supply">Casing & Power Supply</option>
      <option value="Mother Board">Mother Board</option>
      <option value="Memory/RAM">Memory/RAM</option>
      <option value="Graphics Cards">Graphics Cards</option>
      <option value="Processor">Processor</option>
      <option value="Cooling">Cooling</option>
      <option value="Mouse">Mouse</option>
      <option value="Key Board">Key Board</option>
      <option value="Flash Drive & SD Card">Flash Drive & SD Card</option>
      <option value="Web Camera">Web Camera</option>
      <option value="Toolkit">Toolkit</option>
      <option value="Other">Other</option>
    </select>

    <label for="item_code">Item Code</label>
    <input type="text" name="item_code" id="item_code" required>

    <label for="price">Price (Rs.)</label>
    <input type="number" name="price" id="price" step="0.01" required>

    <label for="cash_price">Cash Price (Rs.)</label>
    <input type="number" name="cash_price" id="cash_price" step="0.01" required>

    <label for="stock_status">Stock Status</label>
    <select name="stock_status" id="stock_status" required>
      <option value="In Stock">In Stock</option>
      <option value="Low Stock">Low Stock</option>
      <option value="Out of Stock">Out of Stock</option>
    </select>

    <label for="image_url">Image URL</label>
    <input type="text" name="image_url" id="image_url" placeholder="e.g. images/gc6.png" required>

    <label for="description">Description</label>
    <textarea name="description" id="description" rows="4" placeholder="Enter accessory description..."></textarea>

    <button type="submit">Add Accessory</button>
  </form>
</body>
</html>
