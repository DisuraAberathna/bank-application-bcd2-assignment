<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/5/2025
  Time: 12:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank</title>
    <link rel="stylesheet" href="./public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-50 text-gray-900 max-h-screen">
<header class="bg-white shadow-md fixed w-full">
    <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-[#16A34A]">National Bank</h1>
        <nav>
            <a href="${pageContext.request.contextPath}/auth/login.jsp"
               class="text-[#16A34A] hover:text-[#28914e] font-medium mx-2 hover:underline underline-offset-8">Login</a>
            <a href="${pageContext.request.contextPath}/auth/register.jsp"
               class="text-[#16A34A] hover:text-[#28914e] font-medium mx-2 hover:underline underline-offset-8">Register</a>
        </nav>
    </div>
</header>

<section class="text-center bg-gradient-to-br from-green-100 to-white h-screen place-content-center">
    <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-4xl font-extrabold text-[#16A34A] mb-4">Welcome to National Bank</h2>
        <p class="text-lg text-gray-600 mb-6">Secure, Reliable, and Fast Banking Experience.</p>
        <div class="space-x-4">
            <a href="${pageContext.request.contextPath}/auth/login.jsp"
               class="px-6 py-3 bg-[#16A34A] text-white rounded-lg hover:bg-[#28914e] transition">Login</a>
            <a href="${pageContext.request.contextPath}/auth/register.jsp"
               class="px-6 py-3 bg-slate-50 border border-[#16A34A] text-[#16A34A] rounded-lg hover:bg-white transition">Register</a>
        </div>
    </div>
</section>
</body>
</html>
