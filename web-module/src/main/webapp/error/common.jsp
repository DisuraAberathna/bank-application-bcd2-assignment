<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/5/2025
  Time: 8:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank | Error</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<main class="w-full h-screen flex justify-center items-center bg-neutral-100">
    <div class="h-full flex justify-center items-center">
        <div class="bg-red-100 border-2 border-red-400 text-red-700 px-6 py-5 rounded-lg shadow-lg max-w-lg w-full mx-4 flex flex-col">
            <span class="text-lg font-bold">Oops! Something went wrong.</span>
            <span class="font-medium text-[15px]">Error Code: ${requestScope['jakarta.servlet.error.status_code']}</span>
            <span class="font-medium text-[15px]">${requestScope['jakarta.servlet.error.message']}</span>
        </div>
    </div>
</main>
</body>
</html>
