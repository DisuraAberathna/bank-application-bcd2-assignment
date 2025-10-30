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
    <title>National Bank | Register</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body class="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-green-50">
    <!-- Background Elements -->
    <div class="absolute inset-0 overflow-hidden">
        <div class="absolute top-20 left-10 w-72 h-72 bg-green-300/20 rounded-full blur-3xl animate-pulse"></div>
        <div class="absolute bottom-20 right-10 w-96 h-96 bg-blue-300/20 rounded-full blur-3xl animate-pulse delay-1000"></div>
    </div>

    <main class="relative min-h-screen flex items-center justify-center p-4 py-8">
        <div class="w-full max-w-2xl">
            <!-- Logo and Header -->
            <div class="text-center mb-5 animate-fade-in">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-2xl shadow-lg mb-3">
                    <span class="material-symbols-outlined text-white text-2xl">person_add</span>
                </div>
                <h1 class="text-3xl font-bold text-display text-gradient mb-2">Create Account</h1>
                <p class="text-neutral-600">Join National Bank and start your financial journey</p>
            </div>

            <!-- Registration Form -->
            <div class="card card-hover p-8 animate-slide-up">
                <form action="${pageContext.request.contextPath}/auth/register" method="post" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2 flex flex-col">
                            <label for="nic" class="form-label flex">
                                <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">badge</span>
                                NIC Number *
                            </label>
                            <input type="text" 
                                   name="nic" 
                                   id="nic" 
                                   placeholder="Enter your NIC number" 
                                   value="${param.nic}"
                                   class="form-input rounded-lg border-2 border-stone-400 px-3 py-2 w-full"
                                   required/>
                        </div>
                        
                        <div class="space-y-2 flex flex-col">
                            <label for="username" class="form-label flex">
                                <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">person</span>
                                Username *
                            </label>
                            <input type="text" 
                                   name="username" 
                                   id="username" 
                                   placeholder="Choose a username"
                                   value="${param.username}"
                                   class="form-input rounded-lg border-2 border-stone-400 px-3 py-2 w-full"
                                   required/>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2 flex flex-col">
                            <label for="password" class="form-label flex">
                                <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">lock</span>
                                Password *
                            </label>
                            <div class="relative flex">
                                <input type="password" 
                                       name="password" 
                                       id="password" 
                                       placeholder="Create a strong password"
                                       value="${param.password}"
                                       class="form-input rounded-lg border-2 border-stone-400 px-3 py-2 w-full"
                                       required/>
                                <button type="button" 
                                        onclick="togglePassword('password')"
                                        class="absolute right-3 top-1/2 -translate-y-1/2 text-neutral-400 hover:text-neutral-600 transition-colors rounded-lg p-0.5 cursor-pointer">
                                    <span class="material-symbols-outlined text-sm" id="password-icon">visibility</span>
                                </button>
                            </div>
                        </div>
                        
                        <div class="space-y-2 flex flex-col">
                            <label for="otp" class="form-label flex">
                                <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">key</span>
                                OTP *
                            </label>
                            <input type="text" 
                                   name="otp" 
                                   id="otp" 
                                   placeholder="Enter OTP from SMS/Email"
                                   value="${param.otp}"
                                   class="form-input rounded-lg border-2 border-stone-400 px-3 py-2 w-full"
                                   required/>
                        </div>
                    </div>

                    <!-- Password Requirements -->
                    <div class="bg-blue-50 border border-blue-200 bg-blue-200/20 rounded-lg p-3">
                        <div class="flex items-start">
                            <span class="material-symbols-outlined text-blue-500 mr-2 mt-0.5">info</span>
                            <div>
                                <h4 class="font-semibold text-blue-800 mb-2">Password Requirements:</h4>
                                <ul class="text-sm text-blue-700 space-y-1">
                                    <li>• At least 8 characters long</li>
                                    <li>• Include uppercase and lowercase letters</li>
                                    <li>• Include at least one number</li>
                                    <li>• Include at least one special character</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Error Messages -->
                    <c:if test="${not empty errors}">
                        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg animate-scale-in">
                            <div class="flex items-start">
                                <span class="material-symbols-outlined text-red-500 mr-2 mt-0.5">error</span>
                                <div>
                                    <strong class="font-semibold">Please correct the following errors:</strong>
                                    <ul class="list-disc ml-5 mt-2 space-y-1">
                                        <c:forEach var="entry" items="${errors}">
                                            <li class="text-sm">${entry.value}</li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Terms and Conditions -->
                    <div class="flex items-center space-x-3">
                        <input type="checkbox" 
                               id="terms" 
                               name="terms" 
                               class="mt-1 w-4 h-4 text-green-600 border-neutral-300 focus:ring-green-500 rounded-lg cursor-pointer"
                               required/>
                        <label for="terms" class="text-sm text-neutral-600">
                            I agree to the <a href="#" class="text-green-600 hover:text-green-700 underline">Terms of Service</a> 
                            and <a href="#" class="text-green-600 hover:text-green-700 underline">Privacy Policy</a>
                        </label>
                    </div>

                    <!-- Register Button -->
                    <button type="submit" 
                            class="btn bg-gradient-to-tr from-green-500 to-green-600 text-white w-full py-3 text-lg rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-300 flex justify-center items-center">
                        <span class="material-symbols-outlined mr-2">person_add</span>
                        Create Account
                    </button>

                    <!-- Divider -->
                    <div class="relative">
                        <div class="absolute inset-0 flex items-center">
                            <div class="w-full border-t border-neutral-300"></div>
                        </div>
                        <div class="relative flex justify-center text-sm">
                            <span class="px-2 bg-gradient-to-br from-slate-50 via-blue-50 to-green-50 text-neutral-500">Already have an account?</span>
                        </div>
                    </div>

                    <!-- Login Link -->
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/auth/login.jsp"
                           class="btn btn-outline w-full py-3 text-lg rounded-xl hover:bg-green-50 flex justify-center items-center">
                            <span class="material-symbols-outlined mr-2">login</span>
                            Sign In Instead
                        </a>
                    </div>
                </form>
            </div>

            <!-- Back to Home -->
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/index.jsp"
                   class="text-neutral-600 hover:text-green-600 transition-colors inline-flex items-center px-3 py-2 rounded-lg">
                    <span class="material-symbols-outlined text-sm mr-1">arrow_back</span>
                    Back to Home
                </a>
            </div>
        </div>
    </main>

    <script>
        function togglePassword(inputId) {
            const passwordInput = document.getElementById(inputId);
            const passwordIcon = document.getElementById('password-icon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                passwordIcon.textContent = 'visibility_off';
            } else {
                passwordInput.type = 'password';
                passwordIcon.textContent = 'visibility';
            }
        }
    </script>
</body>
</html>
