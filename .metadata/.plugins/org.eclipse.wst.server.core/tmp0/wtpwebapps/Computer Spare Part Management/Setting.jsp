<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Load theme from session or default to "light"
    String theme = (String) session.getAttribute("theme");
    if (theme == null) theme = "light";

    // Load notification prefs from session (Boolean)
    Boolean emailNotifications = (Boolean) session.getAttribute("emailNotifications");
    Boolean smsNotifications = (Boolean) session.getAttribute("smsNotifications");
    Boolean pushNotifications = (Boolean) session.getAttribute("pushNotifications");
    // Default to false if null
    emailNotifications = (emailNotifications != null) ? emailNotifications : false;
    smsNotifications = (smsNotifications != null) ? smsNotifications : false;
    pushNotifications = (pushNotifications != null) ? pushNotifications : false;

    // Load username and email from session
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Settings - TechParts</title>
    <style>
        /* Reset and base */
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            height: 100vh;
            overflow: hidden;
            background-color: #f3f4f6;
            color: #374151;
            transition: background-color 0.3s, color 0.3s;
        }

        body.dark {
            background-color: #121212;
            color: #e0e0e0;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            background-color: #111827; /* dark slate */
            color: white;
            padding: 2rem 1rem;
            display: flex;
            flex-direction: column;
            transition: background-color 0.3s;
        }

        body.dark .sidebar {
            background-color: #1f2937; /* darker slate */
        }

        .sidebar h2 {
            margin: 0 0 2rem;
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 1px;
        }
        .nav-link {
            color: #d1d5db;
            padding: 12px 18px;
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 0.7rem;
            font-weight: 600;
            transition: background-color 0.3s, color 0.3s;
        }
        .nav-link:hover {
            background-color: #1e40af;
            color: white;
        }
        .nav-link.active {
            background-color: #2563eb;
            color: white;
        }
        .logout-btn {
            margin-top: auto;
            padding: 12px 18px;
            background-color: #ef4444;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: block;
            user-select: none;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: #b91c1c;
        }

        /* Main content */
        .main {
            flex-grow: 1;
            padding: 3rem 4rem;
            overflow-y: auto;
            transition: color 0.3s;
        }

        body.dark .main {
            color: #d1d5db;
        }

        h1 {
            margin-top: 0;
            font-weight: 700;
            font-size: 2rem;
            color: #1f2937;
            margin-bottom: 1.5rem;
            transition: color 0.3s;
        }

        body.dark h1 {
            color: #f3f4f6;
        }

        /* Section styling */
        .section {
            background: white;
            padding: 2rem 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            margin-bottom: 2.5rem;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        body.dark .section {
            background: #1e293b;
            box-shadow: 0 4px 16px rgba(0,0,0,0.6);
        }

        .section h2 {
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #111827;
            border-bottom: 2px solid #2563eb;
            padding-bottom: 0.3rem;
            transition: color 0.3s, border-color 0.3s;
        }

        body.dark .section h2 {
            color: #d1d5db;
            border-color: #3b82f6;
        }

        label {
            display: block;
            font-weight: 600;
            color: #374151;
            margin-bottom: 6px;
            margin-top: 20px;
            transition: color 0.3s;
        }

        body.dark label {
            color: #d1d5db;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px 12px;
            border: 1.8px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.25s, background-color 0.3s, color 0.3s;
            background-color: white;
            color: #111827;
        }

        body.dark input[type="text"],
        body.dark input[type="email"],
        body.dark input[type="password"],
        body.dark select {
            background-color: #334155;
            color: #e0e0e0;
            border-color: #475569;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        select:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 5px #2563eb;
        }

        /* Checkbox group */
        .checkbox-group {
            margin-top: 10px;
        }
        .checkbox-group label {
            display: inline-block;
            font-weight: normal;
            margin-right: 20px;
            color: #4b5563;
            cursor: pointer;
            transition: color 0.3s;
        }
        body.dark .checkbox-group label {
            color: #9ca3af;
        }
        .checkbox-group input[type="checkbox"] {
            margin-right: 6px;
            cursor: pointer;
        }

        button[type="submit"] {
            margin-top: 2rem;
            background-color: #2563eb;
            color: white;
            padding: 12px 20px;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            font-size: 1.1rem;
        }
        button[type="submit"]:hover {
            background-color: #1e40af;
        }

        /* Danger button */
        .btn-danger {
            background-color: #ef4444;
            margin-top: 1rem;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 700;
            color: white;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
        }

        /* Helper text */
        .helper-text {
            font-size: 0.875rem;
            color: #6b7280;
            margin-top: 4px;
            transition: color 0.3s;
        }

        body.dark .helper-text {
            color: #9ca3af;
        }

        /* Responsive */
        @media (max-width: 720px) {
            body {
                flex-direction: column;
                height: auto;
            }
            .sidebar {
                width: 100%;
                flex-direction: row;
                padding: 1rem;
                overflow-x: auto;
            }
            .sidebar h2 {
                flex: 1 0 auto;
                margin-bottom: 0;
            }
            .nav-link {
                margin: 0 10px 0 0;
                padding: 8px 12px;
            }
            .logout-btn {
                margin: 0 0 0 auto;
                padding: 8px 12px;
            }
            .main {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body class="<%= theme %>">
    <div class="sidebar">
        <h2>TechParts</h2>
        <a href="ManagerDashboard.jsp" class="nav-link">Dashboard</a>
        <a href="Categories.jsp" class="nav-link">Categories</a>
        <a href="SupplierDetails.jsp" class="nav-link">Suppliers</a>
        <a href="ViewOrderDetails.jsp" class="nav-link">Orders</a>
        <a href="SalesDetails.jsp" class="nav-link">Sales</a>
        <a href="Setting.jsp" class="nav-link active">Settings</a>
        <a href="Login.jsp" class="logout-btn">Logout</a>
    </div>

    <div class="main">
        <h1>Settings</h1>

        <!-- Profile Info -->
        <section class="section">
            <h2>Profile Information</h2>
            <form action="UpdateSettingsServlet" method="post">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" value="<%= username != null ? username : "" %>" required />

                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" required />

                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password to save changes" />

                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Leave blank to keep current password" />

                <button type="submit">Update Profile</button>
            </form>
        </section>

        <!-- Notifications -->
        <section class="section">
            <h2>Notification Preferences</h2>
            <form action="UpdateNotificationsServlet" method="post">
                <div class="checkbox-group">
                    <label>
                        <input type="checkbox" name="emailNotifications" <%= emailNotifications ? "checked" : "" %> />
                        Email Notifications
                    </label>
                    <label>
                        <input type="checkbox" name="smsNotifications" <%= smsNotifications ? "checked" : "" %> />
                        SMS Notifications
                    </label>
                    <label>
                        <input type="checkbox" name="pushNotifications" <%= pushNotifications ? "checked" : "" %> />
                        Push Notifications
                    </label>
                </div>
                <button type="submit">Update Notifications</button>
            </form>
        </section>

        <!-- Appearance -->
        <section class="section">
            <h2>Appearance</h2>
            <form action="UpdateAppearanceServlet" method="post">
                <label for="theme">Select Theme</label>
                <select id="theme" name="theme">
                    <option value="light" <%= "light".equals(theme) ? "selected" : "" %>>Light</option>
                    <option value="dark" <%= "dark".equals(theme) ? "selected" : "" %>>Dark</option>
                </select>
                <button type="submit">Update Appearance</button>
            </form>
        </section>

        <!-- Danger Zone -->
        <section class="section">
            <h2>Danger Zone</h2>
            <p class="helper-text">Deleting your account is irreversible. Please proceed with caution.</p>
            <form action="DeleteAccountServlet" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.')">
                <button type="submit" class="btn-danger">Delete Account</button>
            </form>
        </section>
    </div>
</body>
</html>
