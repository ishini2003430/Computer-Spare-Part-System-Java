<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Part - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #ffffff;
            padding: 2.5rem;
            width: 450px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            font-size: 1.6rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #374151;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px 14px;
            font-size: 1rem;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background-color: #f9fafb;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #3b82f6;
            background-color: #fff;
        }

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        .button-row {
            display: flex;
            justify-content: space-between;
            margin-top: 1.8rem;
        }

        .btn {
            padding: 10px 18px;
            font-size: 1rem;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-cancel {
            background-color: #e5e7eb;
            color: #1f2937;
        }

        .btn-cancel:hover {
            background-color: #d1d5db;
        }

        .btn-add {
            background-color: #111827;
            color: white;
        }

        .btn-add:hover {
            background-color: #000;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Part</h2>
    <form action="AddPartServlet" method="post">
        <div class="form-group">
            <label for="partName">Part Name</label>
            <input type="text" id="partName" name="partName" required>
        </div>

        <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="">Select a category</option>
                <option>Laptops</option>
                <option>Laptop Accessories</option>
                <option>Processors</option>
                <option>Graphics Cards</option>
                <option>Memory</option>
                <option>Storage</option>
                <option>Motherboards</option>
                <option>Power Supply</option>
                <option>CCTV Camera</option>
                <option>Camera Accessories</option>
                <option>Gift Vouchers</option>
                <option>Others</option>
            </select>
        </div>

        <div class="form-group">
            <label for="supplier">Supplier</label>
            <input type="text" id="supplier" name="supplier" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" min="0" value="0" required>
            </div>
            <div class="form-group">
                <label for="minStock">Min Stock</label>
                <input type="number" id="minStock" name="minStock" min="0" value="0" required>
            </div>
        </div>

        <div class="form-group">
            <label for="price">Price ($)</label>
            <input type="number" id="price" name="price" step="0.01" min="0" value="0" required>
        </div>

        <div class="button-row">
            <button type="reset" class="btn btn-cancel">Cancel</button>
            <button type="submit" class="btn btn-add">Add Part</button>
        </div>
    </form>
</div>

</body>
</html>
