<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/20/2025
  Time: 12:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank | Unauthorized</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#1f1c2c] to-[#928dab] text-white font-sans">
<div class="text-center max-w-md bg-black bg-opacity-20 p-10 rounded-2xl shadow-2xl">
    <h1 class="text-7xl font-bold text-[#ff6f61]">401</h1>
    <h2 class="text-2xl font-semibold mt-4 mb-4">Unauthorized</h2>
    <p class="text-lg leading-relaxed mb-6">
        You don't have permission to access this page.<br>
        Please login with the proper credentials.
    </p>
    <a href="${pageContext.request.contextPath}/auth/login.jsp"
       class="inline-block px-6 py-3 bg-[#ff6f61] rounded-full text-white hover:bg-[#e0554d] transition">
        Back to Login
    </a>
</div>
</body>
</html>
