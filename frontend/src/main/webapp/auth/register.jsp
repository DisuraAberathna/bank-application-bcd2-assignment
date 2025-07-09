<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/5/2025
  Time: 4:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Bank App | Register</title>
    <link rel="stylesheet" href="../css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<main class="w-full h-screen flex justify-center items-center bg-neutral-100">
    <form action="${pageContext.request.contextPath}/auth/register" method="post"
          class="min-w-sm lg:min-w-md bg-white drop-shadow-xl rounded-xl px-6 py-8 space-y-3">
        <div>
            <h2 class="font-semibold text-2xl mb-1">Banking App Registration</h2>
            <h6>Welcome back!</h6>
        </div>
        <div class="flex w-full items-center justify-between gap-x-3">
            <div class="flex flex-col gap-y-1">
                <label for="nic" class="font-medium">NIC Number *</label>
                <input type="text" name="nic" id="nic" placeholder="Enter Your NIC Number" value="${param.nic}"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
            <div class="flex flex-col gap-y-1">
                <label for="username" class="font-medium">Username *</label>
                <input type="text" name="username" id="username" placeholder="Enter Your Username"
                       value="${param.username}"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
        </div>
        <div class="flex w-full items-center justify-between gap-x-3">
            <div class="flex flex-col gap-y-1">
                <label for="password" class="font-medium">Password *</label>
                <input type="password" name="password" id="password" placeholder="Enter Your Password"
                       value="${param.password}"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
            <div class="flex flex-col gap-y-1">
                <label for="otp" class="font-medium">Password *</label>
                <input type="text" name="otp" id="otp" placeholder="Enter Your OTP"
                       value="${param.otp}"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
        </div>

        <c:if test="${not empty errors}">
            <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3">
                <strong class="font-bold">Please correct the following errors:</strong>
                <ul class="list-disc ml-5 mt-2">
                    <c:forEach var="entry" items="${errors}">
                        <li class="max-w-sm">${entry.value}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <div class="text-center mt-4">
            <button type="submit"
                    class="bg-[#16A34A] text-white font-medium py-1.5 px-20 rounded-md hover:bg-[#28914e] cursor-pointer">
                Register
            </button>
        </div>
        <div class="flex items-center mt-3 gap-x-3">
            <span>Already have an account?</span>
            <a href="${pageContext.request.contextPath}/auth/login.jsp"
               class="text-blue-400 hover:text-blue-600 font-medium">Login</a>
        </div>
    </form>
</main>
</body>
</html>
