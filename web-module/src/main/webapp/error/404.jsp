<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/20/2025
  Time: 12:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank | 404</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#0f2027] via-[#203a43] to-[#2c5364] text-white font-sans">
<div class="text-center max-w-md p-10 bg-white bg-opacity-5 rounded-2xl shadow-2xl">
    <h1 class="text-7xl font-bold text-[#f39c12]">404</h1>
    <h2 class="text-2xl font-semibold mt-2 mb-5">Page Not Found</h2>
    <p class="text-lg leading-relaxed mb-6">
        The page you’re looking for might have been removed,<br>
        had its name changed, or is temporarily unavailable.
    </p>
    <a href="${pageContext.request.contextPath}/auth/login.jsp"
       class="inline-block px-6 py-3 bg-[#f39c12] rounded-full text-white hover:bg-[#d68910] transition">
        Go to Login
    </a>
</div>
</body>
</html>
