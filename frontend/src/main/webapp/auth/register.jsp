<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/5/2025
  Time: 4:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <label for="firstName" class="font-medium">First Name *</label>
                <input type="text" name="firstName" id="firstName" placeholder="Enter Your First Name"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
            <div class="flex flex-col gap-y-1">
                <label for="lastName" class="font-medium">Last Name *</label>
                <input type="text" name="lastName" id="lastName" placeholder="Enter Your Last Name"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
        </div>
        <div class="flex flex-col gap-y-1">
            <label for="email" class="font-medium">Email Address *</label>
            <input type="email" name="email" id="email" placeholder="Enter Your Email Address"
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
        </div>
        <div class="flex flex-col gap-y-1">
            <label for="mobile" class="font-medium">Mobile Number *</label>
            <input type="text" name="mobile" id="mobile" placeholder="Enter Your Mobile Number"
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
        </div>
        <div class="flex w-full items-center justify-between gap-x-3">
            <div class="flex flex-col gap-y-1">
                <label for="username" class="font-medium">Username *</label>
                <input type="text" name="username" id="username" placeholder="Enter Your Username"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
            <div class="flex flex-col gap-y-1">
                <label for="password" class="font-medium">Password *</label>
                <input type="password" name="password" id="password" placeholder="Enter Your Password"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
        </div>
        <div class="text-center mt-6">
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
