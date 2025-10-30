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
    <title>National Bank | Page Not Found</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body class="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-green-50 flex items-center justify-center">
    <!-- Background Elements -->
    <div class="absolute inset-0 overflow-hidden">
        <div class="absolute top-20 left-10 w-72 h-72 bg-red-300/20 rounded-full blur-3xl animate-pulse"></div>
        <div class="absolute bottom-20 right-10 w-96 h-96 bg-orange-300/20 rounded-full blur-3xl animate-pulse delay-1000"></div>
    </div>

    <div class="relative text-center max-w-lg p-8 animate-fade-in">
        <!-- Logo -->
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-red-500 to-red-600 rounded-2xl shadow-lg mb-8">
            <span class="material-symbols-outlined text-white text-2xl">error</span>
        </div>
        
        <!-- Error Code -->
        <h1 class="text-8xl font-bold text-display text-gradient mb-4 animate-slide-up">404</h1>
        
        <!-- Error Message -->
        <h2 class="text-3xl font-bold text-neutral-800 mb-4 animate-slide-up">Page Not Found</h2>
        
        <p class="text-lg text-neutral-600 mb-8 leading-relaxed animate-slide-up">
            Oops! The page you're looking for seems to have wandered off. 
            It might have been moved, deleted, or you might have entered the wrong URL.
        </p>
        
        <!-- Action Buttons -->
        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center animate-scale-in">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="btn btn-primary px-8 py-3 text-lg rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                <span class="material-symbols-outlined mr-2">home</span>
                Go Home
            </a>
            <a href="${pageContext.request.contextPath}/auth/login.jsp"
               class="btn btn-outline px-8 py-3 text-lg rounded-xl hover:bg-green-50">
                <span class="material-symbols-outlined mr-2">login</span>
                Sign In
            </a>
        </div>
        
        <!-- Help Text -->
        <div class="mt-8 p-4 bg-blue-50 border border-blue-200 rounded-xl animate-slide-up">
            <div class="flex items-center justify-center mb-2">
                <span class="material-symbols-outlined text-blue-600 mr-2">help</span>
                <h3 class="font-semibold text-blue-800">Need Help?</h3>
            </div>
            <p class="text-sm text-blue-700">
                If you believe this is an error, please contact our support team or try refreshing the page.
            </p>
        </div>
    </div>
</body>
</html>
