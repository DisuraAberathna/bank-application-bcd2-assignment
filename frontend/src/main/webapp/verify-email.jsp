<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/7/2025
  Time: 12:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Bank App | Verify Email</title>
    <link rel="stylesheet" href="./css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<main class="w-full h-screen flex justify-center items-center bg-neutral-100">
    <div class="min-w-lg lg:max-w-xl bg-white drop-shadow-xl rounded-xl px-6 py-8 space-y-3">

        <h2 class="font-semibold text-2xl mb-1">Verify Your Email Address</h2>
        <p>
            We've sent a verification link to your email. Please check your inbox and click the link to verify your
            account.
            If you don’t see the email, check your spam or junk folder.
        </p>
        <c:if test="${empty pageContext.request.getAttribute('verified')}">
            <div class="bg-yellow-100 border-2 border-yellow-400 text-yellow-700 px-4 py-3 rounded-lg relative mt-3">
                <span class="max-w-sm">Please verify your email address.</span>
            </div>
        </c:if>
        <div class="pt-5 text-center">
            <a href=""
               class="bg-[#16A34A] text-white font-medium py-2 px-20 rounded-md hover:bg-[#28914e] cursor-pointer">Continue</a>
        </div>
    </div>
</main>
</body>
</html>
